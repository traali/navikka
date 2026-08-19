// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_meteo_marine_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(openMeteoMarineDataSource)
final openMeteoMarineDataSourceProvider = OpenMeteoMarineDataSourceProvider._();

final class OpenMeteoMarineDataSourceProvider
    extends
        $FunctionalProvider<
          OpenMeteoMarineDataSource,
          OpenMeteoMarineDataSource,
          OpenMeteoMarineDataSource
        >
    with $Provider<OpenMeteoMarineDataSource> {
  OpenMeteoMarineDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openMeteoMarineDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openMeteoMarineDataSourceHash();

  @$internal
  @override
  $ProviderElement<OpenMeteoMarineDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenMeteoMarineDataSource create(Ref ref) {
    return openMeteoMarineDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenMeteoMarineDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenMeteoMarineDataSource>(value),
    );
  }
}

String _$openMeteoMarineDataSourceHash() =>
    r'6ae7878e1623714b25b4f122a6d6ebb10f466e20';
