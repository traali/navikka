// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_aids_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(navigationAidsRemoteDataSource)
final navigationAidsRemoteDataSourceProvider =
    NavigationAidsRemoteDataSourceProvider._();

final class NavigationAidsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          NavigationAidsRemoteDataSource,
          NavigationAidsRemoteDataSource,
          NavigationAidsRemoteDataSource
        >
    with $Provider<NavigationAidsRemoteDataSource> {
  NavigationAidsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationAidsRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationAidsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<NavigationAidsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NavigationAidsRemoteDataSource create(Ref ref) {
    return navigationAidsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationAidsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationAidsRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$navigationAidsRemoteDataSourceHash() =>
    r'42620fc05e465c0357284e9a431d501ffcb123b8';

@ProviderFor(navigationAidsLocalDataSource)
final navigationAidsLocalDataSourceProvider =
    NavigationAidsLocalDataSourceProvider._();

final class NavigationAidsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          NavigationAidsLocalDataSource,
          NavigationAidsLocalDataSource,
          NavigationAidsLocalDataSource
        >
    with $Provider<NavigationAidsLocalDataSource> {
  NavigationAidsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationAidsLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationAidsLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<NavigationAidsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NavigationAidsLocalDataSource create(Ref ref) {
    return navigationAidsLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationAidsLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationAidsLocalDataSource>(
        value,
      ),
    );
  }
}

String _$navigationAidsLocalDataSourceHash() =>
    r'c578387874904b0f49f93efee2750467266c1538';

@ProviderFor(navigationAidsRepository)
final navigationAidsRepositoryProvider = NavigationAidsRepositoryProvider._();

final class NavigationAidsRepositoryProvider
    extends
        $FunctionalProvider<
          NavigationAidsRepository,
          NavigationAidsRepository,
          NavigationAidsRepository
        >
    with $Provider<NavigationAidsRepository> {
  NavigationAidsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationAidsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationAidsRepositoryHash();

  @$internal
  @override
  $ProviderElement<NavigationAidsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NavigationAidsRepository create(Ref ref) {
    return navigationAidsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationAidsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationAidsRepository>(value),
    );
  }
}

String _$navigationAidsRepositoryHash() =>
    r'4013cc89b00287b27134bf56f57be6d7862b4bde';
