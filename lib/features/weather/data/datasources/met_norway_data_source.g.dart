// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'met_norway_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(metNorwayDataSource)
final metNorwayDataSourceProvider = MetNorwayDataSourceProvider._();

final class MetNorwayDataSourceProvider
    extends
        $FunctionalProvider<
          MetNorwayDataSource,
          MetNorwayDataSource,
          MetNorwayDataSource
        >
    with $Provider<MetNorwayDataSource> {
  MetNorwayDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'metNorwayDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$metNorwayDataSourceHash();

  @$internal
  @override
  $ProviderElement<MetNorwayDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MetNorwayDataSource create(Ref ref) {
    return metNorwayDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MetNorwayDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MetNorwayDataSource>(value),
    );
  }
}

String _$metNorwayDataSourceHash() =>
    r'bad322049a5a9dba8d76e040665b18f1874f720e';
