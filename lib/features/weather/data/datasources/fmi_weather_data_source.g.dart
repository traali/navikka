// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fmi_weather_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fmiWeatherDataSource)
final fmiWeatherDataSourceProvider = FmiWeatherDataSourceProvider._();

final class FmiWeatherDataSourceProvider
    extends
        $FunctionalProvider<
          FmiWeatherDataSource,
          FmiWeatherDataSource,
          FmiWeatherDataSource
        >
    with $Provider<FmiWeatherDataSource> {
  FmiWeatherDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fmiWeatherDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fmiWeatherDataSourceHash();

  @$internal
  @override
  $ProviderElement<FmiWeatherDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FmiWeatherDataSource create(Ref ref) {
    return fmiWeatherDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FmiWeatherDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FmiWeatherDataSource>(value),
    );
  }
}

String _$fmiWeatherDataSourceHash() =>
    r'f52ff67383ab484f92591a7760f732fa1ee8c09a';
