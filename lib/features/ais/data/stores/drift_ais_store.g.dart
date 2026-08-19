// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_ais_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aisMetadataStore)
final aisMetadataStoreProvider = AisMetadataStoreProvider._();

final class AisMetadataStoreProvider
    extends
        $FunctionalProvider<
          AisMetadataStore,
          AisMetadataStore,
          AisMetadataStore
        >
    with $Provider<AisMetadataStore> {
  AisMetadataStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aisMetadataStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aisMetadataStoreHash();

  @$internal
  @override
  $ProviderElement<AisMetadataStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AisMetadataStore create(Ref ref) {
    return aisMetadataStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AisMetadataStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AisMetadataStore>(value),
    );
  }
}

String _$aisMetadataStoreHash() => r'24d8e1e8b5a8f5274734d37ae286187a4144a6c0';
