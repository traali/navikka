import 'package:sakkoja/features/navigation/domain/entities/route_entity.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';

abstract class NavigationRepository {
  Future<List<RouteEntity>> getAllRoutes();
  Future<RouteEntity?> getRouteById(int id);
  Future<RouteEntity?> getActiveRoute();

  Future<int> createRoute(String name, List<WaypointEntity> waypoints);
  Future<void> updateRoute(RouteEntity route);
  Future<void> deleteRoute(int id);

  Future<void> setActiveRoute(int id);

  Future<List<WaypointEntity>> getWaypointsForRoute(int routeId);
}
