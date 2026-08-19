// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_layers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(memoizedSpeedLimitPolygons)
final memoizedSpeedLimitPolygonsProvider =
    MemoizedSpeedLimitPolygonsProvider._();

final class MemoizedSpeedLimitPolygonsProvider
    extends
        $FunctionalProvider<
          List<Polygon<Object>>,
          List<Polygon<Object>>,
          List<Polygon<Object>>
        >
    with $Provider<List<Polygon<Object>>> {
  MemoizedSpeedLimitPolygonsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memoizedSpeedLimitPolygonsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memoizedSpeedLimitPolygonsHash();

  @$internal
  @override
  $ProviderElement<List<Polygon<Object>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Polygon<Object>> create(Ref ref) {
    return memoizedSpeedLimitPolygons(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Polygon<Object>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Polygon<Object>>>(value),
    );
  }
}

String _$memoizedSpeedLimitPolygonsHash() =>
    r'11600f5c82ec58af0441f44c6e1554be9f1fd2ac';

@ProviderFor(memoizedRoutePolylines)
final memoizedRoutePolylinesProvider = MemoizedRoutePolylinesProvider._();

final class MemoizedRoutePolylinesProvider
    extends
        $FunctionalProvider<
          List<Polyline<Object>>,
          List<Polyline<Object>>,
          List<Polyline<Object>>
        >
    with $Provider<List<Polyline<Object>>> {
  MemoizedRoutePolylinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memoizedRoutePolylinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memoizedRoutePolylinesHash();

  @$internal
  @override
  $ProviderElement<List<Polyline<Object>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Polyline<Object>> create(Ref ref) {
    return memoizedRoutePolylines(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Polyline<Object>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Polyline<Object>>>(value),
    );
  }
}

String _$memoizedRoutePolylinesHash() =>
    r'c28711c96d79e89c7f9861ebfc7e78e77cef0707';

/// Active route polyline for navigation mode.
///
/// Renders the active route when navigation is in progress
/// and the route planner is not being used.

@ProviderFor(memoizedActiveRoutePolylines)
final memoizedActiveRoutePolylinesProvider =
    MemoizedActiveRoutePolylinesProvider._();

/// Active route polyline for navigation mode.
///
/// Renders the active route when navigation is in progress
/// and the route planner is not being used.

final class MemoizedActiveRoutePolylinesProvider
    extends
        $FunctionalProvider<
          List<Polyline<Object>>,
          List<Polyline<Object>>,
          List<Polyline<Object>>
        >
    with $Provider<List<Polyline<Object>>> {
  /// Active route polyline for navigation mode.
  ///
  /// Renders the active route when navigation is in progress
  /// and the route planner is not being used.
  MemoizedActiveRoutePolylinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memoizedActiveRoutePolylinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memoizedActiveRoutePolylinesHash();

  @$internal
  @override
  $ProviderElement<List<Polyline<Object>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Polyline<Object>> create(Ref ref) {
    return memoizedActiveRoutePolylines(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Polyline<Object>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Polyline<Object>>>(value),
    );
  }
}

String _$memoizedActiveRoutePolylinesHash() =>
    r'4fbf5a6b79f798c4023e51f5d8f96380ca92d430';
