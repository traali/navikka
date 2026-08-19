import 'dart:async';

import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/config/env.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/models/algae_report_dto.dart';
import 'package:sakkoja/features/weather/data/models/water_quality_dto.dart';

part 'syke_data_source.g.dart';

class SykeDataSource {
  SykeDataSource({required this.dio});

  final Dio dio;
  Dio get _dio => dio;

  // FIX #529: In-flight request deduplication to avoid duplicate SYKE calls
  // within the same second (SYKE rate limit: 50/min).
  final Map<String, Future<List<WaterQualityDto>>> _inFlightWaterQuality = {};
  final Map<String, Future<List<AlgaeReportDto>>> _inFlightAlgae = {};

  // ---------------------------------------------------------------------------
  // Water quality – SYKE Vesla OData v2.0
  //
  // Schema: Naytteenotto (sampling event) → VedenlNayte (water sample per depth)
  //                                        → VedenlTulos (chemistry result)
  //                                        → Maaritys (parameter type lookup)
  //         Naytteenotto → Paikka (monitoring station with coordinates)
  //
  // OData v2 only supports flat expand; nested v4 syntax is not accepted.
  // The server rejects $format=json — use Accept header instead.
  // Coordinates are on Paikka.KoordErLat / KoordErLong (Decimal as String).
  // SuureKoodi mappings: PH=pH, O2D=dissolved oxygen, CP=chlorophyll-a,
  //                      TURB=turbidity; sample depth from VedenlNayte.SyvyysYla.
  // ---------------------------------------------------------------------------
  Future<List<WaterQualityDto>> fetchWaterQuality({
    double? lat,
    double? lon,
    int? limit,
  }) async {
    final eventLimit = (limit ?? 20).clamp(1, 20);
    final cacheKey =
        'wq|${lat?.toStringAsFixed(2)}|${lon?.toStringAsFixed(2)}|$eventLimit';

    if (_inFlightWaterQuality.containsKey(cacheKey)) {
      Log.d('[SYKE] Reusing in-flight water quality request');
      return _inFlightWaterQuality[cacheKey]!;
    }

    final future =
        _fetchWaterQualityInternal(
          lat: lat,
          lon: lon,
          limit: limit,
        ).whenComplete(() {
          _inFlightWaterQuality.remove(cacheKey);
        });

    _inFlightWaterQuality[cacheKey] = future;
    return future;
  }

