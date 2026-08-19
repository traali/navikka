// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lightning_dismissal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod Notifier to track acknowledged/dismissed lightning strike timestamps.
///
/// Enables the skipper to "sign off" on active weather alerts ("I have seen these,
/// come back when updates"). Alerts will only re-appear if newer
/// lightning strikes are detected.

@ProviderFor(LightningDismissal)
final lightningDismissalProvider = LightningDismissalProvider._();

/// Riverpod Notifier to track acknowledged/dismissed lightning strike timestamps.
///
/// Enables the skipper to "sign off" on active weather alerts ("I have seen these,
/// come back when updates"). Alerts will only re-appear if newer
/// lightning strikes are detected.
final class LightningDismissalProvider
    extends $NotifierProvider<LightningDismissal, DateTime?> {
  /// Riverpod Notifier to track acknowledged/dismissed lightning strike timestamps.
  ///
  /// Enables the skipper to "sign off" on active weather alerts ("I have seen these,
  /// come back when updates"). Alerts will only re-appear if newer
  /// lightning strikes are detected.
  LightningDismissalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightningDismissalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightningDismissalHash();

  @$internal
  @override
  LightningDismissal create() => LightningDismissal();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$lightningDismissalHash() =>
    r'23849a5b35b79c12c3744ac3fea7baa608c2bf3c';

/// Riverpod Notifier to track acknowledged/dismissed lightning strike timestamps.
///
/// Enables the skipper to "sign off" on active weather alerts ("I have seen these,
/// come back when updates"). Alerts will only re-appear if newer
/// lightning strikes are detected.

abstract class _$LightningDismissal extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
