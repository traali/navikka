// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_weather_sync_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PointWeatherSyncController)
final pointWeatherSyncControllerProvider =
    PointWeatherSyncControllerProvider._();

final class PointWeatherSyncControllerProvider
    extends
        $NotifierProvider<PointWeatherSyncController, PointWeatherSyncState> {
  PointWeatherSyncControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pointWeatherSyncControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pointWeatherSyncControllerHash();

  @$internal
  @override
  PointWeatherSyncController create() => PointWeatherSyncController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PointWeatherSyncState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PointWeatherSyncState>(value),
    );
  }
}

String _$pointWeatherSyncControllerHash() =>
    r'9225a663a640260112bda05ea71c042ff0e6efbf';

abstract class _$PointWeatherSyncController
    extends $Notifier<PointWeatherSyncState> {
  PointWeatherSyncState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PointWeatherSyncState, PointWeatherSyncState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PointWeatherSyncState, PointWeatherSyncState>,
              PointWeatherSyncState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
