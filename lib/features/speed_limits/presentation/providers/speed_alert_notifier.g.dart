// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speed_alert_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier that monitors speed vs limits and triggers haptic alerts.
/// Use strictly for "Background/Headless" logic. UI should just listen.

@ProviderFor(SpeedAlertNotifier)
final speedAlertProvider = SpeedAlertNotifierProvider._();

/// Notifier that monitors speed vs limits and triggers haptic alerts.
/// Use strictly for "Background/Headless" logic. UI should just listen.
final class SpeedAlertNotifierProvider
    extends $NotifierProvider<SpeedAlertNotifier, void> {
  /// Notifier that monitors speed vs limits and triggers haptic alerts.
  /// Use strictly for "Background/Headless" logic. UI should just listen.
  SpeedAlertNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speedAlertProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speedAlertNotifierHash();

  @$internal
  @override
  SpeedAlertNotifier create() => SpeedAlertNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$speedAlertNotifierHash() =>
    r'2473bd01c7b1f7c103bee84740b4278006b37e5f';

/// Notifier that monitors speed vs limits and triggers haptic alerts.
/// Use strictly for "Background/Headless" logic. UI should just listen.

abstract class _$SpeedAlertNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
