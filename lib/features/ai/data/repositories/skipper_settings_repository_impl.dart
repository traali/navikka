import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ai/data/daos/skipper_settings_dao.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/repositories/skipper_settings_repository.dart';

part 'skipper_settings_repository_impl.g.dart';

const _secureStorage = FlutterSecureStorage();
const _apiKeySecureStorageKey = 'sakkoja_ai_api_key';

@Riverpod(keepAlive: true)
SkipperSettingsRepository skipperSettingsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SkipperSettingsRepositoryImpl(SkipperSettingsDao(db));
}

class SkipperSettingsRepositoryImpl implements SkipperSettingsRepository {
  SkipperSettingsRepositoryImpl(this._dao);
  final SkipperSettingsDao _dao;

  @override
  Future<Either<Failure, SkipperSettings>> getSettings() async {
    try {
      final entry = await _dao.getSettings();
      String? secureApiKey;
      try {
        secureApiKey = await _secureStorage.read(key: _apiKeySecureStorageKey);
      } catch (e) {
        Log.w('[SkipperSettings] Secure storage read failed: $e');
      }
      return Right(_mapToEntity(entry, secureApiKey: secureApiKey));
    } catch (e, s) {
      Log.w('[SkipperSettings] get failed', e, s);
      return Left(DatabaseFailure('Failed to load skipper settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSettings(SkipperSettings settings) async {
    try {
      if (settings.aiApiKey != null) {
        await _secureStorage.write(
          key: _apiKeySecureStorageKey,
          value: settings.aiApiKey,
        );
      } else {
        await _secureStorage.delete(key: _apiKeySecureStorageKey);
      }

      await _dao.updateSettings(
        SkipperSettingsTableCompanion(
          isAIEnabled: Value(settings.isAIEnabled),
          windYellowMs: Value(settings.thresholds.windYellowMs),
          windOrangeMs: Value(settings.thresholds.windOrangeMs),
          windRedMs: Value(settings.thresholds.windRedMs),
          waveYellowM: Value(settings.thresholds.waveYellowM),
          waveOrangeM: Value(settings.thresholds.waveOrangeM),
          waveRedM: Value(settings.thresholds.waveRedM),
          pressureDropThresholdHpa: Value(
            settings.thresholds.pressureDropThresholdHpa,
          ),
          forecastWindowHours: Value(settings.forecastWindowHours),
          hasAcknowledgedAISafety: Value(settings.hasAcknowledgedAISafety),
          aiApiKey: const Value(null), // Cleared from plain DB
          aiModelId: Value(settings.aiModelId),
        ),
      );
      return const Right(unit);
    } catch (e, s) {
      Log.w('[SkipperSettings] update failed', e, s);
      return Left(DatabaseFailure('Failed to update skipper settings: $e'));
    }
  }

  @override
  Stream<SkipperSettings> watchSettings() {
    return _dao.watchSettings().asyncMap((entry) async {
      String? secureApiKey;
      try {
        secureApiKey = await _secureStorage.read(key: _apiKeySecureStorageKey);
      } catch (_) {}
      return _mapToEntity(entry, secureApiKey: secureApiKey);
    });
  }

  @override
  Future<Either<Failure, Unit>> resetToDefaults() async {
    try {
      await _secureStorage.delete(key: _apiKeySecureStorageKey);
      await _dao.updateSettings(
        const SkipperSettingsTableCompanion(
          isAIEnabled: Value(true),
          windYellowMs: Value(10),
          windOrangeMs: Value(14),
          windRedMs: Value(17),
          waveYellowM: Value(1),
          waveOrangeM: Value(1.5),
          waveRedM: Value(2.5),
          pressureDropThresholdHpa: Value(2),
          forecastWindowHours: Value(3),
          hasAcknowledgedAISafety: Value(false),
          aiApiKey: Value(null),
          aiModelId: Value('meta-llama/llama-3.3-70b-instruct:free'),
        ),
      );
      return const Right(unit);
    } catch (e, s) {
      Log.w('[SkipperSettings] reset failed', e, s);
      return Left(DatabaseFailure('Failed to reset skipper settings: $e'));
    }
  }

  SkipperSettings _mapToEntity(
    SkipperSettingsEntry entry, {
    String? secureApiKey,
  }) {
    return SkipperSettings(
      isAIEnabled: entry.isAIEnabled,
      hasAcknowledgedAISafety: entry.hasAcknowledgedAISafety,
      forecastWindowHours: entry.forecastWindowHours,
      thresholds: SkipperThresholds(
        windYellowMs: entry.windYellowMs,
        windOrangeMs: entry.windOrangeMs,
        windRedMs: entry.windRedMs,
        waveYellowM: entry.waveYellowM,
        waveOrangeM: entry.waveOrangeM,
        waveRedM: entry.waveRedM,
        pressureDropThresholdHpa: entry.pressureDropThresholdHpa,
      ),
      aiApiKey: secureApiKey,
      aiModelId: entry.aiModelId,
    );
  }
}
