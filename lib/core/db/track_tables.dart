import 'package:drift/drift.dart';

@DataClassName('RecordedTrack')
class RecordedTracks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  BoolColumn get isFishingMode =>
      boolean().withDefault(const Constant(false))();
  RealColumn get totalDistanceMeters => real().withDefault(const Constant(0))();
}

@DataClassName('TrackPoint')
class TrackPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get trackId =>
      integer().references(RecordedTracks, #id, onDelete: KeyAction.cascade)();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get speedKmh => real()();
  DateTimeColumn get timestamp => dateTime()();
}
