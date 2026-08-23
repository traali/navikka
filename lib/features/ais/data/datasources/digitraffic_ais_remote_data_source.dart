import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/underway_fetch.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ais/data/models/digitraffic_geojson_dto.dart';

part 'digitraffic_ais_remote_data_source.g.dart';

abstract class DigitrafficAisRemoteDataSource {
  /// Digitraffic `/locations` without radius is the national dump.
  /// Always pass [latitude]/[longitude]/[radiusKm] underway.
  Future<DigitrafficFeatureCollectionDto> fetchAisLocations({
    CancelToken? cancelToken,
    required double latitude,
    required double longitude,
    double? radiusKm,
  });
}

@Riverpod(keepAlive: true)
DigitrafficAisRemoteDataSource digitrafficAisRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return DigitrafficAisRemoteDataSourceImpl(dio);
}

class DigitrafficAisRemoteDataSourceImpl
    implements DigitrafficAisRemoteDataSource {
  static const String _baseUrl =
      'https://meri.digitraffic.fi/api/ais/v1/locations';
  final Dio _dio;

  DigitrafficAisRemoteDataSourceImpl(this._dio);

  @override
  Future<DigitrafficFeatureCollectionDto> fetchAisLocations({
    CancelToken? cancelToken,
    required double latitude,
    required double longitude,
    double? radiusKm,
  }) async {
    try {
      final query = <String, dynamic>{
        'latitude': latitude.toStringAsFixed(3),
        'longitude': longitude.toStringAsFixed(3),
        'radius': (radiusKm ?? UnderwayFetch.aisRadiusKm).round().toString(),
      };
      final response = await _dio.get<Map<String, dynamic>>(
        _baseUrl,
        queryParameters: query,
        options: kIsWeb
            ? null
            : Options(
                headers: const {
                  'Digitraffic-User': 'Sakkoja/1.0',
                },
              ),
        cancelToken: cancelToken,
      );

      if (response.data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Empty response body from Digitraffic AIS API',
        );
      }

      return DigitrafficFeatureCollectionDto.fromJson(response.data!);
    } catch (e, stackTrace) {
      Log.e('Failed to fetch Digitraffic AIS locations', e, stackTrace);
      rethrow;
    }
  }
}
