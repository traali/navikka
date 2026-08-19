import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/speed_limits/di/speed_limits_di.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/usecases/get_speed_limits.dart';

part 'speed_limit_provider.g.dart';

/// Provider for GetSpeedLimits UseCase - injectable for tests
@riverpod
GetSpeedLimits getSpeedLimitsUseCase(Ref ref) =>
    GetSpeedLimits(ref.watch(speedLimitRepositoryProvider));

// ============================================================================
// SPEED LIMIT PROVIDERS
// ============================================================================

/// Provider for all speed limits (no bbox filtering)
/// Used for offline/bundled data loading
final speedLimitsProvider = FutureProvider<List<SpeedLimitZone>>((ref) async {
  // Get UseCase from injectable provider (testable!)
  final getSpeedLimits = ref.watch(getSpeedLimitsUseCaseProvider);

  // Execute
  final result = await getSpeedLimits();

  // Handle Either
  return result.fold((failure) {
    Log.e('speedLimitsProvider: Failed to load zones: ${failure.message}');
    throw Exception('Failed to load speed limit zones: ${failure.message}');
  }, (zones) => zones);
});
