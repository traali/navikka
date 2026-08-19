// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'met_norway_ocean_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(metNorwayOceanSource)
final metNorwayOceanSourceProvider = MetNorwayOceanSourceProvider._();

final class MetNorwayOceanSourceProvider
    extends
        $FunctionalProvider<
          MetNorwayOceanSource,
          MetNorwayOceanSource,
          MetNorwayOceanSource
        >
    with $Provider<MetNorwayOceanSource> {
  MetNorwayOceanSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'metNorwayOceanSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$metNorwayOceanSourceHash();

  @$internal
  @override
  $ProviderElement<MetNorwayOceanSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MetNorwayOceanSource create(Ref ref) {
    return metNorwayOceanSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MetNorwayOceanSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MetNorwayOceanSource>(value),
    );
  }
}

String _$metNorwayOceanSourceHash() =>
    r'50865b266c18676574784bb9217ed652fceec4aa';
