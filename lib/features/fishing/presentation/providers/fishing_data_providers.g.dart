// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fishing_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Narrow watch-point for a fresh boat GPS fix, avoiding full [mapProvider]
/// rebuilds in consumers like [currentLocationRestrictions].

@ProviderFor(currentUserLocation)
final currentUserLocationProvider = CurrentUserLocationProvider._();

/// Narrow watch-point for a fresh boat GPS fix, avoiding full [mapProvider]
/// rebuilds in consumers like [currentLocationRestrictions].

final class CurrentUserLocationProvider
    extends
        $FunctionalProvider<
          ({bool hasLocation, LatLng? userLocation}),
          ({bool hasLocation, LatLng? userLocation}),
          ({bool hasLocation, LatLng? userLocation})
        >
    with $Provider<({bool hasLocation, LatLng? userLocation})> {
  /// Narrow watch-point for a fresh boat GPS fix, avoiding full [mapProvider]
  /// rebuilds in consumers like [currentLocationRestrictions].
  CurrentUserLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserLocationHash();

  @$internal
  @override
  $ProviderElement<({bool hasLocation, LatLng? userLocation})> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ({bool hasLocation, LatLng? userLocation}) create(Ref ref) {
    return currentUserLocation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({bool hasLocation, LatLng? userLocation}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<({bool hasLocation, LatLng? userLocation})>(value),
    );
  }
}

String _$currentUserLocationHash() =>
    r'2ee3c59d880afa44bbcc89e69e1e4a817d95501a';

/// Stable API request key for restrictions around the boat.

@ProviderFor(currentBoatSafetyTile)
final currentBoatSafetyTileProvider = CurrentBoatSafetyTileProvider._();

/// Stable API request key for restrictions around the boat.

final class CurrentBoatSafetyTileProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// Stable API request key for restrictions around the boat.
  CurrentBoatSafetyTileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBoatSafetyTileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBoatSafetyTileHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return currentBoatSafetyTile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentBoatSafetyTileHash() =>
    r'1b4f939057cde60e7f3f77f670a3489a0e41aa0e';

/// Provider for GetFishingRestrictions UseCase

@ProviderFor(getFishingRestrictions)
final getFishingRestrictionsProvider = GetFishingRestrictionsProvider._();

/// Provider for GetFishingRestrictions UseCase

final class GetFishingRestrictionsProvider
    extends
        $FunctionalProvider<
          GetFishingRestrictions,
          GetFishingRestrictions,
          GetFishingRestrictions
        >
    with $Provider<GetFishingRestrictions> {
  /// Provider for GetFishingRestrictions UseCase
  GetFishingRestrictionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFishingRestrictionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFishingRestrictionsHash();

  @$internal
  @override
  $ProviderElement<GetFishingRestrictions> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetFishingRestrictions create(Ref ref) {
    return getFishingRestrictions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetFishingRestrictions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetFishingRestrictions>(value),
    );
  }
}

String _$getFishingRestrictionsHash() =>
    r'acf47e7f0efdab590bc77e8508300884309a4b5c';

/// Provider for GetWaterwayFeatures UseCase

@ProviderFor(getWaterwayFeatures)
final getWaterwayFeaturesProvider = GetWaterwayFeaturesProvider._();

/// Provider for GetWaterwayFeatures UseCase

final class GetWaterwayFeaturesProvider
    extends
        $FunctionalProvider<
          GetWaterwayFeatures,
          GetWaterwayFeatures,
          GetWaterwayFeatures
        >
    with $Provider<GetWaterwayFeatures> {
  /// Provider for GetWaterwayFeatures UseCase
  GetWaterwayFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWaterwayFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWaterwayFeaturesHash();

  @$internal
  @override
  $ProviderElement<GetWaterwayFeatures> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetWaterwayFeatures create(Ref ref) {
    return getWaterwayFeatures(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWaterwayFeatures value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWaterwayFeatures>(value),
    );
  }
}

