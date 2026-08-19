// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_weather_ui_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PointWeatherUiController)
final pointWeatherUiControllerProvider = PointWeatherUiControllerProvider._();

final class PointWeatherUiControllerProvider
    extends $NotifierProvider<PointWeatherUiController, PointWeatherUiState> {
  PointWeatherUiControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pointWeatherUiControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pointWeatherUiControllerHash();

  @$internal
  @override
  PointWeatherUiController create() => PointWeatherUiController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PointWeatherUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PointWeatherUiState>(value),
    );
  }
}

String _$pointWeatherUiControllerHash() =>
    r'95c6af49ba098930f9307f14a3aa6e61cf7847ad';

abstract class _$PointWeatherUiController
    extends $Notifier<PointWeatherUiState> {
  PointWeatherUiState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PointWeatherUiState, PointWeatherUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PointWeatherUiState, PointWeatherUiState>,
              PointWeatherUiState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
