// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OfflineSelectionMode)
final offlineSelectionModeProvider = OfflineSelectionModeProvider._();

final class OfflineSelectionModeProvider
    extends $NotifierProvider<OfflineSelectionMode, bool> {
  OfflineSelectionModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineSelectionModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineSelectionModeHash();

  @$internal
  @override
  OfflineSelectionMode create() => OfflineSelectionMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$offlineSelectionModeHash() =>
    r'87e2d842566837c6678282af1890018027426e28';

abstract class _$OfflineSelectionMode extends $Notifier<bool> {
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

@ProviderFor(SelectionBounds)
final selectionBoundsProvider = SelectionBoundsProvider._();

final class SelectionBoundsProvider
    extends $NotifierProvider<SelectionBounds, LatLngBounds?> {
  SelectionBoundsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectionBoundsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectionBoundsHash();

  @$internal
  @override
  SelectionBounds create() => SelectionBounds();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LatLngBounds? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LatLngBounds?>(value),
    );
  }
}

String _$selectionBoundsHash() => r'8a97524bbcdecce9f136260d43fa37c3d900cdd2';

abstract class _$SelectionBounds extends $Notifier<LatLngBounds?> {
  LatLngBounds? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LatLngBounds?, LatLngBounds?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LatLngBounds?, LatLngBounds?>,
              LatLngBounds?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
