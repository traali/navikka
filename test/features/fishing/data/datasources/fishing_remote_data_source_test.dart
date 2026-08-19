import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/errors/exceptions.dart';
import 'package:sakkoja/features/fishing/data/datasources/fishing_remote_data_source.dart';

class RecordingAdapter implements HttpClientAdapter {
  RecordingAdapter(this._responseFor);

  final Map<String, dynamic> Function(RequestOptions options) _responseFor;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(_responseFor(options)),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Map<String, dynamic> waterwayFeature(String layer, int index) => {
  'type': 'Feature',
  'id': '$layer-$index',
  'properties': {'name': '$layer $index'},
  'geometry': {
    'type': 'Point',
    'coordinates': [24 + index / 10000, 60],
  },
};

Map<String, dynamic> restrictionFeature(int index) => {
  'type': 'Feature',
  'id': 'restriction-$index',
  'properties': {'nimi': 'Restriction $index'},
  'geometry': {
    'type': 'Polygon',
    'coordinates': [
      [
        [24.0, 60.0],
        [24.01, 60.0],
        [24.01, 60.01],
        [24.0, 60.0],
      ],
    ],
  },
};

void main() {
  test('fetches every waterway WFS page for every layer', () async {
    final adapter = RecordingAdapter((options) {
      final layer = options.queryParameters['typeName']! as String;
      final startIndex = options.queryParameters['startIndex']! as int;
      final features = startIndex == 0
          ? List.generate(500, (index) => waterwayFeature(layer, index))
          : [waterwayFeature(layer, 500)];
      return {
        'type': 'FeatureCollection',
        'numberMatched': 501,
        'features': features,
      };
    });
    final source = FishingRemoteDataSourceImpl(
      Dio()..httpClientAdapter = adapter,
    );

    final result = await source.fetchWaterwayFeatures();

    expect(result, hasLength(1503));
    expect(adapter.requests, hasLength(6));
    for (final layer in ['tn-w:FairwayArea', 'tn-w:Beacon', 'tn-w:Buoy']) {
      final pageIndexes = adapter.requests
          .where((request) => request.queryParameters['typeName'] == layer)
          .map((request) => request.queryParameters['startIndex'])
          .toSet();
      expect(pageIndexes, {0, 500});
    }
  });

  test(
    'fails instead of returning a repeated full WFS page as complete',
    () async {
      final adapter = RecordingAdapter((options) {
        final layer = options.queryParameters['typeName']! as String;
        return {
          'type': 'FeatureCollection',
          'features': List.generate(
            500,
            (index) => waterwayFeature(layer, index),
          ),
        };
      });
      final source = FishingRemoteDataSourceImpl(
        Dio()..httpClientAdapter = adapter,
      );

      await expectLater(
        source.fetchWaterwayFeatures(),
        throwsA(isA<ServerException>()),
      );
      expect(
        adapter.requests.any(
          (request) => request.queryParameters['startIndex'] == 500,
        ),
        isTrue,
      );
    },
  );

  test('fetches every fishing restriction WFS page', () async {
    final adapter = RecordingAdapter((options) {
      final startIndex = options.queryParameters['startIndex']! as int;
      final features = startIndex == 0
          ? List.generate(500, restrictionFeature)
          : [restrictionFeature(500)];
      return {
        'type': 'FeatureCollection',
        'numberMatched': 501,
        'features': features,
      };
    });
    final source = FishingRemoteDataSourceImpl(
      Dio()..httpClientAdapter = adapter,
    );

    final result = await source.fetchFishingRestrictions();

    expect(result, hasLength(501));
    expect(
      adapter.requests
          .map((request) => request.queryParameters['startIndex'])
          .toList(),
      [0, 500],
    );
  });

  test('rejects a repeated fishing restriction page', () async {
    final adapter = RecordingAdapter(
      (options) => {
        'type': 'FeatureCollection',
        'features': List.generate(500, restrictionFeature),
      },
    );
    final source = FishingRemoteDataSourceImpl(
      Dio()..httpClientAdapter = adapter,
    );

    await expectLater(
      source.fetchFishingRestrictions(),
      throwsA(isA<ServerException>()),
    );
    expect(adapter.requests, hasLength(2));
  });
}
