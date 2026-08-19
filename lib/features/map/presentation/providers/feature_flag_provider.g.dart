// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Feature flag for experimental dynamic Wind & Wave visualization layers.
/// Default: false (off for zero impact on core navigation performance).

@ProviderFor(WindWaveFeatureFlag)
final windWaveFeatureFlagProvider = WindWaveFeatureFlagProvider._();

/// Feature flag for experimental dynamic Wind & Wave visualization layers.
/// Default: false (off for zero impact on core navigation performance).
final class WindWaveFeatureFlagProvider
    extends $NotifierProvider<WindWaveFeatureFlag, bool> {
  /// Feature flag for experimental dynamic Wind & Wave visualization layers.
  /// Default: false (off for zero impact on core navigation performance).
  WindWaveFeatureFlagProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'windWaveFeatureFlagProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$windWaveFeatureFlagHash();

  @$internal
  @override
  WindWaveFeatureFlag create() => WindWaveFeatureFlag();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$windWaveFeatureFlagHash() =>
    r'031c560d0443ae8f4271d721ce7afd1eed43f72b';

/// Feature flag for experimental dynamic Wind & Wave visualization layers.
/// Default: false (off for zero impact on core navigation performance).

abstract class _$WindWaveFeatureFlag extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
