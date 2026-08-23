import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ais/data/datasources/digitraffic_ais_remote_data_source.dart';
import 'package:sakkoja/features/ais/data/models/digitraffic_geojson_dto.dart';
import 'package:sakkoja/features/ais/data/repositories/ais_repository_impl.dart';
import 'package:sakkoja/features/ais/data/stores/drift_ais_store.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';

class FakeDigitrafficAisRemoteDataSource
    implements DigitrafficAisRemoteDataSource {
  DigitrafficFeatureCollectionDto? responseToReturn;
  bool shouldThrow = false;
  double? lastLatitude;
  double? lastLongitude;
  double? lastRadiusKm;

  @override
  Future<DigitrafficFeatureCollectionDto> fetchAisLocations({
    CancelToken? cancelToken,
    required double latitude,
    required double longitude,
    double? radiusKm,
  }) async {
    lastLatitude = latitude;
    lastLongitude = longitude;
    lastRadiusKm = radiusKm;
    if (shouldThrow) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Network error',
      );
    }
    return responseToReturn ??
        const DigitrafficFeatureCollectionDto(
          type: 'FeatureCollection',
          features: [],
        );
  }
}

void main() {
  late FakeDigitrafficAisRemoteDataSource fakeRemoteDataSource;
  late AisMetadataStore store;
  late AisRepositoryImpl repository;

  setUp(() {
    fakeRemoteDataSource = FakeDigitrafficAisRemoteDataSource();
    store = AisMetadataStore();
    repository = AisRepositoryImpl(fakeRemoteDataSource, store);
  });

  group('AisRepositoryImpl Test Suite', () {
    test('Parses GeoJSON features and filters by bounding box', () async {
      fakeRemoteDataSource.responseToReturn = DigitrafficFeatureCollectionDto(
        type: 'FeatureCollection',
        features: [
          DigitrafficFeatureDto(
            type: 'Feature',
            geometry: const DigitrafficGeometryDto(
              type: 'Point',
              coordinates: [24.94, 60.16], // Inside Helsinki bounds
            ),
            properties: const DigitrafficPropertiesDto(
              mmsi: 230111222,
              sog: 14.2,
              cog: 180.0,
              heading: 180.0,
              navStatus: 0,
              timestampMs: 1716300000000,
              name: 'VIKING GRACE',
              shipType: 60, // Passenger
            ),
          ),
          DigitrafficFeatureDto(
            type: 'Feature',
            geometry: const DigitrafficGeometryDto(
              type: 'Point',
              coordinates: [10.0, 50.0], // Outside bounds
            ),
            properties: const DigitrafficPropertiesDto(
              mmsi: 999999999,
              sog: 5.0,
              cog: 0.0,
              navStatus: 0,
              timestampMs: 1716300000000,
            ),
          ),
        ],
      );

      final result = await repository.getAisTargetsInBounds(
        southWest: const LatLng(59.0, 20.0),
        northEast: const LatLng(61.0, 26.0),
      );

      expect(result.isRight(), isTrue);
      final targets = result.getOrElse((_) => []);
      expect(targets.length, equals(1));

      final target = targets.first;
      expect(target.mmsi, equals(230111222));
      expect(target.name, equals('VIKING GRACE'));
      expect(target.category, equals(ShipCategory.passenger));
      expect(target.position.latitude, equals(60.16));
      expect(target.position.longitude, equals(24.94));
      expect(fakeRemoteDataSource.lastLatitude, isNotNull);
      expect(fakeRemoteDataSource.lastLongitude, isNotNull);
      expect(fakeRemoteDataSource.lastRadiusKm, equals(45));
    });
  });
}
