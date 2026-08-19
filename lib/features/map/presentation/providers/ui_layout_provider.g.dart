// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_layout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UiLayoutController)
final uiLayoutControllerProvider = UiLayoutControllerProvider._();

final class UiLayoutControllerProvider
    extends $NotifierProvider<UiLayoutController, UiLayout> {
  UiLayoutControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uiLayoutControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uiLayoutControllerHash();

  @$internal
  @override
  UiLayoutController create() => UiLayoutController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UiLayout value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UiLayout>(value),
    );
  }
}

String _$uiLayoutControllerHash() =>
    r'4e62bd0147bcd4becf755496d70ce686485b2ba2';

abstract class _$UiLayoutController extends $Notifier<UiLayout> {
  UiLayout build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UiLayout, UiLayout>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UiLayout, UiLayout>,
              UiLayout,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Glove & Rough Sea Mode state notifier: forces 64x64dp touch targets and 16dp spacing

@ProviderFor(RoughSeaModeController)
final roughSeaModeControllerProvider = RoughSeaModeControllerProvider._();

/// Glove & Rough Sea Mode state notifier: forces 64x64dp touch targets and 16dp spacing
final class RoughSeaModeControllerProvider
    extends $NotifierProvider<RoughSeaModeController, bool> {
  /// Glove & Rough Sea Mode state notifier: forces 64x64dp touch targets and 16dp spacing
  RoughSeaModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roughSeaModeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roughSeaModeControllerHash();

  @$internal
  @override
  RoughSeaModeController create() => RoughSeaModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$roughSeaModeControllerHash() =>
    r'118724ce0caf6fe8b5a8e4ed34609076b276e12b';

/// Glove & Rough Sea Mode state notifier: forces 64x64dp touch targets and 16dp spacing

abstract class _$RoughSeaModeController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
