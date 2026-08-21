// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_aids_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HybridFairwayAreas)
final hybridFairwayAreasProvider = HybridFairwayAreasProvider._();

final class HybridFairwayAreasProvider
    extends $AsyncNotifierProvider<HybridFairwayAreas, List<FairwayArea>> {
  HybridFairwayAreasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hybridFairwayAreasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hybridFairwayAreasHash();

  @$internal
  @override
  HybridFairwayAreas create() => HybridFairwayAreas();
}

String _$hybridFairwayAreasHash() =>
    r'05b32282f46d7bb13bf008ee586cef44cabeeb2e';

abstract class _$HybridFairwayAreas extends $AsyncNotifier<List<FairwayArea>> {
  FutureOr<List<FairwayArea>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FairwayArea>>, List<FairwayArea>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FairwayArea>>, List<FairwayArea>>,
              AsyncValue<List<FairwayArea>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(HybridNavigationAids)
final hybridNavigationAidsProvider = HybridNavigationAidsProvider._();

final class HybridNavigationAidsProvider
    extends $AsyncNotifierProvider<HybridNavigationAids, List<NavigationAid>> {
  HybridNavigationAidsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hybridNavigationAidsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hybridNavigationAidsHash();

  @$internal
  @override
  HybridNavigationAids create() => HybridNavigationAids();
}

String _$hybridNavigationAidsHash() =>
    r'a173db2a6055131194fff7183d441fcc5d51e394';

abstract class _$HybridNavigationAids
    extends $AsyncNotifier<List<NavigationAid>> {
  FutureOr<List<NavigationAid>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<NavigationAid>>, List<NavigationAid>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<NavigationAid>>, List<NavigationAid>>,
              AsyncValue<List<NavigationAid>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(HybridNavigationLines)
final hybridNavigationLinesProvider = HybridNavigationLinesProvider._();

final class HybridNavigationLinesProvider
    extends
        $AsyncNotifierProvider<HybridNavigationLines, List<NavigationLine>> {
  HybridNavigationLinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hybridNavigationLinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hybridNavigationLinesHash();

  @$internal
  @override
  HybridNavigationLines create() => HybridNavigationLines();
}

String _$hybridNavigationLinesHash() =>
    r'd45896f045fb3888c35ccb30e81ec6018e3c317a';

abstract class _$HybridNavigationLines
    extends $AsyncNotifier<List<NavigationLine>> {
  FutureOr<List<NavigationLine>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<NavigationLine>>, List<NavigationLine>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NavigationLine>>,
                List<NavigationLine>
              >,
              AsyncValue<List<NavigationLine>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(displayedFairwayAreas)
final displayedFairwayAreasProvider = DisplayedFairwayAreasProvider._();

final class DisplayedFairwayAreasProvider
    extends
        $FunctionalProvider<
          List<FairwayArea>,
          List<FairwayArea>,
          List<FairwayArea>
        >
    with $Provider<List<FairwayArea>> {
  DisplayedFairwayAreasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedFairwayAreasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedFairwayAreasHash();

  @$internal
  @override
  $ProviderElement<List<FairwayArea>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<FairwayArea> create(Ref ref) {
    return displayedFairwayAreas(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FairwayArea> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FairwayArea>>(value),
    );
  }
}

String _$displayedFairwayAreasHash() =>
    r'71d3a0d78e2629ccd4b3363f1dc6c7959e198d81';

@ProviderFor(displayedNavigationAids)
final displayedNavigationAidsProvider = DisplayedNavigationAidsProvider._();

final class DisplayedNavigationAidsProvider
    extends
        $FunctionalProvider<
          List<NavigationAid>,
          List<NavigationAid>,
          List<NavigationAid>
        >
    with $Provider<List<NavigationAid>> {
  DisplayedNavigationAidsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedNavigationAidsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedNavigationAidsHash();

  @$internal
  @override
  $ProviderElement<List<NavigationAid>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<NavigationAid> create(Ref ref) {
    return displayedNavigationAids(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NavigationAid> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NavigationAid>>(value),
    );
  }
}

String _$displayedNavigationAidsHash() =>
    r'fecd817f2cda9136ead26aa710f384ba3f20c64a';

@ProviderFor(displayedNavigationLines)
final displayedNavigationLinesProvider = DisplayedNavigationLinesProvider._();

final class DisplayedNavigationLinesProvider
    extends
        $FunctionalProvider<
          List<NavigationLine>,
          List<NavigationLine>,
          List<NavigationLine>
        >
    with $Provider<List<NavigationLine>> {
  DisplayedNavigationLinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedNavigationLinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedNavigationLinesHash();

  @$internal
  @override
  $ProviderElement<List<NavigationLine>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<NavigationLine> create(Ref ref) {
    return displayedNavigationLines(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NavigationLine> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NavigationLine>>(value),
    );
  }
}

String _$displayedNavigationLinesHash() =>
    r'a694cad1f949dfc3480cd7e78e4f305ab08d2c4c';

@ProviderFor(fairwayAreaPolygons)
final fairwayAreaPolygonsProvider = FairwayAreaPolygonsProvider._();

final class FairwayAreaPolygonsProvider
    extends
        $FunctionalProvider<
          List<Polygon<Object>>,
          List<Polygon<Object>>,
          List<Polygon<Object>>
        >
    with $Provider<List<Polygon<Object>>> {
  FairwayAreaPolygonsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fairwayAreaPolygonsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fairwayAreaPolygonsHash();

  @$internal
  @override
  $ProviderElement<List<Polygon<Object>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Polygon<Object>> create(Ref ref) {
    return fairwayAreaPolygons(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Polygon<Object>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Polygon<Object>>>(value),
    );
  }
}

String _$fairwayAreaPolygonsHash() =>
    r'0ed8f5991c013b8b90034553143fc96b8bba4800';

@ProviderFor(displayedSafetyEquipment)
final displayedSafetyEquipmentProvider = DisplayedSafetyEquipmentProvider._();

final class DisplayedSafetyEquipmentProvider
    extends
        $FunctionalProvider<
          List<NavigationAid>,
          List<NavigationAid>,
          List<NavigationAid>
        >
    with $Provider<List<NavigationAid>> {
  DisplayedSafetyEquipmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedSafetyEquipmentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedSafetyEquipmentHash();

  @$internal
  @override
  $ProviderElement<List<NavigationAid>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<NavigationAid> create(Ref ref) {
    return displayedSafetyEquipment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NavigationAid> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NavigationAid>>(value),
    );
  }
}

String _$displayedSafetyEquipmentHash() =>
    r'8de567942fac9a883409cbfddc3d63e2fb635cc7';

@ProviderFor(navigationAidMarkers)
final navigationAidMarkersProvider = NavigationAidMarkersFamily._();

final class NavigationAidMarkersProvider
    extends $FunctionalProvider<List<Marker>, List<Marker>, List<Marker>>
    with $Provider<List<Marker>> {
  NavigationAidMarkersProvider._({
    required NavigationAidMarkersFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'navigationAidMarkersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$navigationAidMarkersHash();

  @override
  String toString() {
    return r'navigationAidMarkersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Marker>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Marker> create(Ref ref) {
    final argument = this.argument as bool;
    return navigationAidMarkers(ref, isFishingMode: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Marker> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Marker>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NavigationAidMarkersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$navigationAidMarkersHash() =>
    r'b838cfd961ffe557208a1cad441e45e06d461f0c';

final class NavigationAidMarkersFamily extends $Family
    with $FunctionalFamilyOverride<List<Marker>, bool> {
  NavigationAidMarkersFamily._()
    : super(
        retry: null,
        name: r'navigationAidMarkersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NavigationAidMarkersProvider call({required bool isFishingMode}) =>
      NavigationAidMarkersProvider._(argument: isFishingMode, from: this);

  @override
  String toString() => r'navigationAidMarkersProvider';
}

@ProviderFor(navigationLinePolylines)
final navigationLinePolylinesProvider = NavigationLinePolylinesProvider._();

final class NavigationLinePolylinesProvider
    extends
        $FunctionalProvider<
          List<Polyline<Object>>,
          List<Polyline<Object>>,
          List<Polyline<Object>>
        >
    with $Provider<List<Polyline<Object>>> {
  NavigationLinePolylinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationLinePolylinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationLinePolylinesHash();

  @$internal
  @override
  $ProviderElement<List<Polyline<Object>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Polyline<Object>> create(Ref ref) {
    return navigationLinePolylines(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Polyline<Object>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Polyline<Object>>>(value),
    );
  }
}

String _$navigationLinePolylinesHash() =>
    r'73652d832fda14d7fe15627852dec52456265ccf';

@ProviderFor(navigationLineDepthLabels)
final navigationLineDepthLabelsProvider = NavigationLineDepthLabelsProvider._();

final class NavigationLineDepthLabelsProvider
    extends $FunctionalProvider<List<Marker>, List<Marker>, List<Marker>>
    with $Provider<List<Marker>> {
  NavigationLineDepthLabelsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationLineDepthLabelsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationLineDepthLabelsHash();

  @$internal
  @override
  $ProviderElement<List<Marker>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Marker> create(Ref ref) {
    return navigationLineDepthLabels(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Marker> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Marker>>(value),
    );
  }
}

String _$navigationLineDepthLabelsHash() =>
    r'57df1241df860ecf712f8a7865c74c99fef27b23';
