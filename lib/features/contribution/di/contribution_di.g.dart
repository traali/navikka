// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contribution_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contributionRepository)
final contributionRepositoryProvider = ContributionRepositoryProvider._();

final class ContributionRepositoryProvider
    extends
        $FunctionalProvider<
          ContributionRepository,
          ContributionRepository,
          ContributionRepository
        >
    with $Provider<ContributionRepository> {
  ContributionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contributionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contributionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContributionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContributionRepository create(Ref ref) {
    return contributionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContributionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContributionRepository>(value),
    );
  }
}

String _$contributionRepositoryHash() =>
    r'50e43814420ab1bb9ec62cf8e868a5d00930aaa1';
