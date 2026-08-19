// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherRemoteDataSource)
final weatherRemoteDataSourceProvider = WeatherRemoteDataSourceProvider._();

final class WeatherRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          WeatherRemoteDataSource,
          WeatherRemoteDataSource,
          WeatherRemoteDataSource
        >
    with $Provider<WeatherRemoteDataSource> {
  WeatherRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<WeatherRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherRemoteDataSource create(Ref ref) {
    return weatherRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherRemoteDataSource>(value),
    );
  }
}

String _$weatherRemoteDataSourceHash() =>
    r'79fdc1896fa5bfebc4abef05df90e727af09d020';
