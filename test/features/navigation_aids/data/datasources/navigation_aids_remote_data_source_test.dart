import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/errors/exceptions.dart';
import 'package:sakkoja/features/navigation_aids/data/datasources/navigation_aids_remote_data_source.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;

  Map<String, dynamic> feature(String id, double longitude) {
    return {
      'id': id,
      'properties': <String, dynamic>{},
      'geometry': {
        'type': 'Point',
        'coordinates': [longitude, 60.0],
      },
    };
  }

  Response<dynamic> response(
    List<Map<String, dynamic>> features, {
    required int matched,
  }) {
    return Response<dynamic>(
      requestOptions: RequestOptions(path: '/wfs'),
      statusCode: 200,
      data: {
        'type': 'FeatureCollection',
        'numberMatched': matched,
        'numberReturned': features.length,
        'features': features,
      },
    );
  }

  setUp(() {
    dio = MockDio();
  });

  test('advances startIndex and returns every WFS page', () async {
    final requestedIndexes = <int>[];
    when(
      () => dio.get<dynamic>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      final query =
          invocation.namedArguments[#queryParameters] as Map<String, dynamic>;
      final startIndex = query['startIndex'] as int;
      requestedIndexes.add(startIndex);
      return startIndex == 0
          ? response([feature('a', 24), feature('b', 24.1)], matched: 3)
          : response([feature('c', 24.2)], matched: 3);
    });
    final source = NavigationAidsRemoteDataSourceImpl(
      dio,
      pageSize: 2,
      maxPages: 4,
    );

    final result = await source.fetchTrafficSigns();

    expect(result.map((item) => item.id), ['a', 'b', 'c']);
    expect(requestedIndexes, [0, 2]);
  });

  test('rejects a repeated full page instead of looping forever', () async {
    var requestCount = 0;
    when(
      () => dio.get<dynamic>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async {
      requestCount++;
      return response(
        [feature('a', 24), feature('b', 24.1)],
        matched: 10,
      );
    });
    final source = NavigationAidsRemoteDataSourceImpl(
      dio,
      pageSize: 2,
      maxPages: 4,
    );

    await expectLater(
      source.fetchTrafficSigns(),
      throwsA(isA<ServerException>()),
    );
    expect(requestCount, 2);
  });
}
