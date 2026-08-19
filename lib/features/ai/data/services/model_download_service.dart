import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/config/env.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/emulator_check.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'model_download_service.g.dart';

enum DownloadStatus { notDownloaded, checkingWifi, downloading, ready, error }

class ModelDownloadState {
  const ModelDownloadState({
    required this.status,
    this.progress = 0.0,
    this.errorMessage,
  });

  factory ModelDownloadState.notDownloaded() =>
      const ModelDownloadState(status: DownloadStatus.notDownloaded);
  final DownloadStatus status;
  final double progress; // 0.0 to 1.0
  final String? errorMessage;

  ModelDownloadState copyWith({
    DownloadStatus? status,
    double? progress,
    String? errorMessage,
  }) {
    return ModelDownloadState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage,
    );
  }
}

@Riverpod(keepAlive: true)
class ModelDownloadService extends _$ModelDownloadService {
  static String get _kModelUrl => Env.aiModelUrl;
  static const _kModelFileName = 'gemma-3-1b-it-gpu-int4.bin';
  static const _completionMetadataSuffix = '.complete.json';

  late final Dio _dio;
  bool _isDisposed = false;

  @override
  ModelDownloadState build() {
    _isDisposed = false;
    _dio = ref.watch(dioProvider);
    ref.onDispose(() {
      _isDisposed = true;
    });
    // Fire and forget
    Future.microtask(_checkStatus);
    return const ModelDownloadState(status: DownloadStatus.notDownloaded);
  }

