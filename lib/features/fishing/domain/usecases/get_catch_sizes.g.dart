// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_catch_sizes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getCatchSizes)
final getCatchSizesProvider = GetCatchSizesProvider._();

final class GetCatchSizesProvider
    extends $FunctionalProvider<GetCatchSizes, GetCatchSizes, GetCatchSizes>
    with $Provider<GetCatchSizes> {
  GetCatchSizesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCatchSizesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCatchSizesHash();

  @$internal
  @override
  $ProviderElement<GetCatchSizes> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCatchSizes create(Ref ref) {
    return getCatchSizes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCatchSizes value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCatchSizes>(value),
    );
  }
}

String _$getCatchSizesHash() => r'741892da1139c02ba5be57c068201db30832062d';
