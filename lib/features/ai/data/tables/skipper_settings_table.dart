import 'package:drift/drift.dart';

/// Table to store user-configurable settings for the Virtual Skipper.
/// This table will contain exactly one row (id = 1).
@DataClassName('SkipperSettingsEntry')
class SkipperSettingsTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();

  BoolColumn get isAIEnabled => boolean().withDefault(const Constant(true))();

  // Thresholds
  RealColumn get windYellowMs => real().withDefault(const Constant(10))();
  RealColumn get windOrangeMs => real().withDefault(const Constant(14))();
  RealColumn get windRedMs => real().withDefault(const Constant(17))();

  RealColumn get waveYellowM => real().withDefault(const Constant(1))();
  RealColumn get waveOrangeM => real().withDefault(const Constant(1.5))();
  RealColumn get waveRedM => real().withDefault(const Constant(2.5))();

  RealColumn get pressureDropThresholdHpa =>
      real().withDefault(const Constant(2))();

  // Phase 3: Predictive window in hours (3, 6, 12)
  IntColumn get forecastWindowHours =>
      integer().withDefault(const Constant(3))();

  // Phase 4: Legal acknowledgement
  BoolColumn get hasAcknowledgedAISafety =>
      boolean().withDefault(const Constant(false))();

  // Epic B: AI-Enhanced Alert Explanations configuration
  TextColumn get aiApiKey => text().nullable()();

  TextColumn get aiModelId => text().withDefault(
    const Constant('meta-llama/llama-3.3-70b-instruct:free'),
  )();

  @override
  Set<Column> get primaryKey => {id};
}
