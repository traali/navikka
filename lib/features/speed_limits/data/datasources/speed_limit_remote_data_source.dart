import 'package:dio/dio.dart';
import 'package:sakkoja/core/errors/exceptions.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/json_parser_isolate.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart'; // [NEW]

abstract class SpeedLimitRemoteDataSource {
  /// Fetches speed limit zones from the WFS API
  ///
  /// [bbox] - Optional bounding box to limit the spatial extent of results
  ///          If provided, only zones within the bbox will be returned
  ///          Recommended: 5km radius from user location (~37 features vs 1000+)
  Future<List<SpeedLimitZone>> fetchSpeedLimits({BBox? bbox});

  /// Fetches traffic signs/buoys from WFS
  Future<List<TrafficSign>> fetchTrafficSigns({BBox? bbox});
}

class SpeedLimitRemoteDataSourceImpl implements SpeedLimitRemoteDataSource {
  SpeedLimitRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  // Updated to use the recommended stable endpoint
  static const String _baseUrl =
      'https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs';
  static const String _typeName = 'vesivaylatiedot:rajoitusalue_a_uusi';
  static const String _signTypeName = 'vesivaylatiedot:vesiliikennemerkit_uusi';
  static const int _pageSize = 500; // Safe limit (API max ~700)

  @override
  Future<List<SpeedLimitZone>> fetchSpeedLimits({BBox? bbox}) async {
    final allZones = <SpeedLimitZone>[];
    var startIndex = 0;
    var pageCount = 0;
    const maxPages = 20; // Hard fail at 10k items (20 * 500)

    // ETag is tricky with pagination and dynamic bbox.
    // Ideally we'd store ETags per URL.
    // For now, we add the header if we have one (user would need to pass it, but interface doesn't support it yet).
    // Or we rely on Dio's interceptors.
    // Since we are doing a "Smart Grid" where URLs are consistent,
    // we should let Dio or a distinct caching layer handle it,
    // OR we explicitly support it here.

    // For this implementation, we will add the header capabilities
    // but without an external ETag store, it won't send the header yet
    // UNLESS we check the default headers.

    try {
      while (true) {
        final queryParams = {
          'service': 'wfs',
          'version': '2.0.0',
          'request': 'GetFeature',
          'typeName': _typeName,
          'outputFormat': 'json',
          'srsName': 'EPSG:4326',
          'count': _pageSize,
          'startIndex': startIndex,
        };

        if (pageCount >= maxPages) {
          throw const ServerException(
            'Safety: Speed Limit fetch exceeded max pages (20). Aborting infinite loop risk.',
            500,
          );
        }
        pageCount++;

        if (bbox != null) {
          queryParams['bbox'] = bbox.toWfsParam();
        }

        Log.d(
          'SpeedLimitRemoteDS: Fetching limits at index $startIndex '
          '(BBox: ${bbox?.toWfsParam() ?? 'None'})',
        );

        final response = await _dio.get<dynamic>(
          _baseUrl,
          queryParameters: queryParams,
          options: Options(
            responseType: ResponseType.plain,
            headers: {
              // NOTE: ETag/If-None-Match caching deferred; Dio interceptor layer handles this.
            },
            validateStatus: (status) =>
                status != null && (status == 200 || status == 304),
          ),
        );

        if (response.statusCode == 304) {
          Log.d('SpeedLimitRemoteDS: 304 Not Modified. Using cache.');
          return []; // Signal to use cache
        }

        if (response.statusCode != 200 || response.data == null) {
          throw ServerException(
            'Failed to fetch data: ${response.statusCode}',
            response.statusCode,
          );
        }

        final responseString = response.data as String;
        final (zones, featureCount) = await JsonParserIsolate()
            .parseSpeedLimitZonesJson(
              responseString,
            );

        allZones.addAll(zones);

        // If we get fewer features than page size, we are done
        if (featureCount < _pageSize) {
          break;
        }
        startIndex += _pageSize;
      }

      Log.d('SpeedLimitRemoteDS: Fetched ${allZones.length} zones total');
      return allZones;
    } on DioException catch (e) {
      if (e.response?.statusCode == 304) return [];
      Log.e('SpeedLimitRemoteDS: Dio error', e);
      throw ServerException(
        e.message ?? 'Unknown Dio Error',
        e.response?.statusCode,
      );
    } catch (e, s) {
      if (e is ServerException) rethrow;
      Log.e('SpeedLimitRemoteDS: Error fetching limits', e, s);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TrafficSign>> fetchTrafficSigns({BBox? bbox}) async {
    final allSigns = <TrafficSign>[];
    var startIndex = 0;
    var pageCount = 0;
    const maxPages = 20;

    try {
      while (true) {
        final queryParams = {
          'service': 'wfs',
          'version': '2.0.0',
          'request': 'GetFeature',
          'typeName': _signTypeName,
          'outputFormat': 'json',
          'srsName': 'EPSG:4326',
          'count': _pageSize,
          'startIndex': startIndex,
        };

        if (pageCount >= maxPages) {
          Log.w(
            'Safety: Traffic Signs fetch exceeded max pages (20). Stopping.',
          );
          break; // Don't crash flow for signs, just stop
        }
        pageCount++;

        if (bbox != null) {
          queryParams['bbox'] = bbox.toWfsParam();
        }

        Log.d(
          'SpeedLimitRemoteDS: Fetching signs at index $startIndex '
          '(BBox: ${bbox?.toWfsParam() ?? 'None'})',
        );

        final response = await _dio.get<dynamic>(
          _baseUrl,
          queryParameters: queryParams,
          options: Options(
            responseType: ResponseType.plain,
          ),
        );

        if (response.statusCode != 200 || response.data == null) {
          throw ServerException(
            'Failed to fetch signs: ${response.statusCode}',
            response.statusCode,
          );
        }

        final responseString = response.data as String;
        final (signs, featureCount) = await JsonParserIsolate()
            .parseTrafficSignsJson(
              responseString,
            );

        allSigns.addAll(signs);

        if (featureCount < _pageSize) {
          break;
        }
        startIndex += _pageSize;
      }
      Log.d('SpeedLimitRemoteDS: Fetched ${allSigns.length} signs total');
      return allSigns;
    } catch (e, s) {
      Log.e('SpeedLimitRemoteDS: Error fetching traffic signs', e, s);
      return [];
    }
  }
}
