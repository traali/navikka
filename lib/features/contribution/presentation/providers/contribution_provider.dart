import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/contribution/di/contribution_di.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';
import 'package:sakkoja/features/contribution/domain/repositories/contribution_repository.dart';
import 'package:uuid/uuid.dart';

part 'contribution_provider.g.dart';

// ============================================================================
// INJECTABLE REPOSITORY PROVIDER (V-001 FIX)
// ============================================================================

/// Riverpod 3.x Notifier for managing contributions
@Riverpod(keepAlive: true)
class Contribution extends _$Contribution {
  ContributionRepository get _repository =>
      ref.watch(contributionRepositoryProvider);

  @override
  Future<List<UserContribution>> build() async {
    final result = await _repository.getAllContributions();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (contributions) => contributions,
    );
  }

  Future<void> addContribution({
    required ContributionType type,
    required LatLng location,
    required String value,
  }) async {
    final contribution = UserContribution(
      id: const Uuid().v4(),
      type: type,
      location: location,
      value: value,
      createdAt: DateTime.now(),
    );

    // Optimistic update
    final previousData = state.value ?? [];
    state = AsyncValue.data([contribution, ...previousData]);

    final result = await _repository.saveContribution(contribution);

    result.fold(
      (failure) {
        // Revert on failure
        state = AsyncValue.data(previousData);
      },
      (_) {
        // Success - already updated optimistically
      },
    );
  }

  Future<void> deleteContribution(String id) async {
    final previousData = state.value ?? [];
    state = AsyncValue.data(previousData.where((c) => c.id != id).toList());

    final result = await _repository.deleteContribution(id);

    result.fold((failure) {
      state = AsyncValue.data(previousData);
    }, (_) {});
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(build);
  }
}
