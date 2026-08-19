// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wave_layer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WaveLayerNotifier)
final waveLayerProvider = WaveLayerNotifierProvider._();

final class WaveLayerNotifierProvider
    extends $NotifierProvider<WaveLayerNotifier, bool> {
  WaveLayerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'waveLayerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$waveLayerNotifierHash();

  @$internal
  @override
  WaveLayerNotifier create() => WaveLayerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$waveLayerNotifierHash() => r'2ce1f270b693b09705f55faf9577f5e0bbfc8f74';

abstract class _$WaveLayerNotifier extends $Notifier<bool> {
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
