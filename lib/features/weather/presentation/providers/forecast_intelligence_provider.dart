import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/weather/domain/entities/forecast_snapshot.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

part 'forecast_intelligence_provider.g.dart';

/// State of the location-anchored forecast intelligence engine.
class ForecastIntelligenceState {
  const ForecastIntelligenceState({
    required this.gridKey,
    this.revisionEvent,
    this.disagreementEvent,
    this.lastSnapshot,
  });

  final String gridKey;
  final ForecastRevisionEvent? revisionEvent;
  final SourceDisagreementEvent? disagreementEvent;
  final ForecastSnapshot? lastSnapshot;

  bool get hasActiveAlert => revisionEvent != null || disagreementEvent != null;

  ForecastIntelligenceState copyWith({
    String? gridKey,
    ForecastRevisionEvent? revisionEvent,
    SourceDisagreementEvent? disagreementEvent,
    ForecastSnapshot? lastSnapshot,
  }) {
    return ForecastIntelligenceState(
      gridKey: gridKey ?? this.gridKey,
      revisionEvent: revisionEvent ?? this.revisionEvent,
      disagreementEvent: disagreementEvent ?? this.disagreementEvent,
      lastSnapshot: lastSnapshot ?? this.lastSnapshot,
    );
  }
}

/// Location-anchored Forecast Intelligence Provider.
/// Tracks weather snapshots for the SAME grid cell (<= 5km).
/// Guarantees that panning the map NEVER triggers false revision/disagreement alerts.
@riverpod
class ForecastIntelligenceEngine extends _$ForecastIntelligenceEngine {
  final Map<String, ForecastSnapshot> _snapshotStore = {};

  @override
  ForecastIntelligenceState build() {
    final camera = ref.watch(debouncedMapCameraPositionProvider);
    final weatherState = ref.watch(pointWeatherControllerProvider);

    final currentLoc = camera.center;
    final gridKey = LocationGridUtils.getGridKey(currentLoc);

    final weather = weatherState.weather;
    final wave = weatherState.wave;

    if (weather == null) {
      return ForecastIntelligenceState(gridKey: gridKey);
    }

    final newSnapshot = ForecastSnapshot(
      gridKey: gridKey,
      location: currentLoc,
      timestamp: DateTime.now(),
      windSpeed: weather.windSpeed,
      windGust: weather.windGust,
      waveHeight: wave?.waveHeight,
      pressure: weather.pressure,
    );

    // Check location anchoring:
    final previousSnapshot = _snapshotStore[gridKey];

    ForecastRevisionEvent? revision;
    if (previousSnapshot != null) {
      final distance = LocationGridUtils.distanceMeters(
        previousSnapshot.location,
        currentLoc,
      );

      // ONLY evaluate revision if location is <= 5000m (same location context)
      if (distance <= 5000) {
        final windDelta =
            (newSnapshot.windSpeed ?? 0) - (previousSnapshot.windSpeed ?? 0);
        final waveDelta =
            (newSnapshot.waveHeight ?? 0) - (previousSnapshot.waveHeight ?? 0);

        if (windDelta >= 3.5 || waveDelta >= 0.7) {
          revision = ForecastRevisionEvent(
            gridKey: gridKey,
            severity: ForecastAlertSeverity.orange,
            message:
                'Ennuste heikentyi selvästi: tuuli nousee aiempaa voimakkaammaksi (+${windDelta.toStringAsFixed(1)} m/s)',
            windDeltaMs: windDelta,
            waveDeltaMeters: waveDelta,
            detectedAt: DateTime.now(),
          );
        } else if (windDelta >= 2.0 || waveDelta >= 0.4) {
          revision = ForecastRevisionEvent(
            gridKey: gridKey,
            severity: ForecastAlertSeverity.yellow,
            message:
                'Ennuste päivittyi: tuuli vahvistuu (+${windDelta.toStringAsFixed(1)} m/s)',
            windDeltaMs: windDelta,
            waveDeltaMeters: waveDelta,
            detectedAt: DateTime.now(),
          );
        }
      }
    }

    // Save latest snapshot for this grid cell
    _snapshotStore[gridKey] = newSnapshot;

    // Detect Source Disagreement (comparing real observation and model forecasts)
    SourceDisagreementEvent? disagreement;
    final observedWind = weather.windSpeed;
    final forecastList = weatherState.forecast;

    if (observedWind != null) {
      // Find nearest forecasts for each provider
      double? fmiWind;
      double? metWind;
      double? openWeatherWind;

      for (final f in forecastList) {
        if (f.windSpeed == null) continue;
        if (f.providerId == 10 && fmiWind == null) {
          fmiWind = f.windSpeed;
        } else if (f.providerId == 5 && metWind == null) {
          metWind = f.windSpeed;
        } else if (f.providerId == 3 && openWeatherWind == null) {
          openWeatherWind = f.windSpeed;
        }
      }

      // Never invent a missing model. Compare only providers that actually answered.
      final modelWinds = <double>[
        if (fmiWind != null) fmiWind,
        if (metWind != null) metWind,
        if (openWeatherWind != null) openWeatherWind,
      ];
      if (modelWinds.isNotEmpty) {
        final minWind = modelWinds.reduce((a, b) => a < b ? a : b);
        final maxWind = modelWinds.reduce((a, b) => a > b ? a : b);
        final spread = modelWinds.length >= 2 ? maxWind - minWind : 0.0;
        final obsVsForecastSpread = fmiWind != null
            ? (observedWind - fmiWind).abs()
            : 0.0;
        final fmiTxt = fmiWind?.toStringAsFixed(1) ?? '—';
        final metTxt = metWind?.toStringAsFixed(1) ?? '—';

        if (spread >= 4.0 || obsVsForecastSpread >= 3.5) {
          disagreement = SourceDisagreementEvent(
            gridKey: gridKey,
            severity: ForecastAlertSeverity.orange,
            message:
                'Mitattu havainto: ${observedWind.toStringAsFixed(1)} m/s · Malleissa merkittäviä eroja: FMI $fmiTxt m/s, MET $metTxt m/s — suosi varovaisempaa arviota',
            minWindMs: minWind,
            maxWindMs: maxWind,
            minWaveMeters: wave?.waveHeight ?? 0,
            maxWaveMeters: wave?.waveHeight ?? 0,
            fmiWindMs: fmiWind,
            metWindMs: metWind,
            openWeatherWindMs: openWeatherWind,
            observedWindMs: observedWind,
          );
        } else if (spread >= 2.0 || obsVsForecastSpread >= 2.0) {
          disagreement = SourceDisagreementEvent(
            gridKey: gridKey,
            severity: ForecastAlertSeverity.yellow,
            message:
                'Mitattu havainto: ${observedWind.toStringAsFixed(1)} m/s · Ennusteet: FMI $fmiTxt m/s · MET $metTxt m/s',
            minWindMs: minWind,
            maxWindMs: maxWind,
            minWaveMeters: wave?.waveHeight ?? 0,
            maxWaveMeters: wave?.waveHeight ?? 0,
            fmiWindMs: fmiWind,
            metWindMs: metWind,
            openWeatherWindMs: openWeatherWind,
            observedWindMs: observedWind,
          );
        }
      }
    }

    return ForecastIntelligenceState(
      gridKey: gridKey,
      revisionEvent: revision,
      disagreementEvent: disagreement,
      lastSnapshot: newSnapshot,
    );
  }
}
