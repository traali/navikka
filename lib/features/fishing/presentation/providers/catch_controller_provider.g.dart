// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catch_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for GetCatches use case

@ProviderFor(getCatches)
final getCatchesProvider = GetCatchesProvider._();

/// Provider for GetCatches use case

final class GetCatchesProvider
    extends $FunctionalProvider<GetCatches, GetCatches, GetCatches>
    with $Provider<GetCatches> {
  /// Provider for GetCatches use case
  GetCatchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCatchesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCatchesHash();

  @$internal
  @override
  $ProviderElement<GetCatches> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCatches create(Ref ref) {
    return getCatches(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCatches value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCatches>(value),
    );
  }
}

String _$getCatchesHash() => r'd8af139c0ee7afa9330107c0839916b3f5fbfa55';

/// Provider for RecordCatch use case

@ProviderFor(recordCatch)
final recordCatchProvider = RecordCatchProvider._();

/// Provider for RecordCatch use case

final class RecordCatchProvider
    extends $FunctionalProvider<RecordCatch, RecordCatch, RecordCatch>
    with $Provider<RecordCatch> {
  /// Provider for RecordCatch use case
  RecordCatchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recordCatchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recordCatchHash();

  @$internal
  @override
  $ProviderElement<RecordCatch> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecordCatch create(Ref ref) {
    return recordCatch(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecordCatch value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecordCatch>(value),
    );
  }
}

String _$recordCatchHash() => r'e9fc5f71de80e13d3b01bf8bb49e8f23bb42ed7e';

/// Controller for managing fish catch recording and retrieval.

@ProviderFor(CatchController)
final catchControllerProvider = CatchControllerProvider._();

/// Controller for managing fish catch recording and retrieval.
final class CatchControllerProvider
    extends $AsyncNotifierProvider<CatchController, List<FishCatch>> {
  /// Controller for managing fish catch recording and retrieval.
  CatchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catchControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catchControllerHash();

  @$internal
  @override
  CatchController create() => CatchController();
}

String _$catchControllerHash() => r'ec409e45fe51e6659736bae02750631b772904c9';

/// Controller for managing fish catch recording and retrieval.

abstract class _$CatchController extends $AsyncNotifier<List<FishCatch>> {
  FutureOr<List<FishCatch>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<FishCatch>>, List<FishCatch>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FishCatch>>, List<FishCatch>>,
              AsyncValue<List<FishCatch>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
