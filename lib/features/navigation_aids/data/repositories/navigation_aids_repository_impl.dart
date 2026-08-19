import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/performance_tracker.dart';
import 'package:sakkoja/features/navigation_aids/data/datasources/navigation_aids_local_data_source.dart';
import 'package:sakkoja/features/navigation_aids/data/datasources/navigation_aids_remote_data_source.dart';
import 'package:sakkoja/features/navigation_aids/data/models/fairway_area_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_aid_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_aids_mappers.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_line_dto.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/fairway_area.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_line.dart';
import 'package:sakkoja/features/navigation_aids/domain/repositories/navigation_aids_repository.dart';

/// Implementation of [NavigationAidsRepository].
///
/// Strategy: Offline-First (In-Memory)
/// 1. Startup: Load all bundled assets into memory (via compute)
/// 2. Interaction: Serve all queries from memory (0-latency)
/// 3. Network: Disable live network fetching for map tiles (future: background sync)
class NavigationAidsRepositoryImpl implements NavigationAidsRepository {
  NavigationAidsRepositoryImpl(this._localDataSource, this._remoteDataSource);
  final NavigationAidsLocalDataSource _localDataSource;
  final NavigationAidsRemoteDataSource _remoteDataSource;

  // In-Memory Store
  List<FairwayArea>? _fairwayAreas;
  List<NavigationAid>? _navigationAids;
  List<NavigationLine>? _navigationLines;
  bool _isInitialized = false;
  Future<void>? _initializationFuture;

  /// Initializes the repository by loading bundled assets into memory.
  /// Should be called at app startup.
  Future<void> initialize() {
    if (_isInitialized) return Future<void>.value();

    return _initializationFuture ??= _initialize().whenComplete(() {
      _initializationFuture = null;
    });
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;

    return PerformanceTracker.traceAsync(
      'NavAids.Repository.initialize',
      () async {
        final sw = Stopwatch()..start();
        try {
          Log.d('NavAidsRepository: Initializing in-memory store...');

          // 1. Check local SQLite cache first
          final freshFairwayDtos = await _localDataSource.getFairwayAreas();
          final freshNavAidDtos = await _localDataSource.getNavigationAids();
          final freshNavLineDtos = await _localDataSource.getNavigationLines();

          if (_hasUsableData(freshFairwayDtos) &&
              _hasUsableData(freshNavAidDtos) &&
              _hasUsableData(freshNavLineDtos)) {
            _setInMemory(
              freshFairwayDtos!,
              freshNavAidDtos!,
              freshNavLineDtos!,
            );
            _isInitialized = true;
            _logInitialized(sw);
            return;
          }

          // 2. Instant Offline-First: Load bundled assets directly into memory
          final fairwayDtos = await _localDataSource
              .loadFairwayAreasFromAssets();
          final navAidDtos = await _localDataSource
              .loadNavigationAidsFromAssets();
          final navLineDtos = await _localDataSource
              .loadNavigationLinesFromAssets();

          _setInMemory(fairwayDtos, navAidDtos, navLineDtos);
          _isInitialized = true;
          _logInitialized(sw);

          // 3. Cache bundled data in local database asynchronously
          unawaited(_localDataSource.saveFairwayAreas(fairwayDtos));
          unawaited(_localDataSource.saveNavigationAids(navAidDtos));
          unawaited(_localDataSource.saveNavigationLines(navLineDtos));
        } catch (e, s) {
          Log.e('NavAidsRepository: Initialization failed', e, s);
          _fairwayAreas = [];
          _navigationAids = [];
          _navigationLines = [];
          _isInitialized = false;
        }
      },
    );
  }

  static bool _hasUsableData<T>(List<T>? data) {
    return data != null && data.isNotEmpty;
  }

  void _setInMemory(
    List<FairwayAreaDto> fairwayDtos,
    List<NavigationAidDto> navAidDtos,
    List<NavigationLineDto> navLineDtos,
  ) {
    _fairwayAreas = fairwayDtos.map((e) => e.toEntity()).toList();
    _navigationAids = navAidDtos.map((e) => e.toEntity()).toList();
    _navigationLines = navLineDtos.map((e) => e.toEntity()).toList();
  }

  void _logInitialized(Stopwatch sw) {
    Log.i(
      'NavAidsRepository: Initialized in ${sw.elapsedMilliseconds}ms. '
      'Loaded ${_fairwayAreas!.length} fairways, ${_navigationAids!.length} aids, ${_navigationLines!.length} lines.',
    );
  }

