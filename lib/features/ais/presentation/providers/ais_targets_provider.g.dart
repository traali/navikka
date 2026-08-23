// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ais_targets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AisTargetsNotifier)
final aisTargetsProvider = AisTargetsNotifierProvider._();

final class AisTargetsNotifierProvider
    extends $AsyncNotifierProvider<AisTargetsNotifier, List<AisTarget>> {
  AisTargetsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aisTargetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aisTargetsNotifierHash();

  @$internal
  @override
  AisTargetsNotifier create() => AisTargetsNotifier();
}

String _$aisTargetsNotifierHash() =>
    r'e1ead45e0743566503247cfc5152ec5c72540676';

abstract class _$AisTargetsNotifier extends $AsyncNotifier<List<AisTarget>> {
  FutureOr<List<AisTarget>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<AisTarget>>, List<AisTarget>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AisTarget>>, List<AisTarget>>,
              AsyncValue<List<AisTarget>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
