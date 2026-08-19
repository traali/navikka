// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ais_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aisRepository)
final aisRepositoryProvider = AisRepositoryProvider._();

final class AisRepositoryProvider
    extends $FunctionalProvider<AisRepository, AisRepository, AisRepository>
    with $Provider<AisRepository> {
  AisRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aisRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aisRepositoryHash();

  @$internal
  @override
  $ProviderElement<AisRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AisRepository create(Ref ref) {
    return aisRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AisRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AisRepository>(value),
    );
  }
}

String _$aisRepositoryHash() => r'03982cf5187823582b37effa13bd610713e91cfa';
