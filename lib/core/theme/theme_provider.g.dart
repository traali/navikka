// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod Controller to read, write, and persist the theme selections in SharedPreferences.

@ProviderFor(AppThemeController)
final appThemeControllerProvider = AppThemeControllerProvider._();

/// Riverpod Controller to read, write, and persist the theme selections in SharedPreferences.
final class AppThemeControllerProvider
    extends $AsyncNotifierProvider<AppThemeController, AppThemeMode> {
  /// Riverpod Controller to read, write, and persist the theme selections in SharedPreferences.
  AppThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeControllerHash();

  @$internal
  @override
  AppThemeController create() => AppThemeController();
}

String _$appThemeControllerHash() =>
    r'c31a6254b24f2543bf6cc74152479c844c623184';

/// Riverpod Controller to read, write, and persist the theme selections in SharedPreferences.

abstract class _$AppThemeController extends $AsyncNotifier<AppThemeMode> {
  FutureOr<AppThemeMode> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppThemeMode>, AppThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppThemeMode>, AppThemeMode>,
              AsyncValue<AppThemeMode>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
