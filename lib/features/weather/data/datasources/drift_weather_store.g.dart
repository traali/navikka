// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_weather_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Weather data store using typed Drift tables.
///
/// Replaces JSON-blob storage with normalized, typed SQL schema.
/// Supports multiple providers (FMI, OpenWeather, MET Norway).

@ProviderFor(driftWeatherStore)
final driftWeatherStoreProvider = DriftWeatherStoreProvider._();

/// Weather data store using typed Drift tables.
///
/// Replaces JSON-blob storage with normalized, typed SQL schema.
/// Supports multiple providers (FMI, OpenWeather, MET Norway).

final class DriftWeatherStoreProvider
    extends
        $FunctionalProvider<
          DriftWeatherStore,
          DriftWeatherStore,
          DriftWeatherStore
        >
    with $Provider<DriftWeatherStore> {
  /// Weather data store using typed Drift tables.
  ///
  /// Replaces JSON-blob storage with normalized, typed SQL schema.
  /// Supports multiple providers (FMI, OpenWeather, MET Norway).
  DriftWeatherStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driftWeatherStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driftWeatherStoreHash();

  @$internal
  @override
  $ProviderElement<DriftWeatherStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DriftWeatherStore create(Ref ref) {
    return driftWeatherStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriftWeatherStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriftWeatherStore>(value),
    );
  }
}

String _$driftWeatherStoreHash() => r'fe6412ec9e93f5e6c37ca0a5503ceefb48680164';
