// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speed_limit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for GetSpeedLimits UseCase - injectable for tests

@ProviderFor(getSpeedLimitsUseCase)
final getSpeedLimitsUseCaseProvider = GetSpeedLimitsUseCaseProvider._();

/// Provider for GetSpeedLimits UseCase - injectable for tests

final class GetSpeedLimitsUseCaseProvider
    extends $FunctionalProvider<GetSpeedLimits, GetSpeedLimits, GetSpeedLimits>
    with $Provider<GetSpeedLimits> {
  /// Provider for GetSpeedLimits UseCase - injectable for tests
  GetSpeedLimitsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSpeedLimitsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSpeedLimitsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetSpeedLimits> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetSpeedLimits create(Ref ref) {
    return getSpeedLimitsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSpeedLimits value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSpeedLimits>(value),
    );
  }
}

String _$getSpeedLimitsUseCaseHash() =>
    r'bee9ccda1b0242707379fac12fe60d12bbb7afbc';
