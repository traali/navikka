// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_weather_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PointWeatherController)
final pointWeatherControllerProvider = PointWeatherControllerProvider._();

final class PointWeatherControllerProvider
    extends $NotifierProvider<PointWeatherController, PointWeatherState> {
  PointWeatherControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pointWeatherControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pointWeatherControllerHash();

  @$internal
  @override
  PointWeatherController create() => PointWeatherController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PointWeatherState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PointWeatherState>(value),
    );
  }
}

String _$pointWeatherControllerHash() =>
    r'0c6b19ba5bf890192c1fb551d9b02ac2c9fbbd85';

abstract class _$PointWeatherController extends $Notifier<PointWeatherState> {
  PointWeatherState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PointWeatherState, PointWeatherState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PointWeatherState, PointWeatherState>,
              PointWeatherState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
