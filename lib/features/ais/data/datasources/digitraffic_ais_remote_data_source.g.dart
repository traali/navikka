// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digitraffic_ais_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(digitrafficAisRemoteDataSource)
final digitrafficAisRemoteDataSourceProvider =
    DigitrafficAisRemoteDataSourceProvider._();

final class DigitrafficAisRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          DigitrafficAisRemoteDataSource,
          DigitrafficAisRemoteDataSource,
          DigitrafficAisRemoteDataSource
        >
    with $Provider<DigitrafficAisRemoteDataSource> {
  DigitrafficAisRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'digitrafficAisRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$digitrafficAisRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<DigitrafficAisRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DigitrafficAisRemoteDataSource create(Ref ref) {
    return digitrafficAisRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DigitrafficAisRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DigitrafficAisRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$digitrafficAisRemoteDataSourceHash() =>
    r'c459ce96a14e4db34eba94500e1becac0c564beb';