  Future<List<WaterQualityDto>> _fetchWaterQualityInternal({
    double? lat,
    double? lon,
    int? limit,
  }) async {
    try {
      // Cap at 20: VedenlTulos filter uses OR conditions (4N−1 OData nodes),
      // and the server enforces a 100-node limit — 20 IDs → 79 nodes.
      final eventLimit = (limit ?? 20).clamp(1, 20);

      // Step 1: Recent sampling events with station location + sample IDs.
      final eventResp = await _dio.get<Map<String, dynamic>>(
        '${Env.sykeOdataBaseUrl}/Naytteenotto',
        queryParameters: {
          r'$expand': 'Paikka,VedenlNayte',
          r'$top': eventLimit,
          r'$orderby': 'Aika desc',
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      final events = (eventResp.data?['value'] as List<dynamic>?) ?? [];
      if (events.isEmpty) return [];

      // For each event pick the shallowest VedenlNayte (surface sample).
      final sampleMeta = <int, _SampleMeta>{};
      for (final raw in events) {
        final e = raw as Map<String, dynamic>;
        final paikka = e['Paikka'] as Map<String, dynamic>? ?? {};
        final samplesRaw = (e['VedenlNayte'] as List<dynamic>?) ?? [];

        final eLat = double.tryParse(paikka['KoordErLat']?.toString() ?? '');
        final eLon = double.tryParse(paikka['KoordErLong']?.toString() ?? '');
        if (eLat == null || eLon == null) continue;

        final stationName = paikka['Nimi'] as String? ?? 'Unknown';
        final timestamp = DateTime.tryParse(e['Aika'] as String? ?? '');
        if (timestamp == null) continue;

        int? shallowId;
        var minDepth = double.infinity;
        for (final s in samplesRaw) {
          final sm = s as Map<String, dynamic>;
          final d =
              double.tryParse(sm['SyvyysYla']?.toString() ?? '') ??
              double.infinity;
          final id = sm['VedenlNayte_Id'] as int?;
          if (id != null && d < minDepth) {
            minDepth = d;
            shallowId = id;
          }
        }
        if (shallowId == null) continue;

        sampleMeta[shallowId] = _SampleMeta(
          timestamp: timestamp,
          location: LatLng(eLat, eLon),
          stationName: stationName,
        );
      }

      if (sampleMeta.isEmpty) return [];

      // Step 2: Chemistry results for the selected surface samples.
      // take(20) guards against eventLimit drift; 4×20−1 = 79 nodes < 100 limit.
      final filter = sampleMeta.keys
          .take(20)
          .map((id) => 'VedenlNayte_Id eq $id')
          .join(' or ');

      final chemResp = await _dio.get<Map<String, dynamic>>(
        '${Env.sykeOdataBaseUrl}/VedenlTulos',
        queryParameters: {r'$expand': 'Maaritys', r'$filter': filter},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      final chemRows = (chemResp.data?['value'] as List<dynamic>?) ?? [];

      // Group measurements by VedenlNayte_Id → SuureKoodi → value.
      final measurements = <int, Map<String, double>>{};
      for (final row in chemRows) {
        final r = row as Map<String, dynamic>;
        final naytteId = r['VedenlNayte_Id'] as int?;
        final maaritys = r['Maaritys'] as Map<String, dynamic>? ?? {};
        final koodi = maaritys['SuureKoodi'] as String?;
        final arvo = _toDouble(r['Arvo']);
        if (naytteId == null || koodi == null || arvo == null) continue;
        (measurements[naytteId] ??= {})[koodi] = arvo;
      }

      return sampleMeta.entries.map((e) {
        final m = measurements[e.key] ?? {};
        return WaterQualityDto(
          timestamp: e.value.timestamp,
          location: e.value.location,
          stationName: e.value.stationName,
          dissolvedOxygen: m['O2D'],
          pH: m['PH'],
          chlorophyllA: m['CP'],
          turbidity: m['TURB'] ?? m['TURB0'],
        );
      }).toList();
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 404) {
        Log.w(
          '[SYKE] Naytteenotto endpoint not found at ${Env.sykeOdataBaseUrl}. '
          'SYKE Vesla v2.0 API schema may have changed.',
        );
        return [];
      }
      Log.e('[SYKE] Failed to fetch water quality', e, s);
      rethrow;
    } catch (e, s) {
      Log.e('[SYKE] Failed to fetch water quality', e, s);
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // Algae reports – SYKE Citizen Observations (kansalaishavainnot / Open311)
  //
  // The v1.0 Levatiedot OData entity has been retired. Algae bloom sightings
  // are now sourced from SYKE's public citizen observation platform (HISP)
  // via the Open311-compatible kansalaishavainnot API.
  // ---------------------------------------------------------------------------
  static const String _algaeServiceCode =
      'hisp_algaebloom_service_code_202201051826208';

  Future<List<AlgaeReportDto>> fetchAlgaeReports({
    double? lat,
    double? lon,
    DateTime? since,
  }) async {
    final cacheKey =
        'algae|${lat?.toStringAsFixed(2)}|${lon?.toStringAsFixed(2)}|${since?.toIso8601String() ?? '30d'}';

    if (_inFlightAlgae.containsKey(cacheKey)) {
      Log.d('[SYKE] Reusing in-flight algae request');
      return _inFlightAlgae[cacheKey]!;
    }

    final future =
        _fetchAlgaeReportsInternal(
          lat: lat,
          lon: lon,
          since: since,
        ).whenComplete(() {
          _inFlightAlgae.remove(cacheKey);
        });

    _inFlightAlgae[cacheKey] = future;
    return future;
  }

  Future<List<AlgaeReportDto>> _fetchAlgaeReportsInternal({
    double? lat,
    double? lon,
    DateTime? since,
  }) async {
    try {
      final endDate = DateTime.now().toUtc();
      final startDate =
          since?.toUtc() ?? endDate.subtract(const Duration(days: 30));

      final queryParams = <String, dynamic>{
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'status': 'open',
        'extension': 'true',
        'service_code': _algaeServiceCode,
      };

      final response = await _dio.get<dynamic>(
        '${Env.sykeCitizenObsUrl}/requests.json',
        queryParameters: queryParams,
      );

      final rawList = response.data;
      final List<dynamic> data = rawList is List<dynamic>
          ? rawList
          : <dynamic>[];
      return _parseCitizenAlgaeReports(data);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 404) {
        Log.w(
          '[SYKE] Citizen observations (algae) endpoint not found at '
          '${Env.sykeCitizenObsUrl}. SYKE kansalaishavainnot API may have changed.',
        );
        return [];
      }
      Log.e('[SYKE] Failed to fetch algae reports', e, s);
      rethrow;
    } catch (e, s) {
      Log.e('[SYKE] Failed to fetch algae reports', e, s);
      rethrow;
    }
  }

  /// Parses Open311 service-request records from the HISP algae bloom service.
  List<AlgaeReportDto> _parseCitizenAlgaeReports(List<dynamic> data) {
    final results = <AlgaeReportDto>[];
    for (final item in data) {
      final lat = _toDouble(item['lat']);
      final lon = _toDouble(item['long']);
      if (lat == null || lon == null) continue;

      final timestamp = DateTime.tryParse(
        item['requested_datetime'] as String? ?? '',
      );
      if (timestamp == null) continue;

      // Extended attributes contain the algae-bloom-specific fields. The key
      // name varies by API version; try the most common Finnish variants.
      final extended =
          item['extended_attributes'] as Map<String, dynamic>? ?? {};
      final bloomType = _extractAlgaeBloomType(extended);

      results.add(
        AlgaeReportDto(
          timestamp: timestamp,
          location: LatLng(lat, lon),
          riskLevel: _parseRiskLevel311(bloomType),
          // Citizen reports do not provide lab parameters (biomass, cell
          // count, dominant species); leave them null.
        ),
      );
    }
    return results;
  }

  /// Extracts the algae bloom type string from the Open311 extended_attributes
  /// map. SYKE uses Finnish field names; we try several known variants.
  String? _extractAlgaeBloomType(Map<String, dynamic> extended) {
    const candidateKeys = [
      'levahavaintotyyppi',
      'levähavaintotyyppi', // levähavaintotyyppi
      'algaebloom_type',
      'algae_type',
      'havaintotyyppi',
      'bloom_type',
    ];
    for (final key in candidateKeys) {
      final value = extended[key];
      if (value is String && value.isNotEmpty) return value;
    }
    // Some HISP services wrap attributes in a nested list/map.
    for (final value in extended.values) {
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }

  /// Maps Finnish algae bloom type strings to [AlgaeRiskLevelDto].
  AlgaeRiskLevelDto? _parseRiskLevel311(String? value) {
    if (value == null) return null;
    final lower = value.toLowerCase().trim();
    // "Ei levää" / "Ei havaintoa" → no algae (null = not a risk)
    if (lower.contains('ei lev') || lower.contains('ei havaintoa')) {
      return null;
    }
    if (lower.contains('erittäin') ||
        lower.contains('erittain') ||
        lower.contains('very')) {
      return AlgaeRiskLevelDto.veryHigh;
    }
    if (lower.contains('runsaasti') ||
        lower.contains('paljon') ||
        lower.contains('high')) {
      return AlgaeRiskLevelDto.high;
    }
    if (lower.contains('vähän') ||
        lower.contains('vahan') ||
        lower.contains('kohtalais') ||
        lower.contains('moderate') ||
        lower.contains('low')) {
      return AlgaeRiskLevelDto.low;
    }
    return null;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

/// Intermediate data class for a surface water sample's metadata.
class _SampleMeta {
  const _SampleMeta({
    required this.timestamp,
    required this.location,
    required this.stationName,
  });

  final DateTime timestamp;
  final LatLng location;
  final String stationName;
}

@Riverpod(keepAlive: true)
SykeDataSource sykeDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return SykeDataSource(dio: dio);
}
