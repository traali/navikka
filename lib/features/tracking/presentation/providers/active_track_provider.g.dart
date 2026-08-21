// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_track_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveTrackNotifier)
final activeTrackProvider = ActiveTrackNotifierProvider._();

final class ActiveTrackNotifierProvider
    extends $NotifierProvider<ActiveTrackNotifier, TrackState> {
  ActiveTrackNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeTrackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeTrackNotifierHash();

  @$internal
  @override
  ActiveTrackNotifier create() => ActiveTrackNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackState>(value),
    );
  }
}

String _$activeTrackNotifierHash() =>
    r'affb48339d70fcb0e10737a627e4798236cad10f';

abstract class _$ActiveTrackNotifier extends $Notifier<TrackState> {
  TrackState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TrackState, TrackState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TrackState, TrackState>,
              TrackState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
