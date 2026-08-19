import 'package:drift/drift.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/navigation/data/daos/route_dao.dart';
// import generated code
import 'package:sakkoja/features/navigation/domain/entities/route_entity.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/navigation/domain/repositories/navigation_repository.dart';

class NavigationRepositoryImpl implements NavigationRepository {
  NavigationRepositoryImpl(this._routeDao);
  final RouteDao _routeDao;

  @override
  Future<List<RouteEntity>> getAllRoutes() async {
    final dtos = await _routeDao.getAllRoutes();
    return dtos.map<RouteEntity>(_mapRouteToEntity).toList();
  }

  @override
  Future<RouteEntity?> getRouteById(int id) async {
    final dto = await _routeDao.getRouteById(id);
    return dto == null ? null : _mapRouteToEntity(dto);
  }

  @override
  Future<RouteEntity?> getActiveRoute() async {
    final dto = await _routeDao.getActiveRoute();
    return dto == null ? null : _mapRouteToEntity(dto);
  }

  @override
  Future<int> createRoute(String name, List<WaypointEntity> waypoints) async {
    final routeCompanion = RoutesCompanion(
      name: Value(name),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );

    final waypointCompanions = waypoints
        .map(
          (wp) => WaypointsCompanion(
            lat: Value(wp.lat),
            lon: Value(wp.lon),
            orderIndex: Value(wp.orderIndex),
            label: Value(wp.label),
          ),
        )
        .toList();

    return _routeDao.createRouteWithWaypoints(
      routeCompanion,
      waypointCompanions,
    );
  }

  @override
  Future<void> updateRoute(RouteEntity route) async {
    await _routeDao.updateRoute(
      RoutesCompanion(
        id: Value(route.id),
        name: Value(route.name),
        updatedAt: Value(DateTime.now()),
        isActive: Value(route.isActive),
        totalDistanceMeters: Value(route.totalDistanceMeters),
      ),
    );
  }

  @override
  Future<void> deleteRoute(int id) {
    return _routeDao.deleteRoute(id);
  }

  @override
  Future<void> setActiveRoute(int id) {
    return _routeDao.setActiveRoute(id);
  }

  @override
  Future<List<WaypointEntity>> getWaypointsForRoute(int routeId) async {
    final dtos = await _routeDao.getWaypointsForRoute(routeId);
    return dtos.map<WaypointEntity>(_mapWaypointToEntity).toList();
  }

  // Mappers
  RouteEntity _mapRouteToEntity(DbRoute dto) {
    return RouteEntity(
      id: dto.id,
      name: dto.name,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      isActive: dto.isActive,
      totalDistanceMeters: dto.totalDistanceMeters,
    );
  }

  WaypointEntity _mapWaypointToEntity(Waypoint dto) {
    return WaypointEntity(
      id: dto.id,
      routeId: dto.routeId,
      lat: dto.lat,
      lon: dto.lon,
      orderIndex: dto.orderIndex,
      label: dto.label,
    );
  }
}
