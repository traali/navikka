// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherLocalDataSource)
final weatherLocalDataSourceProvider = WeatherLocalDataSourceProvider._();

final class WeatherLocalDataSourceProvider
    extends
        $FunctionalProvider<
          WeatherLocalDataSource,
          WeatherLocalDataSource,
          WeatherLocalDataSource
        >
    with $Provider<WeatherLocalDataSource> {
  WeatherLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<WeatherLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherLocalDataSource create(Ref ref) {
    return weatherLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherLocalDataSource>(value),
    );
  }
}

String _$weatherLocalDataSourceHash() =>
    r'0d98cda31d2bfffde655a631e45b7a285174296e';
