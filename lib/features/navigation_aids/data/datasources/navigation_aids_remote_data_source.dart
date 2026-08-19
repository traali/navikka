import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sakkoja/core/constants/geometry_constants.dart';
import 'package:sakkoja/core/constants/navigation_aids_constants.dart';
import 'package:sakkoja/core/errors/exceptions.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/navigation_aids/data/models/fairway_area_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_aid_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_line_dto.dart';

/// Remote data source for navigation aids from Väylävirasto WFS API.
///
/// DEPRECATED: Critical map path now uses Offline-First (In-Memory).
/// This class is preserved for future "Background Sync" implementation.
abstract class NavigationAidsRemoteDataSource {
  /// Fetches fairway areas from WFS.
  Future<List<FairwayAreaDto>> fetchFairwayAreas({BBox? bbox});

  /// Fetches traffic signs from WFS.
  Future<List<NavigationAidDto>> fetchTrafficSigns({BBox? bbox});

  /// Fetches safety equipment from WFS.
  Future<List<NavigationAidDto>> fetchSafetyEquipment({BBox? bbox});

  /// Fetches lighthouses from WFS.
  Future<List<NavigationAidDto>> fetchLighthouses({BBox? bbox});

  /// Fetches navigation lines (centerlines) from WFS.
  Future<List<NavigationLineDto>> fetchNavigationLines({BBox? bbox});

  /// Fetches all navigation aids in parallel.
  Future<List<NavigationAidDto>> fetchAllNavigationAids({BBox? bbox});
}