String _$getWaterwayFeaturesHash() =>
    r'568231f86b4fc40d49f6c27de22cfcdf91eaea0e';

@ProviderFor(HybridFishingRestrictions)
final hybridFishingRestrictionsProvider = HybridFishingRestrictionsProvider._();

final class HybridFishingRestrictionsProvider
    extends
        $AsyncNotifierProvider<
          HybridFishingRestrictions,
          List<FishingRestriction>
        > {
  HybridFishingRestrictionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hybridFishingRestrictionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hybridFishingRestrictionsHash();

  @$internal
  @override
  HybridFishingRestrictions create() => HybridFishingRestrictions();
}

String _$hybridFishingRestrictionsHash() =>
    r'154ff2f147c03f1dcf2de3f18deeab81af6274a5';

abstract class _$HybridFishingRestrictions
    extends $AsyncNotifier<List<FishingRestriction>> {
  FutureOr<List<FishingRestriction>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              rp.AsyncValue<List<FishingRestriction>>,
              List<FishingRestriction>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                rp.AsyncValue<List<FishingRestriction>>,
                List<FishingRestriction>
              >,
              rp.AsyncValue<List<FishingRestriction>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(HiddenRestrictionTypes)
final hiddenRestrictionTypesProvider = HiddenRestrictionTypesProvider._();

final class HiddenRestrictionTypesProvider
    extends $NotifierProvider<HiddenRestrictionTypes, Set<String>> {
  HiddenRestrictionTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hiddenRestrictionTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hiddenRestrictionTypesHash();

  @$internal
  @override
  HiddenRestrictionTypes create() => HiddenRestrictionTypes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$hiddenRestrictionTypesHash() =>
    r'edeec5b576d1ce9e7d6c3842682724b9e3ee3c1d';

abstract class _$HiddenRestrictionTypes extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredFishingRestrictions)
final filteredFishingRestrictionsProvider =
    FilteredFishingRestrictionsProvider._();

final class FilteredFishingRestrictionsProvider
    extends
        $FunctionalProvider<
          rp.AsyncValue<List<FishingRestriction>>,
          List<FishingRestriction>,
          FutureOr<List<FishingRestriction>>
        >
    with
        $FutureModifier<List<FishingRestriction>>,
        $FutureProvider<List<FishingRestriction>> {
  FilteredFishingRestrictionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredFishingRestrictionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredFishingRestrictionsHash();

  @$internal
  @override
  $FutureProviderElement<List<FishingRestriction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FishingRestriction>> create(Ref ref) {
    return filteredFishingRestrictions(ref);
  }
}

String _$filteredFishingRestrictionsHash() =>
    r'5c16d22dd8b92192f8b9ee326a39cc56771fbff9';

@ProviderFor(availableRestrictionTypes)
final availableRestrictionTypesProvider = AvailableRestrictionTypesProvider._();

final class AvailableRestrictionTypesProvider
    extends
        $FunctionalProvider<
          rp.AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  AvailableRestrictionTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableRestrictionTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableRestrictionTypesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return availableRestrictionTypes(ref);
  }
}

String _$availableRestrictionTypesHash() =>
    r'cc84a6cfda6f33bad26018c7acd9be50d6abcd8f';

@ProviderFor(HybridWaterwayFeatures)
final hybridWaterwayFeaturesProvider = HybridWaterwayFeaturesProvider._();

final class HybridWaterwayFeaturesProvider
    extends
        $AsyncNotifierProvider<HybridWaterwayFeatures, List<WaterwayFeature>> {
  HybridWaterwayFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hybridWaterwayFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hybridWaterwayFeaturesHash();

  @$internal
  @override
  HybridWaterwayFeatures create() => HybridWaterwayFeatures();
}

String _$hybridWaterwayFeaturesHash() =>
    r'630e244ffa7befe1cf00248b2342fba86a09e55c';

