import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/contribution/data/repositories/drift_contribution_repository.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftContributionRepository Concurrency', () {
    late AppDatabase db;
    late DriftContributionRepository repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = DriftContributionRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'Parallel unique saves should result in all items persisted',
      () async {
        const count = 100;
        final futures = List.generate(count, (i) {
          final contribution = UserContribution(
            id: 'id_$i',
            type: ContributionType.speedLimit,
            location: const LatLng(60, 24),
            value: '30',
            createdAt: DateTime.now().add(Duration(milliseconds: i)),
          );
          return repo.saveContribution(contribution);
        });

        await Future.wait(futures);

        final results = await repo.getAllContributions();
        final list = results.getOrElse((_) => []);
        expect(list.length, count);
      },
    );

    test(
      'Concurrent updates to same ID should NOT fail or corrupt state',
      () async {
        const id = 'same_id';
        const count = 50;
        final futures = List.generate(count, (i) {
          final contribution = UserContribution(
            id: id,
            type: ContributionType.speedLimit,
            location: const LatLng(61, 25),
            value: 'value_$i',
            createdAt: DateTime.now(),
          );
          return repo.saveContribution(contribution);
        });

        // These should all succeed (either insert or update)
        final results = await Future.wait(futures);
        expect(results.every((r) => r.isRight()), true);

        final all = await repo.getAllContributions();
        expect(all.getOrElse((_) => []), hasLength(1));
      },
    );
  });
}
