// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_wave_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Forecast time slider offset in hours (0, 3, 6, 9, 12).

@ProviderFor(ForecastTimeOffset)
final forecastTimeOffsetProvider = ForecastTimeOffsetProvider._();

/// Forecast time slider offset in hours (0, 3, 6, 9, 12).
final class ForecastTimeOffsetProvider
    extends $NotifierProvider<ForecastTimeOffset, int> {
  /// Forecast time slider offset in hours (0, 3, 6, 9, 12).
  ForecastTimeOffsetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forecastTimeOffsetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forecastTimeOffsetHash();

  @$internal
  @override
  ForecastTimeOffset create() => ForecastTimeOffset();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$forecastTimeOffsetHash() =>
    r'ba91d98c099e04e9a2a45974194fd35155b6a55e';

/// Forecast time slider offset in hours (0, 3, 6, 9, 12).

abstract class _$ForecastTimeOffset extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(openMeteoWindDataSource)
final openMeteoWindDataSourceProvider = OpenMeteoWindDataSourceProvider._();

final class OpenMeteoWindDataSourceProvider
    extends
        $FunctionalProvider<
          OpenMeteoWindDataSource,
          OpenMeteoWindDataSource,
          OpenMeteoWindDataSource
        >
    with $Provider<OpenMeteoWindDataSource> {
  OpenMeteoWindDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openMeteoWindDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openMeteoWindDataSourceHash();

  @$internal
  @override
  $ProviderElement<OpenMeteoWindDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenMeteoWindDataSource create(Ref ref) {
    return openMeteoWindDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenMeteoWindDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenMeteoWindDataSource>(value),
    );
  }
}

String _$openMeteoWindDataSourceHash() =>
    r'4014dbec30dca55f38d513ce20d13c36178cae58';

/// Wind field provider returning spatial grid points for current camera viewport.
/// Evaluates ONLY when windWaveFeatureFlag is true to conserve battery/network.

@ProviderFor(windField)
final windFieldProvider = WindFieldProvider._();

/// Wind field provider returning spatial grid points for current camera viewport.
/// Evaluates ONLY when windWaveFeatureFlag is true to conserve battery/network.

final class WindFieldProvider
    extends
        $FunctionalProvider<
          AsyncValue<WindField>,
          WindField,
          FutureOr<WindField>
        >
    with $FutureModifier<WindField>, $FutureProvider<WindField> {
  /// Wind field provider returning spatial grid points for current camera viewport.
  /// Evaluates ONLY when windWaveFeatureFlag is true to conserve battery/network.
  WindFieldProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'windFieldProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$windFieldHash();

  @$internal
  @override
  $FutureProviderElement<WindField> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<WindField> create(Ref ref) {
    return windField(ref);
  }
}

String _$windFieldHash() => r'1e520946f800b16aaa9e4a3f3c8edc5b13919726';

/// Wave field provider returning significant wave height grid points.

@ProviderFor(waveField)
final waveFieldProvider = WaveFieldProvider._();

/// Wave field provider returning significant wave height grid points.

final class WaveFieldProvider
    extends
        $FunctionalProvider<
          AsyncValue<WaveField>,
          WaveField,
          FutureOr<WaveField>
        >
    with $FutureModifier<WaveField>, $FutureProvider<WaveField> {
  /// Wave field provider returning significant wave height grid points.
  WaveFieldProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'waveFieldProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$waveFieldHash();

  @$internal
  @override
  $FutureProviderElement<WaveField> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<WaveField> create(Ref ref) {
    return waveField(ref);
  }
}

String _$waveFieldHash() => r'8e2dbdf28df24365640b840959db826e6ffd6b9c';
