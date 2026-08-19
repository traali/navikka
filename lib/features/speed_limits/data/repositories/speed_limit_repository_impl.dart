import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/speed_limits/data/datasources/speed_limit_local_data_source.dart';
import 'package:sakkoja/features/speed_limits/data/datasources/speed_limit_remote_data_source.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart';
import 'package:sakkoja/features/speed_limits/domain/repositories/speed_limit_repository.dart';

class SpeedLimitRepositoryImpl implements SpeedLimitRepository {
  SpeedLimitRepositoryImpl(this._remoteDataSource, this._localDataSource);
  final SpeedLimitRemoteDataSource _remoteDataSource;
  final SpeedLimitLocalDataSource _localDataSource;

  // Simple in-memory cache
  List<SpeedLimitZone>? _memoryCache;

  // Increment this version to force a reload from assets
  static const int kAssetVersion = 1;

  @override
  Future<Either<Failure, List<SpeedLimitZone>>> getSpeedLimits() async {
    // 1. Memory Cache
    if (_memoryCache != null && _memoryCache!.isNotEmpty) {
      return Right(_memoryCache!);
    }

    try {
      // 2. Load from Assets (Optimized Isolate Loader)
      // We skip local DB for now as we want "Full Source of Truth" from the bundled file.
      // If we need persistence of *updates*, we'd check DB first.
      // For this specific request "Use full dataset as primary", we load assets.

      Log.d('SpeedLimitRepository: Loading full dataset from assets...');
      final assetData = await _localDataSource.loadFromAssets();

      if (assetData.isNotEmpty) {
        _memoryCache = assetData;
        Log.d(
          'SpeedLimitRepository: Loaded and cached ${assetData.length} zones.',
        );
        return Right(assetData);
      }

      return const Left(ServerFailure('No local data found.'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SpeedLimitZone>>> getSpeedLimitsWithBBox(
    BBox bbox,
  ) async {
    // OLD: Online fetching -> "Broken".
    // NEW: Return from local cache, filtered by BBox for efficiency contract.

    final result = await getSpeedLimits();

    return result.map((allZones) {
      // Simple BBox filtering (optional, but polite to the caller)
      // The UI does viewport culling anyway.
      return allZones.where((zone) {
        return zone.boundingBox.overlaps(
          BBox(
            minLat: bbox.minLat,
            maxLat: bbox.maxLat,
            minLon: bbox.minLon,
            maxLon: bbox.maxLon,
          ),
        );
      }).toList();
    });
  }

  // Removed _checkForUpdatesInBackground

  @override
  Future<Either<Failure, List<TrafficSign>>> getTrafficSignsWithBBox(
    BBox bbox,
  ) async {
    try {
      // Same freshness logic could apply here, but keeping it simple for now.
      final remoteData = await _remoteDataSource.fetchTrafficSigns(bbox: bbox);
      if (remoteData.isNotEmpty) {
        final nearest = remoteData.first;
        final valueStr = nearest.value != null
            ? nearest.value!.toStringAsFixed(0)
            : '';
        final display = '${nearest.typeName} $valueStr'.trim();
        Log.i(
          '[SUCCESS] Radar: Found ${remoteData.length} signs (Nearest: $display)',
        );
      }
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
