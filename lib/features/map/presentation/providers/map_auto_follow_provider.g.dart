// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_auto_follow_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapAutoFollow)
final mapAutoFollowProvider = MapAutoFollowProvider._();

final class MapAutoFollowProvider
    extends $NotifierProvider<MapAutoFollow, bool> {
  MapAutoFollowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapAutoFollowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapAutoFollowHash();

  @$internal
  @override
  MapAutoFollow create() => MapAutoFollow();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$mapAutoFollowHash() => r'8468809007c48e1d155958b7dfc229403434ac87';

abstract class _$MapAutoFollow extends $Notifier<bool> {
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

@ProviderFor(MapNavigationModeNotifier)
final mapNavigationModeProvider = MapNavigationModeNotifierProvider._();

final class MapNavigationModeNotifierProvider
    extends $NotifierProvider<MapNavigationModeNotifier, MapNavigationMode> {
  MapNavigationModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapNavigationModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapNavigationModeNotifierHash();

  @$internal
  @override
  MapNavigationModeNotifier create() => MapNavigationModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapNavigationMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapNavigationMode>(value),
    );
  }
}

String _$mapNavigationModeNotifierHash() =>
    r'c02100989478c369828824bad0271042a6363690';

abstract class _$MapNavigationModeNotifier
    extends $Notifier<MapNavigationMode> {
  MapNavigationMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MapNavigationMode, MapNavigationMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapNavigationMode, MapNavigationMode>,
              MapNavigationMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(Map3dTiltNotifier)
final map3dTiltProvider = Map3dTiltNotifierProvider._();

final class Map3dTiltNotifierProvider
    extends $NotifierProvider<Map3dTiltNotifier, bool> {
  Map3dTiltNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'map3dTiltProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$map3dTiltNotifierHash();

  @$internal
  @override
  Map3dTiltNotifier create() => Map3dTiltNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$map3dTiltNotifierHash() => r'047ded0a12e4217dba8c366db17f4540dcbf5171';

abstract class _$Map3dTiltNotifier extends $Notifier<bool> {
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
