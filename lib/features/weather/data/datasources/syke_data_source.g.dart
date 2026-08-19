// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syke_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sykeDataSource)
final sykeDataSourceProvider = SykeDataSourceProvider._();

final class SykeDataSourceProvider
    extends $FunctionalProvider<SykeDataSource, SykeDataSource, SykeDataSource>
    with $Provider<SykeDataSource> {
  SykeDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sykeDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sykeDataSourceHash();

  @$internal
  @override
  $ProviderElement<SykeDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SykeDataSource create(Ref ref) {
    return sykeDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SykeDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SykeDataSource>(value),
    );
  }
}

String _$sykeDataSourceHash() => r'ab67a0220f2370ada6fa3746780e8436c8f1b893';
