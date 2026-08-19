// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'displayed_speed_limits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// efficiently filters speed limits for the current map viewport

@ProviderFor(displayedSpeedLimits)
final displayedSpeedLimitsProvider = DisplayedSpeedLimitsProvider._();

/// efficiently filters speed limits for the current map viewport

final class DisplayedSpeedLimitsProvider
    extends
        $FunctionalProvider<
          List<SpeedLimitZone>,
          List<SpeedLimitZone>,
          List<SpeedLimitZone>
        >
    with $Provider<List<SpeedLimitZone>> {
  /// efficiently filters speed limits for the current map viewport
  DisplayedSpeedLimitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedSpeedLimitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedSpeedLimitsHash();

  @$internal
  @override
  $ProviderElement<List<SpeedLimitZone>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<SpeedLimitZone> create(Ref ref) {
    return displayedSpeedLimits(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SpeedLimitZone> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SpeedLimitZone>>(value),
    );
  }
}

String _$displayedSpeedLimitsHash() =>
    r'9531d836710a6f3c6910862251dd7fd5b693b29f';
