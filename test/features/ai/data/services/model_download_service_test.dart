import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/ai/data/services/model_download_service.dart';

class _TestPathProvider extends PathProviderPlatform {
  _TestPathProvider(this.documentsPath);

  final String documentsPath;

  @override
  Future<String?> getApplicationDocumentsPath() async => documentsPath;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory documentsDirectory;
  late PathProviderPlatform previousPathProvider;

  setUp(() async {
    documentsDirectory = await Directory.systemTemp.createTemp(
      'model-download-test-',
    );
    previousPathProvider = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _TestPathProvider(
      documentsDirectory.path,
    );
  });

  tearDown(() async {
    PathProviderPlatform.instance = previousPathProvider;
    await documentsDirectory.delete(recursive: true);
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(Dio())],
    );
    addTearDown(container.dispose);
    return container;
  }

  String modelPath() =>
      documentsDirectory.uri.resolve('gemma-3-1b-it-gpu-int4.bin').toFilePath();

  String metadataPath(String path) => '$path.complete.json';

  test('legacy non-empty model without metadata is not ready', () async {
    await File(modelPath()).writeAsBytes([1, 2, 3]);

    final container = createContainer();
    container.read(modelDownloadServiceProvider);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(
      container.read(modelDownloadServiceProvider).status,
      DownloadStatus.notDownloaded,
    );
  });

  test('matching completion metadata makes the model ready', () async {
    final path = modelPath();
    await File(path).writeAsBytes([1, 2, 3]);
    await File(metadataPath(path)).writeAsString('{"length":3}');

    final container = createContainer();
    container.read(modelDownloadServiceProvider);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final service = container.read(modelDownloadServiceProvider);
    expect(service.status, DownloadStatus.ready);
    expect(
      await container
          .read(modelDownloadServiceProvider.notifier)
          .getModelPathIfReady(),
      endsWith('gemma-3-1b-it-gpu-int4.bin'),
    );
  });

  test('mismatched completion metadata is not ready', () async {
    final path = modelPath();
    await File(path).writeAsBytes([1, 2, 3]);
    await File(metadataPath(path)).writeAsString('{"length":4}');

    final container = createContainer();
    container.read(modelDownloadServiceProvider);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(
      container.read(modelDownloadServiceProvider).status,
      DownloadStatus.notDownloaded,
    );
  });
}
