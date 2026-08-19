// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wave_observations.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getWaveObservations)
final getWaveObservationsProvider = GetWaveObservationsProvider._();

final class GetWaveObservationsProvider
    extends
        $FunctionalProvider<
          GetWaveObservations,
          GetWaveObservations,
          GetWaveObservations
        >
    with $Provider<GetWaveObservations> {
  GetWaveObservationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWaveObservationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWaveObservationsHash();

  @$internal
  @override
  $ProviderElement<GetWaveObservations> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetWaveObservations create(Ref ref) {
    return getWaveObservations(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWaveObservations value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWaveObservations>(value),
    );
  }
}

String _$getWaveObservationsHash() =>
    r'bc9dd502e506587fed8e8a26b214416d85a52d52';
