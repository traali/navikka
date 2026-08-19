// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catch_size_validator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(catchSizeValidator)
final catchSizeValidatorProvider = CatchSizeValidatorProvider._();

final class CatchSizeValidatorProvider
    extends
        $FunctionalProvider<
          CatchSizeValidator,
          CatchSizeValidator,
          CatchSizeValidator
        >
    with $Provider<CatchSizeValidator> {
  CatchSizeValidatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catchSizeValidatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catchSizeValidatorHash();

  @$internal
  @override
  $ProviderElement<CatchSizeValidator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CatchSizeValidator create(Ref ref) {
    return catchSizeValidator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatchSizeValidator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatchSizeValidator>(value),
    );
  }
}

String _$catchSizeValidatorHash() =>
    r'92c5fddef8c7b406ce118901b8a3c18c75cd4915';
