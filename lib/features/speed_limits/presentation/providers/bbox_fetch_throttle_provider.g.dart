// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bbox_fetch_throttle_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to manage fetch throttling for bbox API queries.
///
/// Implements "Smart Grid" strategy checking grid tiles.
/// Supports multiple data types via 'key' parameter.

@ProviderFor(BboxFetchThrottle)
final bboxFetchThrottleProvider = BboxFetchThrottleProvider._();

/// Provider to manage fetch throttling for bbox API queries.
///
/// Implements "Smart Grid" strategy checking grid tiles.
/// Supports multiple data types via 'key' parameter.
final class BboxFetchThrottleProvider
    extends $NotifierProvider<BboxFetchThrottle, BboxFetchState> {
  /// Provider to manage fetch throttling for bbox API queries.
  ///
  /// Implements "Smart Grid" strategy checking grid tiles.
  /// Supports multiple data types via 'key' parameter.
  BboxFetchThrottleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bboxFetchThrottleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bboxFetchThrottleHash();

  @$internal
  @override
  BboxFetchThrottle create() => BboxFetchThrottle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BboxFetchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BboxFetchState>(value),
    );
  }
}

String _$bboxFetchThrottleHash() => r'2827076a7bf910f8109fcb3b4917633b8fcd6a52';

/// Provider to manage fetch throttling for bbox API queries.
///
/// Implements "Smart Grid" strategy checking grid tiles.
/// Supports multiple data types via 'key' parameter.

abstract class _$BboxFetchThrottle extends $Notifier<BboxFetchState> {
  BboxFetchState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BboxFetchState, BboxFetchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BboxFetchState, BboxFetchState>,
              BboxFetchState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
