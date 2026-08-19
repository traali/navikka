// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapLocalDataSource)
final mapLocalDataSourceProvider = MapLocalDataSourceProvider._();

final class MapLocalDataSourceProvider
    extends
        $FunctionalProvider<
          MapLocalDataSource,
          MapLocalDataSource,
          MapLocalDataSource
        >
    with $Provider<MapLocalDataSource> {
  MapLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<MapLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MapLocalDataSource create(Ref ref) {
    return mapLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapLocalDataSource>(value),
    );
  }
}

String _$mapLocalDataSourceHash() =>
    r'6571798e63424897293dd20f87dbaa0fa9621681';

@ProviderFor(mapRepository)
final mapRepositoryProvider = MapRepositoryProvider._();

final class MapRepositoryProvider
    extends $FunctionalProvider<MapRepository, MapRepository, MapRepository>
    with $Provider<MapRepository> {
  MapRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapRepositoryHash();

  @$internal
  @override
  $ProviderElement<MapRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MapRepository create(Ref ref) {
    return mapRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapRepository>(value),
    );
  }
}

String _$mapRepositoryHash() => r'3847d17426ddfcbca2a2341d209f77d0a63e2f72';

@ProviderFor(zoneSpatialService)
final zoneSpatialServiceProvider = ZoneSpatialServiceProvider._();

final class ZoneSpatialServiceProvider
    extends
        $FunctionalProvider<
          ZoneSpatialService,
          ZoneSpatialService,
          ZoneSpatialService
        >
    with $Provider<ZoneSpatialService> {
  ZoneSpatialServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'zoneSpatialServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$zoneSpatialServiceHash();

  @$internal
  @override
  $ProviderElement<ZoneSpatialService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ZoneSpatialService create(Ref ref) {
    return zoneSpatialService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ZoneSpatialService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ZoneSpatialService>(value),
    );
  }
}

String _$zoneSpatialServiceHash() =>
    r'dd5778d26804a88a8216bc4bd6242b3bf519bc06';
