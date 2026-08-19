import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ais/data/datasources/digitraffic_ais_remote_data_source.dart';
import 'package:sakkoja/features/ais/data/stores/drift_ais_store.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';
import 'package:sakkoja/features/ais/domain/repositories/ais_repository.dart';

part 'ais_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AisRepository aisRepository(Ref ref) {
  final remoteDataSource = ref.watch(digitrafficAisRemoteDataSourceProvider);
  final store = ref.watch(aisMetadataStoreProvider);
  return AisRepositoryImpl(remoteDataSource, store);
}

class AisRepositoryImpl implements AisRepository {
  final DigitrafficAisRemoteDataSource _remoteDataSource;
  final AisMetadataStore _metadataStore;

  AisRepositoryImpl(this._remoteDataSource, this._metadataStore);

  @override
  Future<Either<Failure, List<AisTarget>>> getAisTargetsInBounds({
    required LatLng southWest,
    required LatLng northEast,
  }) async {
    try {
      final featureCollection = await _remoteDataSource.fetchAisLocations();

      final targets = <AisTarget>[];
      final now = DateTime.now();

      for (final feature in featureCollection.features) {
        final lat = feature.geometry.latitude;
        final lon = feature.geometry.longitude;

        // Bounding box spatial filter
        if (lat < southWest.latitude ||
            lat > northEast.latitude ||
            lon < southWest.longitude ||
            lon > northEast.longitude) {
          continue;
        }

        final props = feature.properties;
        final cached = _metadataStore.getMetadata(props.mmsi);

        final name = props.name ?? cached?.name ?? 'MMSI ${props.mmsi}';
        final shipTypeCode = props.shipType ?? cached?.shipType ?? 0;

        // Cache static metadata if present
        if (props.name != null || props.shipType != null) {
          _metadataStore.putMetadata(
            CachedVesselMetadata(
              mmsi: props.mmsi,
              name: props.name,
              shipType: props.shipType,
            ),
          );
        }

        final category = _mapShipCategory(shipTypeCode);
        final isMooredOrAnchored = props.navStatus == 1 || props.navStatus == 5;
        final timestamp = DateTime.fromMillisecondsSinceEpoch(
          props.timestampMs ?? DateTime.now().millisecondsSinceEpoch,
        );

        targets.add(
          AisTarget(
            mmsi: props.mmsi,
            name: name,
            position: LatLng(lat, lon),
            speedKnots: props.sog,
            courseDegrees: props.cog,
            headingDegrees: (props.heading != null && props.heading! < 360.0)
                ? props.heading
                : null,
            category: category,
            isMooredOrAnchored: isMooredOrAnchored,
            lastReported: timestamp.year > 2000 ? timestamp : now,
          ),
        );
      }

      return Right(targets);
    } on DioException catch (e) {
      Log.e('Network error fetching AIS targets', e);
      return Left(NetworkFailure('Failed to fetch AIS data: ${e.message}'));
    } catch (e, stackTrace) {
      Log.e('Unexpected error parsing AIS data', e, stackTrace);
      return Left(GeneralFailure('Error processing AIS data: $e'));
    }
  }

  ShipCategory _mapShipCategory(int code) {
    if (code >= 60 && code <= 69) return ShipCategory.passenger;
    if (code >= 70 && code <= 79) return ShipCategory.cargo;
    if (code >= 80 && code <= 89) return ShipCategory.tanker;
    if (code == 52) return ShipCategory.tug;
    if (code == 36 || code == 37) return ShipCategory.sailing;
    if (code >= 30 && code <= 35) return ShipCategory.pleasure;
    if (code == 30) return ShipCategory.fishing;
    return ShipCategory.unknown;
  }
}