abstract class _$HybridWaterwayFeatures
    extends $AsyncNotifier<List<WaterwayFeature>> {
  FutureOr<List<WaterwayFeature>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              rp.AsyncValue<List<WaterwayFeature>>,
              List<WaterwayFeature>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                rp.AsyncValue<List<WaterwayFeature>>,
                List<WaterwayFeature>
              >,
              rp.AsyncValue<List<WaterwayFeature>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Synchronous provider for waterway features (fairways, beacons, buoys)
/// to eliminate UI flicker during map panning.

@ProviderFor(displayedWaterwayFeatures)
final displayedWaterwayFeaturesProvider = DisplayedWaterwayFeaturesProvider._();

/// Synchronous provider for waterway features (fairways, beacons, buoys)
/// to eliminate UI flicker during map panning.

final class DisplayedWaterwayFeaturesProvider
    extends
        $FunctionalProvider<
          List<WaterwayFeature>,
          List<WaterwayFeature>,
          List<WaterwayFeature>
        >
    with $Provider<List<WaterwayFeature>> {
  /// Synchronous provider for waterway features (fairways, beacons, buoys)
  /// to eliminate UI flicker during map panning.
  DisplayedWaterwayFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedWaterwayFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedWaterwayFeaturesHash();

  @$internal
  @override
  $ProviderElement<List<WaterwayFeature>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<WaterwayFeature> create(Ref ref) {
    return displayedWaterwayFeatures(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<WaterwayFeature> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<WaterwayFeature>>(value),
    );
  }
}

String _$displayedWaterwayFeaturesHash() =>
    r'6096475fdcaa949fe899593de1da29048e9ccd85';

/// Synchronous provider for fishing restrictions ready for display.
///
/// This replaces the async [visibleFishingRestrictionsProvider] to eliminate
/// UI flicker during map camera movements.

@ProviderFor(displayedFishingRestrictions)
final displayedFishingRestrictionsProvider =
    DisplayedFishingRestrictionsProvider._();

/// Synchronous provider for fishing restrictions ready for display.
///
/// This replaces the async [visibleFishingRestrictionsProvider] to eliminate
/// UI flicker during map camera movements.

final class DisplayedFishingRestrictionsProvider
    extends
        $FunctionalProvider<
          List<FishingRestriction>,
          List<FishingRestriction>,
          List<FishingRestriction>
        >
    with $Provider<List<FishingRestriction>> {
  /// Synchronous provider for fishing restrictions ready for display.
  ///
  /// This replaces the async [visibleFishingRestrictionsProvider] to eliminate
  /// UI flicker during map camera movements.
  DisplayedFishingRestrictionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedFishingRestrictionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedFishingRestrictionsHash();

  @$internal
  @override
  $ProviderElement<List<FishingRestriction>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<FishingRestriction> create(Ref ref) {
    return displayedFishingRestrictions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FishingRestriction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FishingRestriction>>(value),
    );
  }
}

String _$displayedFishingRestrictionsHash() =>
    r'921bdf9f6e4d23f1c3908a0485eb8b954a25cbb4';

/// Provider that returns restrictions covering the current user location.

@ProviderFor(currentLocationRestrictions)
final currentLocationRestrictionsProvider =
    CurrentLocationRestrictionsProvider._();

/// Provider that returns restrictions covering the current user location.

final class CurrentLocationRestrictionsProvider
    extends
        $FunctionalProvider<
          List<FishingRestriction>,
          List<FishingRestriction>,
          List<FishingRestriction>
        >
    with $Provider<List<FishingRestriction>> {
  /// Provider that returns restrictions covering the current user location.
  CurrentLocationRestrictionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentLocationRestrictionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentLocationRestrictionsHash();

  @$internal
  @override
  $ProviderElement<List<FishingRestriction>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<FishingRestriction> create(Ref ref) {
    return currentLocationRestrictions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FishingRestriction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FishingRestriction>>(value),
    );
  }
}

String _$currentLocationRestrictionsHash() =>
    r'18293763c621b9a4c645351205163a44a9da88e6';
