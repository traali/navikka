import 'package:drift/drift.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/navigation/data/tables.dart';

part 'route_dao.g.dart';

@DriftAccessor(tables: [Routes, Waypoints])
class RouteDao extends DatabaseAccessor<AppDatabase> with _$RouteDaoMixin {
  RouteDao(super.db);

  /// Get all routes, ordered by most recently updated.
  Future<List<DbRoute>> getAllRoutes() {
    return (select(routes)..orderBy([
          (_) => OrderingTerm(
            expression: routes.updatedAt,
            mode: OrderingMode.desc,
          ),
        ]))
        .get();
  }

  /// Get a specific route by ID.
  Future<DbRoute?> getRouteById(int id) {
    return (select(
      routes,
    )..where((_) => routes.id.equals(id))).getSingleOrNull();
  }

  /// Get the currently active route, if any.
  Future<DbRoute?> getActiveRoute() {
    return (select(
      routes,
    )..where((_) => routes.isActive.equals(true))).getSingleOrNull();
  }

  /// Create a new route and return its ID.
  Future<int> createRoute(RoutesCompanion route) {
    return into(routes).insert(route);
  }

  /// Atomically create a new route and its waypoints inside a single transaction.
  Future<int> createRouteWithWaypoints(
    RoutesCompanion route,
    List<WaypointsCompanion> points,
  ) async {
    return transaction(() async {
      final routeId = await into(routes).insert(route);
      if (points.isNotEmpty) {
        final pointCompanionsWithRouteId = points
            .map((p) => p.copyWith(routeId: Value(routeId)))
            .toList();
        await batch((batch) {
          batch.insertAll(waypoints, pointCompanionsWithRouteId);
        });
      }
      return routeId;
    });
  }

  /// Update an existing route.
  Future<bool> updateRoute(RoutesCompanion route) {
    return update(routes).replace(route);
  }

  /// Delete a route (cascades to waypoints).
  Future<int> deleteRoute(int id) {
    return (delete(routes)..where((_) => routes.id.equals(id))).go();
  }

  /// Set a route as active and deactivate others.
  Future<void> setActiveRoute(int routeId) async {
    return transaction(() async {
      // Deactivate all
      await (update(routes)..where((_) => routes.isActive.equals(true))).write(
        const RoutesCompanion(isActive: Value(false)),
      );

      // Activate target
      await (update(routes)..where((_) => routes.id.equals(routeId))).write(
        const RoutesCompanion(isActive: Value(true)),
      );
    });
  }

  /// Add waypoints to a route.
  Future<void> addWaypoints(List<WaypointsCompanion> points) async {
    await batch((batch) {
      batch.insertAll(waypoints, points);
    });
  }

  /// Replace all waypoints for a route (full update).
  Future<void> replaceWaypoints(
    int routeId,
    List<WaypointsCompanion> points,
  ) async {
    return transaction(() async {
      await (delete(
        waypoints,
      )..where((_) => waypoints.routeId.equals(routeId))).go();
      await batch((batch) {
        batch.insertAll(waypoints, points);
      });
    });
  }

  /// Get waypoints for a route, ordered by sequence index.
  Future<List<Waypoint>> getWaypointsForRoute(int routeId) {
    return (select(waypoints)
          ..where((_) => waypoints.routeId.equals(routeId))
          ..orderBy([(_) => OrderingTerm(expression: waypoints.orderIndex)]))
        .get();
  }
}
