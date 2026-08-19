// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openweather_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(openWeatherDataSource)
final openWeatherDataSourceProvider = OpenWeatherDataSourceProvider._();

final class OpenWeatherDataSourceProvider
    extends
        $FunctionalProvider<
          OpenWeatherDataSource,
          OpenWeatherDataSource,
          OpenWeatherDataSource
        >
    with $Provider<OpenWeatherDataSource> {
  OpenWeatherDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openWeatherDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openWeatherDataSourceHash();

  @$internal
  @override
  $ProviderElement<OpenWeatherDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenWeatherDataSource create(Ref ref) {
    return openWeatherDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenWeatherDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenWeatherDataSource>(value),
    );
  }
}

String _$openWeatherDataSourceHash() =>
    r'499de73f7f37d1d0105d7954870c587918240c52';