  /// Ensures data is loaded before querying.
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  @override
  Future<Either<Failure, List<FairwayArea>>> getFairwayAreas({
    BBox? bbox,
  }) async {
    await _ensureInitialized();

    final allAreas = _fairwayAreas ?? [];

    if (bbox == null) {
      return Right(allAreas);
    }

    // Filter by BBox (Linear Scan - Fast enough for <5k items)
    final sw = Stopwatch()..start();
    final filtered = allAreas.where((area) {
      // Check if area bounds overlap with query bbox
      if (area.bounds != null) {
        final areaBBox = BBox(
          minLon: area.bounds!.southWest.longitude,
          minLat: area.bounds!.southWest.latitude,
          maxLon: area.bounds!.northEast.longitude,
          maxLat: area.bounds!.northEast.latitude,
        );
        return bbox.overlaps(areaBBox);
      }
      return false;
    }).toList();

    if (filtered.isNotEmpty) {
      // Log only if lengthy (e.g. > 10ms), otherwise it spams
      if (sw.elapsedMilliseconds > 10) {
        Log.d(
          'NavAidsRepository: Query ${filtered.length} fairways in ${sw.elapsedMilliseconds}ms',
        );
      }
    }

    return Right(filtered);
  }

  @override
  Future<Either<Failure, List<NavigationAid>>> getNavigationAids({
    BBox? bbox,
  }) async {
    await _ensureInitialized();

    final allAids = _navigationAids ?? [];

    if (bbox == null) {
      // Warning: This might be huge, but allowed by interface
      return Right(allAids);
    }

    // Filter by BBox
    final sw = Stopwatch()..start();
    final filtered = allAids.where((aid) {
      return bbox.contains(
        lat: aid.position.latitude,
        lon: aid.position.longitude,
      );
    }).toList();

    // Log check
    if (sw.elapsedMilliseconds > 10) {
      Log.d(
        'NavAidsRepository: Query ${filtered.length} aids in ${sw.elapsedMilliseconds}ms',
      );
    }

    return Right(filtered);
  }

  @override
  Future<Either<Failure, List<NavigationLine>>> getNavigationLines({
    BBox? bbox,
  }) async {
    await _ensureInitialized();

    final allLines = _navigationLines ?? [];

    if (bbox == null) {
      return Right(allLines);
    }

    // Filter by BBox
    final sw = Stopwatch()..start();
    final filtered = allLines.where((line) {
      if (line.points.isEmpty) return false;
      return line.points.any(
        (p) => bbox.contains(lat: p.latitude, lon: p.longitude),
      );
    }).toList();

    if (sw.elapsedMilliseconds > 10) {
      Log.d(
        'NavAidsRepository: Query ${filtered.length} lines in ${sw.elapsedMilliseconds}ms',
      );
    }

    return Right(filtered);
  }

  @override
  Future<Either<Failure, void>> refreshData() async {
    try {
      Log.i('NavAidsRepository: Refreshing all navigation data from remote...');

      // Fetch in parallel
      final results = await Future.wait([
        _remoteDataSource.fetchFairwayAreas(),
        _remoteDataSource.fetchNavigationLines(),
        _remoteDataSource.fetchAllNavigationAids(),
      ]);

      final fairwayDtos = results[0] as List<FairwayAreaDto>;
      final lineDtos = results[1] as List<NavigationLineDto>;
      final aidDtos = results[2] as List<NavigationAidDto>;

      if (fairwayDtos.isEmpty || lineDtos.isEmpty || aidDtos.isEmpty) {
        throw StateError('Remote navigation data is incomplete');
      }

      // Save to cache
      await Future.wait([
        _localDataSource.saveFairwayAreas(fairwayDtos),
        _localDataSource.saveNavigationLines(lineDtos),
        _localDataSource.saveNavigationAids(aidDtos),
      ]);

      // Update in-memory
      _fairwayAreas = fairwayDtos.map((e) => e.toEntity()).toList();
      _navigationLines = lineDtos.map((e) => e.toEntity()).toList();
      _navigationAids = aidDtos.map((e) => e.toEntity()).toList();

      Log.i(
        'NavAidsRepository: Refresh complete. Cached ${lineDtos.length} lines.',
      );
      return const Right(null);
    } catch (e, s) {
      Log.e('NavAidsRepository: Refresh failed', e, s);
      return Left(ServerFailure(e.toString()));
    }
  }
}