class NavigationAidsRemoteDataSourceImpl
    implements NavigationAidsRemoteDataSource {
  NavigationAidsRemoteDataSourceImpl(
    this._dio, {
    int pageSize = NavigationAidsConstants.pageSize,
    int maxPages = 100,
  }) : assert(pageSize > 0, 'pageSize must be positive'),
       assert(maxPages > 0, 'maxPages must be positive'),
       _pageSize = pageSize,
       _maxPages = maxPages;

  final Dio _dio;
  final int _pageSize;
  final int _maxPages;
  final Map<String, Future<dynamic>> _inFlightRequests = {};

  Future<T> _deduplicate<T>(String key, Future<T> Function() fetcher) async {
    if (_inFlightRequests.containsKey(key)) {
      Log.d('[NavAids] Returning in-flight request for key: $key');
      return _inFlightRequests[key]! as Future<T>;
    }

    final future = fetcher();
    _inFlightRequests[key] = future;

    try {
      return await future;
    } finally {
      _inFlightRequests.remove(key);
    }
  }

  @override
  Future<List<FairwayAreaDto>> fetchFairwayAreas({BBox? bbox}) async {
    final key = 'fairways_${bbox?.toWfsParam(forceLonLat: true) ?? 'all'}';
    return _deduplicate(
      key,
      () => _fetchPaginated<FairwayAreaDto>(
        layerName: NavigationAidsConstants.layerFairwayAreas,
        parser: (features) => features
            .map((f) => FairwayAreaDto.fromGeoJson(f as Map<String, dynamic>))
            .toList(),
        bbox: bbox,
      ),
    );
  }

  @override
  Future<List<NavigationAidDto>> fetchTrafficSigns({BBox? bbox}) async {
    final key = 'signs_${bbox?.toWfsParam(forceLonLat: true) ?? 'all'}';
    return _deduplicate(
      key,
      () => _fetchPaginated<NavigationAidDto>(
        layerName: NavigationAidsConstants.layerTrafficSigns,
        parser: (features) => features
            .map(
              (f) => NavigationAidDto.fromTrafficSignGeoJson(
                f as Map<String, dynamic>,
              ),
            )
            .toList(),
        bbox: bbox,
      ),
    );
  }

  @override
  Future<List<NavigationAidDto>> fetchSafetyEquipment({BBox? bbox}) async {
    final key = 'equipment_${bbox?.toWfsParam(forceLonLat: true) ?? 'all'}';
    return _deduplicate(
      key,
      () => _fetchPaginated<NavigationAidDto>(
        layerName: NavigationAidsConstants.layerSafetyEquipment,
        parser: (features) => features
            .map(
              (f) => NavigationAidDto.fromSafetyEquipmentGeoJson(
                f as Map<String, dynamic>,
              ),
            )
            .toList(),
        bbox: bbox,
      ),
    );
  }

  @override
  Future<List<NavigationAidDto>> fetchLighthouses({BBox? bbox}) async {
    final key = 'lighthouses_${bbox?.toWfsParam(forceLonLat: true) ?? 'all'}';
    return _deduplicate(
      key,
      () => _fetchPaginated<NavigationAidDto>(
        layerName: NavigationAidsConstants.layerLighthouses,
        parser: (features) => features
            .map(
              (f) => NavigationAidDto.fromLighthouseGeoJson(
                f as Map<String, dynamic>,
              ),
            )
            .toList(),
        bbox: bbox,
      ),
    );
  }

  @override
  Future<List<NavigationLineDto>> fetchNavigationLines({BBox? bbox}) async {
    final key = 'lines_${bbox?.toWfsParam(forceLonLat: true) ?? 'all'}';
    return _deduplicate(
      key,
      () => _fetchPaginated<NavigationLineDto>(
        layerName: NavigationAidsConstants.layerNavigationLines,
        parser: (features) => features
            .map(
              (f) => NavigationLineDto.fromGeoJson(f as Map<String, dynamic>),
            )
            .toList(),
        bbox: bbox,
      ),
    );
  }

  @override
  Future<List<NavigationAidDto>> fetchAllNavigationAids({BBox? bbox}) async {
    final key = 'all_aids_${bbox?.toWfsParam(forceLonLat: true) ?? 'all'}';
    return _deduplicate(key, () async {
      // PERFORMANCE: Fetch all types in parallel
      final results = await Future.wait([
        fetchTrafficSigns(bbox: bbox),
        fetchSafetyEquipment(bbox: bbox),
        fetchLighthouses(bbox: bbox),
      ]);

      return results.expand((list) => list).toList();
    });
  }

  /// Generic paginated WFS fetch with isolate parsing.
  Future<List<T>> _fetchPaginated<T>({
    required String layerName,
    required List<T> Function(List<dynamic>) parser,
    BBox? bbox,
  }) async {
    final allItems = <T>[];
    var startIndex = 0;
    var pageCount = 0;
    final pageSignatures = <String>{};
    final seenFeatureIds = <String>{};
    const precision = GeometryConstants.precisionDeduplication;

    try {
      while (true) {
        if (pageCount >= _maxPages) {
          throw ServerException(
            'Pagination limit reached for $layerName after $_maxPages pages',
          );
        }
        final queryParams = <String, dynamic>{
          'service': 'wfs',
          'version': '2.0.0',
          'request': 'GetFeature',
          'typeName': layerName,
          'outputFormat': 'json',
          'srsName': 'EPSG:4326',
          'count': _pageSize,
          'startIndex': startIndex,
        };

        if (bbox != null) {
          // Väylävirasto WFS 2.0 requires (Lon, Lat) order for EPSG:4326,
          // violating the standard (Lat, Lon). We force the swap here.
          queryParams['bbox'] = bbox.toWfsParam(
            precision: precision,
            forceLonLat: true,
          );
        }

        Log.d(
          'NavAidsRemoteDS: Fetching $layerName at index $startIndex '
          '(BBox: ${bbox?.toWfsParam(forceLonLat: true) ?? 'None'})',
        );

        final response = await _dio.get<dynamic>(
          NavigationAidsConstants.baseUrl,
          queryParameters: queryParams,
        );

        if (response.statusCode != 200 || response.data == null) {
          throw ServerException(
            'Failed to fetch $layerName: ${response.statusCode}',
            response.statusCode,
          );
        }

        final jsonResponse = response.data as Map<String, dynamic>;
        final features = jsonResponse['features'] as List<dynamic>? ?? [];
        if (features.isEmpty) break;

        final signature = _pageSignature(features);
        if (!pageSignatures.add(signature)) {
          throw ServerException(
            'WFS pagination repeated a page for $layerName at index '
            '$startIndex',
          );
        }

        final uniqueFeatures = <dynamic>[];
        for (final feature in features) {
          final id = feature is Map<String, dynamic>
              ? feature['id']?.toString()
              : null;
          if (id == null || id.isEmpty || seenFeatureIds.add(id)) {
            uniqueFeatures.add(feature);
          }
        }

        final items = parser(uniqueFeatures);
        allItems.addAll(items);
        pageCount++;

        final numberReturned =
            _parseWfsCount(jsonResponse['numberReturned']) ?? features.length;
        final numberMatched = _parseWfsCount(jsonResponse['numberMatched']);
        final madeProgress = numberReturned > 0
            ? numberReturned
            : features.length;

        if (numberMatched != null &&
            startIndex + madeProgress >= numberMatched) {
          break;
        }
        if (features.length < _pageSize) {
          break;
        }
        startIndex += madeProgress;
      }

      Log.d('NavAidsRemoteDS: Fetched ${allItems.length} $layerName total');
      return allItems;
    } on DioException catch (e) {
      Log.e('NavAidsRemoteDS: Dio error for $layerName', e);
      throw ServerException(
        e.message ?? 'Network error',
        e.response?.statusCode,
      );
    } catch (e, s) {
      if (e is ServerException) rethrow;
      Log.e('NavAidsRemoteDS: Error fetching $layerName', e, s);
      throw ServerException(e.toString());
    }
  }

  int? _parseWfsCount(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  String _pageSignature(List<dynamic> features) {
    String identity(Object? feature) {
      if (feature is Map<String, dynamic>) {
        final id = feature['id'];
        if (id != null) return id.toString();
      }
      return jsonEncode(feature);
    }

    return '${features.length}:${identity(features.first)}:'
        '${identity(features.last)}';
  }
}
