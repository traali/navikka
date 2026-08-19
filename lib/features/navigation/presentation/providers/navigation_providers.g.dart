// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(waypointsForRoute)
final waypointsForRouteProvider = WaypointsForRouteFamily._();

final class WaypointsForRouteProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WaypointEntity>>,
          List<WaypointEntity>,
          FutureOr<List<WaypointEntity>>
        >
    with
        $FutureModifier<List<WaypointEntity>>,
        $FutureProvider<List<WaypointEntity>> {
  WaypointsForRouteProvider._({
    required WaypointsForRouteFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'waypointsForRouteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$waypointsForRouteHash();

  @override
  String toString() {
    return r'waypointsForRouteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WaypointEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WaypointEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return waypointsForRoute(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WaypointsForRouteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$waypointsForRouteHash() => r'e826eaed3bd0713a047a75026505fdd57ba08f64';

final class WaypointsForRouteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<WaypointEntity>>, int> {
  WaypointsForRouteFamily._()
    : super(
        retry: null,
        name: r'waypointsForRouteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WaypointsForRouteProvider call(int routeId) =>
      WaypointsForRouteProvider._(argument: routeId, from: this);

  @override
  String toString() => r'waypointsForRouteProvider';
}
