// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather_forecast.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getWeatherForecast)
final getWeatherForecastProvider = GetWeatherForecastProvider._();

final class GetWeatherForecastProvider
    extends
        $FunctionalProvider<
          GetWeatherForecast,
          GetWeatherForecast,
          GetWeatherForecast
        >
    with $Provider<GetWeatherForecast> {
  GetWeatherForecastProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWeatherForecastProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWeatherForecastHash();

  @$internal
  @override
  $ProviderElement<GetWeatherForecast> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetWeatherForecast create(Ref ref) {
    return getWeatherForecast(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWeatherForecast value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWeatherForecast>(value),
    );
  }
}

String _$getWeatherForecastHash() =>
    r'1617aa41cec13c92869793a6b7d7f11d0ea007b4';
