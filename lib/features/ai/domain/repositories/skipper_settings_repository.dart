import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';

abstract class SkipperSettingsRepository {
  /// Get current settings.
  Future<Either<Failure, SkipperSettings>> getSettings();

  /// Update skipper settings.
  Future<Either<Failure, Unit>> updateSettings(SkipperSettings settings);

  /// Watch settings for reactive updates.
  Stream<SkipperSettings> watchSettings();

  /// Reset settings to defaults.
  Future<Either<Failure, Unit>> resetToDefaults();
}
