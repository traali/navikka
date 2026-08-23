// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_intelligence_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Location-anchored Forecast Intelligence Provider.
/// Tracks weather snapshots for the SAME grid cell (<= 5km).
/// Guarantees that panning the map NEVER triggers false revision/disagreement alerts.

@ProviderFor(ForecastIntelligenceEngine)
final forecastIntelligenceEngineProvider =
    ForecastIntelligenceEngineProvider._();

/// Location-anchored Forecast Intelligence Provider.
/// Tracks weather snapshots for the SAME grid cell (<= 5km).
/// Guarantees that panning the map NEVER triggers false revision/disagreement alerts.
final class ForecastIntelligenceEngineProvider
    extends
        $NotifierProvider<
          ForecastIntelligenceEngine,
          ForecastIntelligenceState
        > {
  /// Location-anchored Forecast Intelligence Provider.
  /// Tracks weather snapshots for the SAME grid cell (<= 5km).
  /// Guarantees that panning the map NEVER triggers false revision/disagreement alerts.
  ForecastIntelligenceEngineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forecastIntelligenceEngineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forecastIntelligenceEngineHash();

  @$internal
  @override
  ForecastIntelligenceEngine create() => ForecastIntelligenceEngine();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForecastIntelligenceState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForecastIntelligenceState>(value),
    );
  }
}

String _$forecastIntelligenceEngineHash() =>
    r'f525b5e4745286959222937776144ab22f93d016';

/// Location-anchored Forecast Intelligence Provider.
/// Tracks weather snapshots for the SAME grid cell (<= 5km).
/// Guarantees that panning the map NEVER triggers false revision/disagreement alerts.

abstract class _$ForecastIntelligenceEngine
    extends $Notifier<ForecastIntelligenceState> {
  ForecastIntelligenceState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ForecastIntelligenceState, ForecastIntelligenceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ForecastIntelligenceState, ForecastIntelligenceState>,
              ForecastIntelligenceState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
