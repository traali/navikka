import 'dart:convert';

import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/map/data/models/last_location_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MapLocalDataSource {
  Future<void> saveLastLocation(LastLocationDto location);
  Future<LastLocationDto?> getLastLocation();
  Future<void> saveLayerFilterSettings(Map<String, dynamic> json);
  Future<Map<String, dynamic>?> getLayerFilterSettings();
}

class MapLocalDataSourceImpl implements MapLocalDataSource {
  MapLocalDataSourceImpl({DateTime Function()? clock, this._prefs})
    : _clock = clock ?? DateTime.now;

  static const _keyLastLocation = 'map_last_location';
  static const _lastLocationMaxAge = Duration(hours: 24);

  final DateTime Function() _clock;
  final SharedPreferences? _prefs;

  Future<SharedPreferences> _getPreferences() async {
    return _prefs ?? SharedPreferences.getInstance();
  }

  @override
  Future<void> saveLastLocation(LastLocationDto location) async {
    final prefs = await _getPreferences();
    final payload = {
      ...location.toJson(),
      'savedAt': _clock().toIso8601String(),
    };
    final saved = await prefs.setString(_keyLastLocation, jsonEncode(payload));
    if (!saved) {
      throw StateError('Failed to persist last location');
    }
    Log.d(
      'MapLocalDS: Saved last location ${location.latitude}, ${location.longitude}',
    );
  }

  @override
  Future<LastLocationDto?> getLastLocation() async {
    final prefs = await _getPreferences();
    final jsonStr = prefs.getString(_keyLastLocation);

    if (jsonStr == null) {
      Log.d('MapLocalDS: Last location MISS');
      return null;
    }

    dynamic json;
    try {
      json = jsonDecode(jsonStr);
    } on Object {
      Log.d('MapLocalDS: Last location STALE (invalid payload)');
      return null;
    }

    if (json is! Map<String, dynamic>) {
      Log.d('MapLocalDS: Last location STALE (invalid payload)');
      return null;
    }

    final savedAtValue = json['savedAt'];
    if (savedAtValue is! String) {
      Log.d('MapLocalDS: Last location STALE (missing timestamp)');
      return null;
    }

    final savedAt = DateTime.tryParse(savedAtValue);
    if (savedAt == null) {
      Log.d('MapLocalDS: Last location STALE (invalid timestamp)');
      return null;
    }

    final age = _clock().difference(savedAt);
    if (age.isNegative || age >= _lastLocationMaxAge) {
      Log.d('MapLocalDS: Last location STALE (expired)');
      return null;
    }

    try {
      final location = LastLocationDto.fromJson(json);
      Log.d('MapLocalDS: Last location HIT');
      return location;
    } on Object {
      Log.d('MapLocalDS: Last location STALE (invalid coordinates)');
      return null;
    }
  }

  static const _keyLayerFilter = 'map_layer_filter';

  @override
  Future<void> saveLayerFilterSettings(Map<String, dynamic> json) async {
    final prefs = await _getPreferences();
    await prefs.setString(_keyLayerFilter, jsonEncode(json));
    Log.d('MapLocalDS: Saved layer filter settings');
  }

  @override
  Future<Map<String, dynamic>?> getLayerFilterSettings() async {
    final prefs = await _getPreferences();
    final jsonStr = prefs.getString(_keyLayerFilter);
    if (jsonStr == null) return null;
    return jsonDecode(jsonStr) as Map<String, dynamic>;
  }
}
