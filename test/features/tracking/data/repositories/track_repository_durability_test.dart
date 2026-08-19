import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/tracking/data/repositories/track_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late TrackRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = TrackRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('TrackRepository Durability Tests', () {
    test(
      'flush() immediately persists buffered track points to SQLite',
      () async {
        final startRes = await repo.startTrack(name: 'Evening Cruise');
        expect(startRes.isRight(), isTrue);

        final trackId = startRes.getOrElse((_) => 0);

        // Add points to in-memory buffer
        await repo.addPoint(trackId, 60.1699, 24.9384, 12.5);

        // Call flush to await SQLite persistence
        await repo.flush();

        final points = await (db.select(
          db.trackPoints,
        )..where((p) => p.trackId.equals(trackId))).get();
        expect(points.length, equals(1));
        expect(points.first.latitude, equals(60.1699));
        expect(points.first.longitude, equals(24.9384));
      },
    );
  });
}
