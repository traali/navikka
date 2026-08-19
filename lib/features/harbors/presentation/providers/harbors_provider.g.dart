// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harbors_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(harborRepository)
final harborRepositoryProvider = HarborRepositoryProvider._();

final class HarborRepositoryProvider
    extends
        $FunctionalProvider<
          HarborRepository,
          HarborRepository,
          HarborRepository
        >
    with $Provider<HarborRepository> {
  HarborRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'harborRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$harborRepositoryHash();

  @$internal
  @override
  $ProviderElement<HarborRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HarborRepository create(Ref ref) {
    return harborRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HarborRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HarborRepository>(value),
    );
  }
}

String _$harborRepositoryHash() => r'2764481c8d82744f0be79a194d79a8e30e95a35f';

@ProviderFor(HarborsNotifier)
final harborsProvider = HarborsNotifierProvider._();

final class HarborsNotifierProvider
    extends $AsyncNotifierProvider<HarborsNotifier, List<Harbor>> {
  HarborsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'harborsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$harborsNotifierHash();

  @$internal
  @override
  HarborsNotifier create() => HarborsNotifier();
}

String _$harborsNotifierHash() => r'a4ee4a2e3ad92b06a70250cc16c2b1760f61e75b';

abstract class _$HarborsNotifier extends $AsyncNotifier<List<Harbor>> {
  FutureOr<List<Harbor>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Harbor>>, List<Harbor>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Harbor>>, List<Harbor>>,
              AsyncValue<List<Harbor>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
