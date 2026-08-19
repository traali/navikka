import 'package:drift/drift.dart' hide equals, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/navigation/data/daos/route_dao.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late RouteDao routeDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    routeDao = RouteDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('RouteDao Atomic Transactions', () {
    test(
      'createRouteWithWaypoints atomically saves route and waypoints',
      () async {
        final routeId = await routeDao.createRouteWithWaypoints(
          RoutesCompanion(
            name: const Value('Helsinki Archipelago Circuit'),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
          [
            const WaypointsCompanion(
              lat: Value(60.1699),
              lon: Value(24.9384),
              orderIndex: Value(0),
              label: Value('Katajanokka'),
            ),
            const WaypointsCompanion(
              lat: Value(60.1442),
              lon: Value(24.9856),
              orderIndex: Value(1),
              label: Value('Suomenlinna'),
            ),
          ],
        );

        final route = await routeDao.getRouteById(routeId);
        expect(route, isNotNull);
        expect(route!.name, equals('Helsinki Archipelago Circuit'));

        final waypoints = await routeDao.getWaypointsForRoute(routeId);
        expect(waypoints.length, equals(2));
        expect(waypoints.first.label, equals('Katajanokka'));
        expect(waypoints.last.label, equals('Suomenlinna'));
      },
    );
  });
}
