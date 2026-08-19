// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recent_lightning.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getRecentLightning)
final getRecentLightningProvider = GetRecentLightningProvider._();

final class GetRecentLightningProvider
    extends
        $FunctionalProvider<
          GetRecentLightning,
          GetRecentLightning,
          GetRecentLightning
        >
    with $Provider<GetRecentLightning> {
  GetRecentLightningProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRecentLightningProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRecentLightningHash();

  @$internal
  @override
  $ProviderElement<GetRecentLightning> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRecentLightning create(Ref ref) {
    return getRecentLightning(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRecentLightning value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRecentLightning>(value),
    );
  }
}

String _$getRecentLightningHash() =>
    r'6302a805fd62312cf91d3601312ab44a00561853';