  Future<void> _checkStatus() async {
    if (kIsWeb) return;
    try {
      final path = await _getModelPath();
      if (_isDisposed) return;
      if (await _isCompleteModel(path)) {
        if (_isDisposed) return;
        state = const ModelDownloadState(
          status: DownloadStatus.ready,
          progress: 1,
        );
      } else {
        state = const ModelDownloadState(status: DownloadStatus.notDownloaded);
      }
    } catch (e, s) {
      Log.w('[ModelDownload] init failed', e, s);
      state = ModelDownloadState(
        status: DownloadStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  String _getCompletionMetadataPath(String modelPath) =>
      '$modelPath$_completionMetadataSuffix';

  Future<bool> _isCompleteModel(String modelPath) async {
    final modelFile = File(modelPath);
    final metadataFile = File(_getCompletionMetadataPath(modelPath));
    if (!await modelFile.exists() || !await metadataFile.exists()) {
      return false;
    }

    try {
      final metadata = jsonDecode(await metadataFile.readAsString());
      final expectedLength = metadata['length'];
      if (expectedLength is! int || expectedLength <= 0) {
        return false;
      }
      return await modelFile.length() == expectedLength;
    } on Object {
      return false;
    }
  }

  Future<String> _getModelPath() async {
    final dir = await getApplicationDocumentsDirectory();
    // Use slightly different name for mock to avoid collision if they switch devices
    if (await EmulatorCheck.isEmulator) {
      return '${dir.path}/mock_gemma_model.bin';
    }
    return '${dir.path}/$_kModelFileName';
  }

  Future<void> downloadModel({bool ignoreWifi = false}) async {
    if (kIsWeb) return;
    if (state.status == DownloadStatus.downloading) return;

    if (_kModelUrl.isEmpty) {
      state = state.copyWith(
        status: DownloadStatus.error,
        errorMessage: 'AI model URL not configured. Set AI_MODEL_URL env var.',
      );
      return;
    }

    try {
      // 1. Check Connectivity
      if (!ignoreWifi) {
        state = state.copyWith(status: DownloadStatus.checkingWifi);
        final connectivity = await Connectivity().checkConnectivity();
        final isWifi =
            connectivity.contains(ConnectivityResult.wifi) ||
            connectivity.contains(ConnectivityResult.ethernet);

        if (!isWifi) {
          state = state.copyWith(
            status: DownloadStatus.error,
            errorMessage: 'Wi-Fi required. Toggle setting to override.',
          );
          return;
        }
      }

      // 2. Start Download
      final savePath = await _getModelPath();
      final temporaryPath = '$savePath.part';
      final temporaryFile = File(temporaryPath);
      final metadataPath = _getCompletionMetadataPath(savePath);
      final temporaryMetadataFile = File('$metadataPath.part');
      state = state.copyWith(status: DownloadStatus.downloading, progress: 0);
      if (await temporaryFile.exists()) {
        await temporaryFile.delete();
      }
      if (await temporaryMetadataFile.exists()) {
        await temporaryMetadataFile.delete();
      }

      int? expectedLength;

      if (await EmulatorCheck.isEmulator) {
        // Mock download for emulator
        for (var i = 0; i <= 10; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          state = state.copyWith(
            status: DownloadStatus.downloading,
            progress: i / 10,
          );
        }
        await temporaryFile.writeAsBytes(const [1]);
      } else {
        await _dio.download(
          _kModelUrl,
          temporaryPath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              expectedLength = total;
              final progress = received / total;
              // Throttle state updates to avoid rebuild spam
              if ((progress - state.progress).abs() > 0.01 || progress == 1.0) {
                state = state.copyWith(
                  status: DownloadStatus.downloading,
                  progress: progress,
                );
              }
            }
          },
        );
      }

      final actualLength = await temporaryFile.length();
      if (actualLength == 0) {
        throw StateError('Downloaded model is empty');
      }
      if (expectedLength != null && actualLength != expectedLength) {
        throw StateError(
          'Downloaded model is incomplete: $actualLength/$expectedLength bytes',
        );
      }

      // Only replace the final file after the complete temporary file passes
      // validation. Both paths are in the same application directory.
      await temporaryFile.rename(savePath);
      await temporaryMetadataFile.writeAsString(
        jsonEncode(<String, int>{'length': actualLength}),
        flush: true,
      );
      await temporaryMetadataFile.rename(metadataPath);

      state = const ModelDownloadState(
        status: DownloadStatus.ready,
        progress: 1,
      );
    } catch (e, s) {
      Log.w('[ModelDownload] download failed', e, s);
      // Cleanup only the temporary file. A previously valid final model must
      // remain available when a replacement download fails.
      try {
        final savePath = await _getModelPath();
        final temporaryFile = File('$savePath.part');
        if (await temporaryFile.exists()) {
          await temporaryFile.delete();
        }
        final metadataPath = _getCompletionMetadataPath(savePath);
        final temporaryMetadataFile = File('$metadataPath.part');
        if (await temporaryMetadataFile.exists()) {
          await temporaryMetadataFile.delete();
        }
      } catch (_) {
        /* ignore cleanup errors */
      }

      state = state.copyWith(
        status: DownloadStatus.error,
        errorMessage: 'Download failed: $e',
      );
    }
  }

  Future<void> deleteModel() async {
    if (kIsWeb) return;
    try {
      final path = await _getModelPath();
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
      final temporaryFile = File('$path.part');
      if (await temporaryFile.exists()) {
        await temporaryFile.delete();
      }
      final metadataPath = _getCompletionMetadataPath(path);
      final temporaryMetadataFile = File('$metadataPath.part');
      if (await temporaryMetadataFile.exists()) {
        await temporaryMetadataFile.delete();
      }
      final metadataFile = File(metadataPath);
      if (await metadataFile.exists()) {
        await metadataFile.delete();
      }
      state = const ModelDownloadState(status: DownloadStatus.notDownloaded);
    } catch (e, s) {
      Log.w('[ModelDownload] delete failed', e, s);
      state = state.copyWith(
        status: DownloadStatus.error,
        errorMessage: 'Delete failed: $e',
      );
    }
  }

  Future<String?> getModelPathIfReady() async {
    if (state.status == DownloadStatus.ready) {
      final path = await _getModelPath();
      if (await _isCompleteModel(path)) {
        return path;
      }
      state = const ModelDownloadState(status: DownloadStatus.notDownloaded);
    }
    return null;
  }
}
