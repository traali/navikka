// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fishing_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FishingModeController)
final fishingModeControllerProvider = FishingModeControllerProvider._();

final class FishingModeControllerProvider
    extends $AsyncNotifierProvider<FishingModeController, FishingModeState> {
  FishingModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fishingModeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fishingModeControllerHash();

  @$internal
  @override
  FishingModeController create() => FishingModeController();
}

String _$fishingModeControllerHash() =>
    r'640a6a4ca0aecd0b351f38a9293c9eabae89393f';

abstract class _$FishingModeController
    extends $AsyncNotifier<FishingModeState> {
  FutureOr<FishingModeState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<FishingModeState>, FishingModeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FishingModeState>, FishingModeState>,
              AsyncValue<FishingModeState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
