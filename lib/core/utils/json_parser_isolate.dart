import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sakkoja/features/fishing/data/models/fishing_mappers.dart';
import 'package:sakkoja/features/fishing/data/models/fishing_restriction_dto.dart';
import 'package:sakkoja/features/fishing/data/models/waterway_feature_dto.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';
import 'package:sakkoja/features/speed_limits/data/models/speed_limit_dto.dart';
import 'package:sakkoja/features/speed_limits/data/models/speed_limits_mappers.dart';
import 'package:sakkoja/features/speed_limits/data/models/traffic_sign_dto.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart';

/// Helper to handle JSON parsing in a separate isolate
class JsonParserIsolate {
  /// Parses a list of GeoJSON features into [SpeedLimitZone]s.
  /// This runs on a separate isolate to avoid blocking the UI thread.
  Future<List<SpeedLimitZone>> parseSpeedLimitZones(
    List<dynamic> features,
  ) async {
    return compute(_parseZones, features);
  }

  /// Parses a list of GeoJSON features into [TrafficSign]s.
  Future<List<TrafficSign>> parseTrafficSigns(List<dynamic> features) async {
    return compute(_parseSigns, features);
  }

  /// Parses a list of GeoJSON features into [FishingRestriction]s.
  Future<List<FishingRestriction>> parseFishingRestrictions(
    List<dynamic> features,
  ) async {
    return compute(_parseFishingRestrictions, features);
  }

  /// Parses a list of GeoJSON features into [FishingRestrictionDto]s (returns DTOs).
  Future<List<FishingRestrictionDto>> parseFishingRestrictionsAsDto(
    List<dynamic> features,
  ) async {
    return compute(_parseFishingRestrictionsAsDto, features);
  }

  /// Parses raw GeoJSON string directly in isolate to avoid large main-isolate
  /// object materialization before compute().
  Future<List<FishingRestrictionDto>> parseFishingRestrictionsJsonAsDto(
    String geoJson,
  ) async {
    return compute(_parseFishingRestrictionsJsonAsDto, geoJson);
  }

  /// Parses raw GeoJSON string directly in isolate to avoid main-thread decode.
  Future<(List<SpeedLimitZone> zones, int count)> parseSpeedLimitZonesJson(
    String geoJson,
  ) async {
    return compute(_parseSpeedLimitZonesJson, geoJson);
  }

  /// Parses raw GeoJSON string directly in isolate to avoid main-thread decode.
  Future<(List<TrafficSign> signs, int count)> parseTrafficSignsJson(
    String geoJson,
  ) async {
    return compute(_parseTrafficSignsJson, geoJson);
  }

  /// Parses a list of GeoJSON features into [WaterwayFeature]s.
  Future<List<WaterwayFeature>> parseWaterwayFeatures(
    Map<String, dynamic> data,
  ) async {
    return compute(_parseWaterwayFeatures, data);
  }

  /// Parses a list of GeoJSON features into [WaterwayFeatureDto]s (returns DTOs).
  Future<List<WaterwayFeatureDto>> parseWaterwayFeaturesAsDto(
    Map<String, dynamic> data,
  ) async {
    return compute(_parseWaterwayFeaturesAsDto, data);
  }

  /// Top-level function for isolate execution (Zones)
  static List<SpeedLimitZone> _parseZones(List<dynamic> features) {
    return features
        .expand(
          (f) => SpeedLimitDto.fromGeoJsonMultiple(
            f as Map<String, dynamic>,
          ).map((d) => d.toEntity()),
        )
        .toList();
  }

  /// Top-level function for isolate execution (Signs)
  static List<TrafficSign> _parseSigns(List<dynamic> features) {
    return features
        .map((f) => TrafficSignDto.fromGeoJson(f as Map<String, dynamic>))
        .where((dto) => dto != null)
        .map((dto) => dto!.toEntity())
        .toList();
  }

  static List<FishingRestriction> _parseFishingRestrictions(
    List<dynamic> features,
  ) {
    return features
        .expand(
          (f) => FishingRestrictionDto.fromGeoJsonList(
            f as Map<String, dynamic>,
          ).map((dto) => dto.toEntity()),
        )
        .toList();
  }

  static List<WaterwayFeature> _parseWaterwayFeatures(
    Map<String, dynamic> data,
  ) {
    final features = data['features'] as List<dynamic>;
    final type = (data['type'] as WaterwayFeatureType).name;
    return features
        .map(
          (f) => WaterwayFeatureDto.fromGeoJson(
            f as Map<String, dynamic>,
            WaterwayFeatureDtoType.values.byName(type),
          ).toEntity(),
        )
        .toList();
  }

  /// DTO version of fishing restrictions parser
  static List<FishingRestrictionDto> _parseFishingRestrictionsAsDto(
    List<dynamic> features,
  ) {
    return features
        .expand(
          (f) => FishingRestrictionDto.fromGeoJsonList(
            f as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  static List<FishingRestrictionDto> _parseFishingRestrictionsJsonAsDto(
    String geoJson,
  ) {
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
    final features = decoded['features'] as List<dynamic>? ?? const <dynamic>[];
    return _parseFishingRestrictionsAsDto(features);
  }

  static (List<SpeedLimitZone> zones, int count) _parseSpeedLimitZonesJson(
    String geoJson,
  ) {
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
    final features = decoded['features'] as List<dynamic>? ?? const <dynamic>[];
    final zones = _parseZones(features);
    return (zones, features.length);
  }

  static (List<TrafficSign> signs, int count) _parseTrafficSignsJson(
    String geoJson,
  ) {
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
    final features = decoded['features'] as List<dynamic>? ?? const <dynamic>[];
    final signs = _parseSigns(features);
    return (signs, features.length);
  }

  /// DTO version of waterway features parser
  static List<WaterwayFeatureDto> _parseWaterwayFeaturesAsDto(
    Map<String, dynamic> data,
  ) {
    final features = data['features'] as List<dynamic>;
    final type = (data['type'] as WaterwayFeatureType).name;
    return features
        .map(
          (f) => WaterwayFeatureDto.fromGeoJson(
            f as Map<String, dynamic>,
            WaterwayFeatureDtoType.values.byName(type),
          ),
        )
        .toList();
  }
}
