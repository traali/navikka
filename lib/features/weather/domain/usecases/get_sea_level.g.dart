// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sea_level.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getSeaLevel)
final getSeaLevelProvider = GetSeaLevelProvider._();

final class GetSeaLevelProvider
    extends $FunctionalProvider<GetSeaLevel, GetSeaLevel, GetSeaLevel>
    with $Provider<GetSeaLevel> {
  GetSeaLevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSeaLevelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSeaLevelHash();

  @$internal
  @override
  $ProviderElement<GetSeaLevel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetSeaLevel create(Ref ref) {
    return getSeaLevel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSeaLevel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSeaLevel>(value),
    );
  }
}

String _$getSeaLevelHash() => r'cc47aa71eff52d3276237cead9c7ed8f1c19ee78';
