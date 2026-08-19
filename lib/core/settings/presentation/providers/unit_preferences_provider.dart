import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SpeedUnit {
  knots('kn', 'Solmut (kn)'),
  kmh('km/h', 'Kilometrit tunnissa (km/h)'),
  mph('mph', 'Mailit tunnissa (mph)');

  const SpeedUnit(this.symbol, this.label);
  final String symbol;
  final String label;

  double convertFromKmh(double speedKmh) {
    switch (this) {
      case SpeedUnit.knots:
        return speedKmh * 0.539957;
      case SpeedUnit.kmh:
        return speedKmh;
      case SpeedUnit.mph:
        return speedKmh * 0.621371;
    }
  }

  String format(double speedKmh) {
    final value = convertFromKmh(speedKmh);
    return '${value.toStringAsFixed(1)} $symbol';
  }
}

enum WindSpeedUnit {
  ms('m/s', 'Metriä sekunnissa (m/s)'),
  knots('kn', 'Solmut (kn)'),
  beaufort('Bft', 'Boforit (Bft)'),
  kmh('km/h', 'Kilometrit tunnissa (km/h)');

  const WindSpeedUnit(this.symbol, this.label);
  final String symbol;
  final String label;

  double convertFromMs(double windMs) {
    switch (this) {
      case WindSpeedUnit.ms:
        return windMs;
      case WindSpeedUnit.knots:
        return windMs * 1.94384;
      case WindSpeedUnit.beaufort:
        return _msToBeaufort(windMs);
      case WindSpeedUnit.kmh:
        return windMs * 3.6;
    }
  }

  static double _msToBeaufort(double ms) {
    if (ms < 0.3) return 0;
    if (ms < 1.6) return 1;
    if (ms < 3.4) return 2;
    if (ms < 5.5) return 3;
    if (ms < 8.0) return 4;
    if (ms < 10.8) return 5;
    if (ms < 13.9) return 6;
    if (ms < 17.2) return 7;
    if (ms < 20.8) return 8;
    if (ms < 24.5) return 9;
    if (ms < 28.5) return 10;
    if (ms < 32.7) return 11;
    return 12;
  }

  String format(double windMs) {
    final value = convertFromMs(windMs);
    if (this == WindSpeedUnit.beaufort) {
      return '${value.toInt()} $symbol';
    }
    return '${value.toStringAsFixed(1)} $symbol';
  }
}

enum DepthUnit {
  meters('m', 'Metrit (m)'),
  feet('ft', 'Jalat (ft)');

  const DepthUnit(this.symbol, this.label);
  final String symbol;
  final String label;

  double convertFromMeters(double depthMeters) {
    switch (this) {
      case DepthUnit.meters:
        return depthMeters;
      case DepthUnit.feet:
        return depthMeters * 3.28084;
    }
  }

  String format(double depthMeters) {
    final value = convertFromMeters(depthMeters);
    return '${value.toStringAsFixed(1)} $symbol';
  }
}

class UnitSettings {
  const UnitSettings({
    this.speedUnit = SpeedUnit.knots,
    this.windSpeedUnit = WindSpeedUnit.ms,
    this.depthUnit = DepthUnit.meters,
  });

  final SpeedUnit speedUnit;
  final WindSpeedUnit windSpeedUnit;
  final DepthUnit depthUnit;

  UnitSettings copyWith({
    SpeedUnit? speedUnit,
    WindSpeedUnit? windSpeedUnit,
    DepthUnit? depthUnit,
  }) {
    return UnitSettings(
      speedUnit: speedUnit ?? this.speedUnit,
      windSpeedUnit: windSpeedUnit ?? this.windSpeedUnit,
      depthUnit: depthUnit ?? this.depthUnit,
    );
  }
}

class UnitPreferencesNotifier extends Notifier<UnitSettings> {
  static const _keySpeed = 'pref_unit_speed';
  static const _keyWind = 'pref_unit_wind';
  static const _keyDepth = 'pref_unit_depth';

  @override
  UnitSettings build() {
    _load();
    return const UnitSettings();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final speedIndex = prefs.getInt(_keySpeed);
      final windIndex = prefs.getInt(_keyWind);
      final depthIndex = prefs.getInt(_keyDepth);

      state = UnitSettings(
        speedUnit: speedIndex != null && speedIndex < SpeedUnit.values.length
            ? SpeedUnit.values[speedIndex]
            : SpeedUnit.knots,
        windSpeedUnit:
            windIndex != null && windIndex < WindSpeedUnit.values.length
            ? WindSpeedUnit.values[windIndex]
            : WindSpeedUnit.ms,
        depthUnit: depthIndex != null && depthIndex < DepthUnit.values.length
            ? DepthUnit.values[depthIndex]
            : DepthUnit.meters,
      );
    } catch (_) {
      // Default to standard marine units on error
    }
  }

  Future<void> setSpeedUnit(SpeedUnit unit) async {
    state = state.copyWith(speedUnit: unit);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keySpeed, unit.index);
    } catch (_) {}
  }

  Future<void> setWindSpeedUnit(WindSpeedUnit unit) async {
    state = state.copyWith(windSpeedUnit: unit);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyWind, unit.index);
    } catch (_) {}
  }

  Future<void> setDepthUnit(DepthUnit unit) async {
    state = state.copyWith(depthUnit: unit);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyDepth, unit.index);
    } catch (_) {}
  }
}

final unitPreferencesProvider =
    NotifierProvider<UnitPreferencesNotifier, UnitSettings>(
      UnitPreferencesNotifier.new,
    );
