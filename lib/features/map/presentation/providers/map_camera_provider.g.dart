// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_camera_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapCameraPosition)
final mapCameraPositionProvider = MapCameraPositionProvider._();

final class MapCameraPositionProvider
    extends $NotifierProvider<MapCameraPosition, MapCameraState> {
  MapCameraPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapCameraPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapCameraPositionHash();

  @$internal
  @override
  MapCameraPosition create() => MapCameraPosition();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapCameraState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapCameraState>(value),
    );
  }
}

String _$mapCameraPositionHash() => r'3da708916e797b4b883b5507e8b2a2b85256c378';

abstract class _$MapCameraPosition extends $Notifier<MapCameraState> {
  MapCameraState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MapCameraState, MapCameraState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapCameraState, MapCameraState>,
              MapCameraState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(DebouncedMapCameraPosition)
final debouncedMapCameraPositionProvider =
    DebouncedMapCameraPositionProvider._();

final class DebouncedMapCameraPositionProvider
    extends $NotifierProvider<DebouncedMapCameraPosition, MapCameraState> {
  DebouncedMapCameraPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debouncedMapCameraPositionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debouncedMapCameraPositionHash();

  @$internal
  @override
  DebouncedMapCameraPosition create() => DebouncedMapCameraPosition();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapCameraState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapCameraState>(value),
    );
  }
}

String _$debouncedMapCameraPositionHash() =>
    r'2d1a20e2b6a8a1d71f4138a7429b5c26c86ab5d5';

abstract class _$DebouncedMapCameraPosition extends $Notifier<MapCameraState> {
  MapCameraState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MapCameraState, MapCameraState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapCameraState, MapCameraState>,
              MapCameraState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// A provider that only updates when the camera has moved significantly
/// (e.g. > 2km or zoom > 0.5 change) to prevent hammering spatial filters.

@ProviderFor(SignificantMapCameraPosition)
final significantMapCameraPositionProvider =
    SignificantMapCameraPositionProvider._();

/// A provider that only updates when the camera has moved significantly
/// (e.g. > 2km or zoom > 0.5 change) to prevent hammering spatial filters.
final class SignificantMapCameraPositionProvider
    extends $NotifierProvider<SignificantMapCameraPosition, MapCameraState> {
  /// A provider that only updates when the camera has moved significantly
  /// (e.g. > 2km or zoom > 0.5 change) to prevent hammering spatial filters.
  SignificantMapCameraPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'significantMapCameraPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$significantMapCameraPositionHash();

  @$internal
  @override
  SignificantMapCameraPosition create() => SignificantMapCameraPosition();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapCameraState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapCameraState>(value),
    );
  }
}

String _$significantMapCameraPositionHash() =>
    r'84ff003332e5b9fea05f727e963b9271640fe581';

/// A provider that only updates when the camera has moved significantly
/// (e.g. > 2km or zoom > 0.5 change) to prevent hammering spatial filters.

abstract class _$SignificantMapCameraPosition
    extends $Notifier<MapCameraState> {
  MapCameraState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MapCameraState, MapCameraState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapCameraState, MapCameraState>,
              MapCameraState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
