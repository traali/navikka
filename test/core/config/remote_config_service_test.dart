import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/config/remote_config_service.dart';
import 'package:sakkoja/features/fishing/domain/entities/keyword_config.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late CloudflareRemoteConfigService service;

  setUp(() {
    mockDio = MockDio();
    service = CloudflareRemoteConfigService(
      dio: mockDio,
      baseUrl: 'https://test-proxy.local',
    );
  });

  group('CloudflareRemoteConfigService', () {
    test('returns parsed KeywordConfig when Dio returns Map', () async {
      when(
        () => mockDio.get<dynamic>(any(), options: any(named: 'options')),
      ).thenAnswer(
        (_) async => Response<dynamic>(
          requestOptions: RequestOptions(path: '/config'),
          statusCode: 200,
          data: {
            'version': 2,
            'categories': [
              {
                'id': 'yleinen',
                'label': 'Yleinen kalastus',
                'keywords': ['kalastus', 'pyynti'],
                'color': '#3B82F6',
                'icon': 'ph_fish',
              },
            ],
          },
        ),
      );

      final config = await service.fetchKeywordConfig();
      expect(config.version, equals(2));
      expect(config.categories.first.id, equals('yleinen'));
      expect(config.categories.first.keywords, contains('kalastus'));
    });

    test(
      'returns parsed KeywordConfig when Dio returns raw JSON String',
      () async {
        when(
          () => mockDio.get<dynamic>(any(), options: any(named: 'options')),
        ).thenAnswer(
          (_) async => Response<dynamic>(
            requestOptions: RequestOptions(path: '/config'),
            statusCode: 200,
            data:
                '{"version":3,"categories":[{"id":"lohi","label":"Lohikalat","keywords":["lohi","taimen"],"color":"#EF4444","icon":"ph_fish"}]}',
          ),
        );

        final config = await service.fetchKeywordConfig();
        expect(config.version, equals(3));
        expect(config.categories.first.id, equals('lohi'));
        expect(config.categories.first.keywords, contains('lohi'));
      },
    );

    test('returns fallback on network exception', () async {
      when(
        () => mockDio.get<dynamic>(any(), options: any(named: 'options')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/config'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final config = await service.fetchKeywordConfig();
      expect(config, equals(KeywordConfig.fallback));
    });

    test('caches config and does not call Dio on second fetch', () async {
      when(
        () => mockDio.get<dynamic>(any(), options: any(named: 'options')),
      ).thenAnswer(
        (_) async => Response<dynamic>(
          requestOptions: RequestOptions(path: '/config'),
          statusCode: 200,
          data: {'version': 2, 'categories': []},
        ),
      );

      final first = await service.fetchKeywordConfig();
      final second = await service.fetchKeywordConfig();

      expect(identical(first, second), isTrue);
      verify(
        () => mockDio.get<dynamic>(any(), options: any(named: 'options')),
      ).called(1);
    });

    test('clearCache forces fresh fetch', () async {
      when(
        () => mockDio.get<dynamic>(any(), options: any(named: 'options')),
      ).thenAnswer(
        (_) async => Response<dynamic>(
          requestOptions: RequestOptions(path: '/config'),
          statusCode: 200,
          data: {'version': 2, 'categories': []},
        ),
      );

      await service.fetchKeywordConfig();
      service.clearCache();
      await service.fetchKeywordConfig();

      verify(
        () => mockDio.get<dynamic>(any(), options: any(named: 'options')),
      ).called(2);
    });
  });
}
