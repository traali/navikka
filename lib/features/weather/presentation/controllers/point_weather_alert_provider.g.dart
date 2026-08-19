// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_weather_alert_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pointWeatherAlert)
final pointWeatherAlertProvider = PointWeatherAlertProvider._();

final class PointWeatherAlertProvider
    extends
        $FunctionalProvider<
          PointWeatherAlertState,
          PointWeatherAlertState,
          PointWeatherAlertState
        >
    with $Provider<PointWeatherAlertState> {
  PointWeatherAlertProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pointWeatherAlertProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pointWeatherAlertHash();

  @$internal
  @override
  $ProviderElement<PointWeatherAlertState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PointWeatherAlertState create(Ref ref) {
    return pointWeatherAlert(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PointWeatherAlertState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PointWeatherAlertState>(value),
    );
  }
}

String _$pointWeatherAlertHash() => r'169918d465de42d16d9283dd37dce0951d692e4f';
