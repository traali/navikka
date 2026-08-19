// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_weather_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pointWeatherData)
final pointWeatherDataProvider = PointWeatherDataProvider._();

final class PointWeatherDataProvider
    extends
        $FunctionalProvider<
          PointWeatherDataState,
          PointWeatherDataState,
          PointWeatherDataState
        >
    with $Provider<PointWeatherDataState> {
  PointWeatherDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pointWeatherDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pointWeatherDataHash();

  @$internal
  @override
  $ProviderElement<PointWeatherDataState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PointWeatherDataState create(Ref ref) {
    return pointWeatherData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PointWeatherDataState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PointWeatherDataState>(value),
    );
  }
}

String _$pointWeatherDataHash() => r'20827bf1244953e45a2106f9a6f348f015cdba6a';
