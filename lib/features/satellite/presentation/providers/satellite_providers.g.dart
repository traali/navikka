// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'satellite_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for initial and tracked satellite viewer location.
/// Defaults to current vessel/user GPS location, with fallback to Finnish coastal center.

@ProviderFor(satelliteInitialLocation)
final satelliteInitialLocationProvider = SatelliteInitialLocationProvider._();

/// Provider for initial and tracked satellite viewer location.
/// Defaults to current vessel/user GPS location, with fallback to Finnish coastal center.

final class SatelliteInitialLocationProvider
    extends $FunctionalProvider<LatLng, LatLng, LatLng>
    with $Provider<LatLng> {
  /// Provider for initial and tracked satellite viewer location.
  /// Defaults to current vessel/user GPS location, with fallback to Finnish coastal center.
  SatelliteInitialLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'satelliteInitialLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$satelliteInitialLocationHash();

  @$internal
  @override
  $ProviderElement<LatLng> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LatLng create(Ref ref) {
    return satelliteInitialLocation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LatLng value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LatLng>(value),
    );
  }
}

String _$satelliteInitialLocationHash() =>
    r'b21645755001cba733f8421ebd7fff1c974d2f94';

@ProviderFor(SatelliteController)
final satelliteControllerProvider = SatelliteControllerProvider._();

final class SatelliteControllerProvider
    extends $NotifierProvider<SatelliteController, SatelliteState> {
  SatelliteControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'satelliteControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$satelliteControllerHash();

  @$internal
  @override
  SatelliteController create() => SatelliteController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SatelliteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SatelliteState>(value),
    );
  }
}

String _$satelliteControllerHash() =>
    r'1089b6592b60d9267e98c51e5bcdf5a686183104';

abstract class _$SatelliteController extends $Notifier<SatelliteState> {
  SatelliteState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SatelliteState, SatelliteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SatelliteState, SatelliteState>,
              SatelliteState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
