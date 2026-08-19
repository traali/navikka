import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sakkoja/core/constants/map_constants.dart';
import 'package:sakkoja/core/utils/logger.dart';

class SafeTileProvider extends TileProvider {
  SafeTileProvider({required this.dio, this.userAgent});
  final Dio dio;
  final String? userAgent;

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    final url = getTileUrl(coordinates, options);
    if (url.isEmpty) {
      return _ErrorImageProvider(
        decode: (decode) async => _transparentCodec(decode),
      );
    }
    return _SafeTileImageProvider(
      url: url,
      dio: dio,
      userAgent: userAgent,
    );
  }
}

class _SafeTileImageProvider extends ImageProvider<_SafeTileImageProvider> {
  _SafeTileImageProvider({
    required this.url,
    required this.dio,
    this.userAgent,
  });
  final String url;
  final Dio dio;
  final String? userAgent;

  @override
  Future<_SafeTileImageProvider> obtainKey(ImageConfiguration config) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter loadImage(
    _SafeTileImageProvider key,
    ImageDecoderCallback decode,
  ) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1,
    );
  }

  Future<ui.Codec> _loadAsync(ImageDecoderCallback decode) async {
    try {
      final response = await dio.get<Uint8List>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            if (!kIsWeb && userAgent != null) 'User-Agent': userAgent,
          },
        ),
      );

      if (response.data != null && _isValidImage(response.data!)) {
        return decode(
          await ui.ImmutableBuffer.fromUint8List(response.data!),
        );
      }
    } catch (error, stackTrace) {
      Log.w('WMS tile request failed for $url', error, stackTrace);
    }

    return _transparentCodec(decode);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _SafeTileImageProvider && other.url == url;

  @override
  int get hashCode => url.hashCode;
}

class _ErrorImageProvider extends ImageProvider<_ErrorImageProvider> {
  _ErrorImageProvider({required this.decode});
  final Future<ui.Codec> Function(ImageDecoderCallback) decode;

  @override
  Future<_ErrorImageProvider> obtainKey(ImageConfiguration config) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter loadImage(
    _ErrorImageProvider key,
    ImageDecoderCallback decoder,
  ) {
    return MultiFrameImageStreamCompleter(
      codec: decode(decoder),
      scale: 1,
    );
  }
}

bool _isValidImage(Uint8List data) {
  if (data.length < 4) return false;
  final h3 = data[0] << 16 | data[1] << 8 | data[2];
  if (h3 == 0x89504E) return true;
  if (h3 == 0xFFD8FF) return true;
  if (data.length >= 12 &&
      data[0] == 0x52 &&
      data[1] == 0x49 &&
      data[2] == 0x46 &&
      data[3] == 0x46 &&
      data[8] == 0x57 &&
      data[9] == 0x45 &&
      data[10] == 0x42 &&
      data[11] == 0x50) {
    return true;
  }
  if (h3 == 0x474946) return true;
  return false;
}

Future<ui.Codec> _transparentCodec(ImageDecoderCallback decode) async {
  return decode(
    await ui.ImmutableBuffer.fromUint8List(MapConstants.transparentTile),
  );
}
