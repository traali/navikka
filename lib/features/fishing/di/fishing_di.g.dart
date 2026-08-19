// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fishing_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fishingRemoteDataSource)
final fishingRemoteDataSourceProvider = FishingRemoteDataSourceProvider._();

final class FishingRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          FishingRemoteDataSource,
          FishingRemoteDataSource,
          FishingRemoteDataSource
        >
    with $Provider<FishingRemoteDataSource> {
  FishingRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fishingRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fishingRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FishingRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FishingRemoteDataSource create(Ref ref) {
    return fishingRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FishingRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FishingRemoteDataSource>(value),
    );
  }
}

String _$fishingRemoteDataSourceHash() =>
    r'140b31b2e21bdce5bd5af0aa060ca30b8394c7e3';

@ProviderFor(fishingLocalDataSource)
final fishingLocalDataSourceProvider = FishingLocalDataSourceProvider._();

final class FishingLocalDataSourceProvider
    extends
        $FunctionalProvider<
          FishingLocalDataSource,
          FishingLocalDataSource,
          FishingLocalDataSource
        >
    with $Provider<FishingLocalDataSource> {
  FishingLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fishingLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fishingLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<FishingLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FishingLocalDataSource create(Ref ref) {
    return fishingLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FishingLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FishingLocalDataSource>(value),
    );
  }
}

String _$fishingLocalDataSourceHash() =>
    r'b4766fdb0ddb1460aeac3b3288b182e9cc6dcd7e';

@ProviderFor(fishingRepository)
final fishingRepositoryProvider = FishingRepositoryProvider._();

final class FishingRepositoryProvider
    extends
        $FunctionalProvider<
          FishingRepository,
          FishingRepository,
          FishingRepository
        >
    with $Provider<FishingRepository> {
  FishingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fishingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fishingRepositoryHash();

  @$internal
  @override
  $ProviderElement<FishingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FishingRepository create(Ref ref) {
    return fishingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FishingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FishingRepository>(value),
    );
  }
}

String _$fishingRepositoryHash() => r'35490b4b5e0e19e7f612c3e874cb520001ac3959';

@ProviderFor(catchRepository)
final catchRepositoryProvider = CatchRepositoryProvider._();

final class CatchRepositoryProvider
    extends
        $FunctionalProvider<CatchRepository, CatchRepository, CatchRepository>
    with $Provider<CatchRepository> {
  CatchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catchRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catchRepositoryHash();

  @$internal
  @override
  $ProviderElement<CatchRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CatchRepository create(Ref ref) {
    return catchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatchRepository>(value),
    );
  }
}

String _$catchRepositoryHash() => r'fdb1759ee4e80d3f3550de612660f42b95779e1a';
