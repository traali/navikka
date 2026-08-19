// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather_observations.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getWeatherObservations)
final getWeatherObservationsProvider = GetWeatherObservationsProvider._();

final class GetWeatherObservationsProvider
    extends
        $FunctionalProvider<
          GetWeatherObservations,
          GetWeatherObservations,
          GetWeatherObservations
        >
    with $Provider<GetWeatherObservations> {
  GetWeatherObservationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWeatherObservationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWeatherObservationsHash();

  @$internal
  @override
  $ProviderElement<GetWeatherObservations> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetWeatherObservations create(Ref ref) {
    return getWeatherObservations(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWeatherObservations value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWeatherObservations>(value),
    );
  }
}

String _$getWeatherObservationsHash() =>
    r'5a6e5ed9d913f087945deab376c7ae1ff9557000';
