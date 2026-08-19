// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contribution_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod 3.x Notifier for managing contributions

@ProviderFor(Contribution)
final contributionProvider = ContributionProvider._();

/// Riverpod 3.x Notifier for managing contributions
final class ContributionProvider
    extends $AsyncNotifierProvider<Contribution, List<UserContribution>> {
  /// Riverpod 3.x Notifier for managing contributions
  ContributionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contributionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contributionHash();

  @$internal
  @override
  Contribution create() => Contribution();
}

String _$contributionHash() => r'911eaf70f844cfcc61c964d41e21e4a21e0e93af';

/// Riverpod 3.x Notifier for managing contributions

abstract class _$Contribution extends $AsyncNotifier<List<UserContribution>> {
  FutureOr<List<UserContribution>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<UserContribution>>, List<UserContribution>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserContribution>>,
                List<UserContribution>
              >,
              AsyncValue<List<UserContribution>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
