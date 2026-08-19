// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_weather_lightning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A bounded-resolution boat position for weather safety calculations.
///
/// Lightning warning thresholds are measured in kilometres. Recomputing the
/// nearest strike for sub-metre GPS jitter adds load without useful accuracy,
/// while a 25 metre grid still updates promptly at boating speeds.

@ProviderFor(safetyBoatPosition)
final safetyBoatPositionProvider = SafetyBoatPositionProvider._();

/// A bounded-resolution boat position for weather safety calculations.
///
/// Lightning warning thresholds are measured in kilometres. Recomputing the
/// nearest strike for sub-metre GPS jitter adds load without useful accuracy,
/// while a 25 metre grid still updates promptly at boating speeds.

final class SafetyBoatPositionProvider
    extends $FunctionalProvider<LatLng?, LatLng?, LatLng?>
    with $Provider<LatLng?> {
  /// A bounded-resolution boat position for weather safety calculations.
  ///
  /// Lightning warning thresholds are measured in kilometres. Recomputing the
  /// nearest strike for sub-metre GPS jitter adds load without useful accuracy,
  /// while a 25 metre grid still updates promptly at boating speeds.
  SafetyBoatPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'safetyBoatPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$safetyBoatPositionHash();

  @$internal
  @override
  $ProviderElement<LatLng?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LatLng? create(Ref ref) {
    return safetyBoatPosition(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LatLng? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LatLng?>(value),
    );
  }
}

String _$safetyBoatPositionHash() =>
    r'039c49257f417423d611608a809ba8f5ce970dd2';

@ProviderFor(lightningProximity)
final lightningProximityProvider = LightningProximityProvider._();

final class LightningProximityProvider
    extends $FunctionalProvider<AsyncValue<double?>, double?, FutureOr<double?>>
    with $FutureModifier<double?>, $FutureProvider<double?> {
  LightningProximityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightningProximityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightningProximityHash();

  @$internal
  @override
  $FutureProviderElement<double?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double?> create(Ref ref) {
    return lightningProximity(ref);
  }
}

String _$lightningProximityHash() =>
    r'6141710cf10f9161f94cb6918943c65fec6129ec';
