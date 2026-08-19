import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/tracking/data/repositories/track_repository.dart';

void main() {
  late AppDatabase database;
  late TrackRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = TrackRepository(database);
  });

  tearDown(() async {
    repository.dispose();
    await database.close();
  });

  test('endTrack waits behind a full-buffer flush', () async {
    final trackId = (await repository.startTrack()).getOrElse((_) => -1);
    expect(trackId, greaterThan(0));

    for (var i = 0; i < 49; i++) {
      expect(
        (await repository.addPoint(trackId, 60, 25, 10)).isRight(),
        isTrue,
      );
    }

    final addFuture = repository.addPoint(trackId, 60, 25, 10);
    final endFuture = repository.endTrack(trackId, 123);
    final results = await Future.wait([addFuture, endFuture]);

    expect(results.every((result) => result.isRight()), isTrue);
    expect(await database.select(database.trackPoints).get(), hasLength(50));
    expect(
      (await database.select(database.recordedTracks).getSingle()).endTime,
      isNotNull,
    );
  });

  test('persists the GPS sample timestamp', () async {
    final trackId = (await repository.startTrack()).getOrElse((_) => -1);
    final sampledAt = DateTime.utc(2026, 7, 27, 12, 30);

    await repository.addPoint(
      trackId,
      60,
      25,
      10,
      timestamp: sampledAt,
    );
    await repository.endTrack(trackId, 0);

    final point = await database.select(database.trackPoints).getSingle();
    expect(point.timestamp.isAtSameMomentAs(sampledAt), isTrue);
  });
}
