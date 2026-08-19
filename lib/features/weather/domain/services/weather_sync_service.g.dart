// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherSyncService)
final weatherSyncServiceProvider = WeatherSyncServiceProvider._();

final class WeatherSyncServiceProvider
    extends
        $FunctionalProvider<
          WeatherSyncService,
          WeatherSyncService,
          WeatherSyncService
        >
    with $Provider<WeatherSyncService> {
  WeatherSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherSyncServiceHash();

  @$internal
  @override
  $ProviderElement<WeatherSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherSyncService create(Ref ref) {
    return weatherSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherSyncService>(value),
    );
  }
}

String _$weatherSyncServiceHash() =>
    r'9f566f974389a3ff0a293fb50d1a024cd67fc9a8';
