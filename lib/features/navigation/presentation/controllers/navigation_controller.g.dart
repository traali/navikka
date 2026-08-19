// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavigationController)
final navigationControllerProvider = NavigationControllerProvider._();

final class NavigationControllerProvider
    extends $AsyncNotifierProvider<NavigationController, NavigationState> {
  NavigationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationControllerHash();

  @$internal
  @override
  NavigationController create() => NavigationController();
}

String _$navigationControllerHash() =>
    r'91d99e48198785d576923973425ff074770fbc77';

abstract class _$NavigationController extends $AsyncNotifier<NavigationState> {
  FutureOr<NavigationState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NavigationState>, NavigationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NavigationState>, NavigationState>,
              AsyncValue<NavigationState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
