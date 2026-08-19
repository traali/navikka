import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sakkoja/core/errors/exceptions.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/json_parser_isolate.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/fishing/data/models/fishing_restriction_dto.dart';
import 'package:sakkoja/features/fishing/data/models/waterway_feature_dto.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';

abstract class FishingRemoteDataSource {
  Future<List<FishingRestrictionDto>> fetchFishingRestrictions({BBox? bbox});
  Future<List<WaterwayFeatureDto>> fetchWaterwayFeatures({BBox? bbox});
}

class FishingRemoteDataSourceImpl implements FishingRemoteDataSource {
  FishingRemoteDataSourceImpl(this._dio);
  final Dio _dio;
  final _jsonParser = JsonParserIsolate();
  final Map<String, Future<dynamic>> _inFlightRequests = {};

  Future<T> _deduplicate<T>(String key, Future<T> Function() fetcher) async {
    if (_inFlightRequests.containsKey(key)) {
      Log.d('FishingRemoteDS: Returning in-flight request for $key');
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

  static const String _mmmUrl =
      'https://avoinkara-mmm.ruokavirasto-awsa.com/geoserver/wfs';
  static const String _vaylaUrl =
      'https://avoinapi.vaylapilvi.fi/inspirepalvelu/tn-w/wfs';
  static const _restrictionPageSize = 500;
  static const _maxRestrictionPages = 100;
  static const _waterwayPageSize = 500;
  static const _maxWaterwayPages = 100;

  @override
  Future<List<FishingRestrictionDto>> fetchFishingRestrictions({
    BBox? bbox,
  }) async {
    final key = 'restrictions_${bbox?.toString() ?? 'global'}';
    return _deduplicate(key, () async {
      try {
        Log.d(
          'FishingRemoteDS: Fetching restrictions (BBox: ${bbox?.toString() ?? 'None'})',
        );
        final restrictions = await _fetchRestrictionPages(bbox);
        Log.d('FishingRemoteDS: Fetched ${restrictions.length} restrictions');
        return restrictions;
      } catch (e, s) {
        Log.e('FishingRemoteDS: Error fetching fishing restrictions', e, s);
        rethrow;
      }
    });
  }

  Future<List<FishingRestrictionDto>> _fetchRestrictionPages(BBox? bbox) async {
    final allFeatures = <dynamic>[];
    final seenPageSignatures = <String>{};
    Map<String, dynamic>? responseTemplate;
    int? expectedTotal;

    for (var page = 0; page < _maxRestrictionPages; page++) {
      final queryParams = <String, dynamic>{
        'service': 'wfs',
        'version': '2.0.0',
        'request': 'GetFeature',
        'typeName': 'avoin:kalastusrajoitus',
        'outputFormat': 'json',
        'srsName': 'CRS:84',
        'count': _restrictionPageSize,
        'startIndex': page * _restrictionPageSize,
      };

      if (bbox != null) {
        queryParams['bbox'] =
            '${bbox.minLon},${bbox.minLat},${bbox.maxLon},${bbox.maxLat},CRS:84';
      }

      final response = await _dio.get<String>(
        _mmmUrl,
        queryParameters: queryParams,
        options: Options(responseType: ResponseType.plain),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to fetch fishing restrictions page ${page + 1}: '
          '${response.statusCode}',
          response.statusCode,
        );
      }

      final payload = response.data;
      if (payload == null || payload.isEmpty) {
        if (expectedTotal != null && allFeatures.length < expectedTotal) {
          throw ServerException(
            'Fishing restrictions ended after ${allFeatures.length} of '
            '$expectedTotal features',
            response.statusCode,
          );
        }
        break;
      }

      final decoded = jsonDecode(payload);
      if (decoded is! Map<String, dynamic>) {
        throw const ServerException(
          'Fishing restrictions response was not a GeoJSON object',
        );
      }
      responseTemplate ??= decoded;
      expectedTotal ??= _declaredFeatureCount(decoded);
      final features = decoded['features'] as List<dynamic>? ?? const [];

      if (features.isEmpty) {
        if (expectedTotal != null && allFeatures.length < expectedTotal) {
          throw ServerException(
            'Fishing restrictions ended after ${allFeatures.length} of '
            '$expectedTotal features',
            response.statusCode,
          );
        }
        break;
      }
      if (!seenPageSignatures.add(_pageSignature(features))) {
        throw ServerException(
          'Fishing restrictions repeated page ${page + 1}; '
          'refusing a partial result',
          response.statusCode,
        );
      }

      allFeatures.addAll(features);
      if (expectedTotal != null) {
        if (allFeatures.length >= expectedTotal) break;
        if (features.length < _restrictionPageSize) {
          throw ServerException(
            'Fishing restrictions returned ${allFeatures.length} of '
            '$expectedTotal features',
            response.statusCode,
          );
        }
      } else if (features.length < _restrictionPageSize) {
        break;
      }

      if (page == _maxRestrictionPages - 1) {
        throw const ServerException(
          'Fishing restriction pagination limit reached; '
          'refusing a partial result',
        );
      }
    }

    if (allFeatures.isEmpty) return const [];
    final combined = <String, dynamic>{
      ...?responseTemplate,
      'features': allFeatures,
    };
    return _jsonParser.parseFishingRestrictionsJsonAsDto(jsonEncode(combined));
  }

  @override
  Future<List<WaterwayFeatureDto>> fetchWaterwayFeatures({BBox? bbox}) async {
    final allFeatures = <WaterwayFeatureDto>[];

    final layerTypes = {
      'tn-w:FairwayArea': WaterwayFeatureType.fairwayArea,
      'tn-w:Beacon': WaterwayFeatureType.beacon,
      'tn-w:Buoy': WaterwayFeatureType.buoy,
    };

    // OPTIMIZATION: Fetch all types in parallel
    final futures = layerTypes.entries.map((entry) async {
      final key = 'waterway_${entry.key}_${bbox?.toString() ?? 'global'}';
      return _deduplicate(
        key,
        () => _fetchWaterwayLayer(entry.key, entry.value, bbox),
      );
    });

    final results = await Future.wait(futures);
    for (final list in results) {
      allFeatures.addAll(list);
    }

    return allFeatures;
  }

  Future<List<WaterwayFeatureDto>> _fetchWaterwayLayer(
    String layer,
    WaterwayFeatureType type,
    BBox? bbox,
  ) async {
    try {
      final allFeatures = <dynamic>[];
      final seenPageSignatures = <String>{};
      int? expectedTotal;

      for (var page = 0; page < _maxWaterwayPages; page++) {
        final queryParams = <String, dynamic>{
          'service': 'wfs',
          'version': '2.0.0',
          'request': 'GetFeature',
          'typeName': layer,
          'outputFormat': 'json',
          'srsName': 'urn:ogc:def:crs:EPSG::4326',
          'count': _waterwayPageSize,
          'startIndex': page * _waterwayPageSize,
        };
        if (bbox != null) queryParams['bbox'] = bbox.toWfsParam();

        Log.d('FishingRemoteDS: Fetching $layer page ${page + 1}');
        final response = await _dio.get<dynamic>(
          _vaylaUrl,
          queryParameters: queryParams,
        );
        if (response.statusCode != 200 || response.data == null) {
          throw ServerException(
            'Failed to fetch $layer page ${page + 1}: ${response.statusCode}',
            response.statusCode,
          );
        }

        final data = response.data as Map<String, dynamic>;
        expectedTotal ??= _declaredFeatureCount(data);
        final features = data['features'] as List<dynamic>? ?? const [];

        if (features.isEmpty) {
          if (expectedTotal != null && allFeatures.length < expectedTotal) {
            throw ServerException(
              '$layer ended after ${allFeatures.length} of $expectedTotal features',
              response.statusCode,
            );
          }
          return _parseWaterwayFeatures(allFeatures, type);
        }

        if (!seenPageSignatures.add(_pageSignature(features))) {
          throw ServerException(
            '$layer repeated page ${page + 1}; refusing a partial result',
            response.statusCode,
          );
        }

        allFeatures.addAll(features);
        if (expectedTotal != null) {
          if (allFeatures.length >= expectedTotal) {
            return _parseWaterwayFeatures(allFeatures, type);
          }
          if (features.length < _waterwayPageSize) {
            throw ServerException(
              '$layer returned ${allFeatures.length} of $expectedTotal features',
              response.statusCode,
            );
          }
        } else if (features.length < _waterwayPageSize) {
          return _parseWaterwayFeatures(allFeatures, type);
        }
      }

      throw const ServerException(
        'Waterway pagination limit reached; refusing a partial result',
      );
    } catch (e, s) {
      Log.e('FishingRemoteDS: Error fetching $layer', e, s);
      rethrow;
    }
  }

  Future<List<WaterwayFeatureDto>> _parseWaterwayFeatures(
    List<dynamic> features,
    WaterwayFeatureType type,
  ) => _jsonParser.parseWaterwayFeaturesAsDto({
    'features': features,
    'type': type,
  });

  int? _declaredFeatureCount(Map<String, dynamic> data) {
    final rawCount = data['numberMatched'] ?? data['totalFeatures'];
    if (rawCount is num) return rawCount.toInt();
    if (rawCount is String) return int.tryParse(rawCount);
    return null;
  }

  String _pageSignature(List<dynamic> features) => jsonEncode(features);
}
