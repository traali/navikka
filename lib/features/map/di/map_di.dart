import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/data/datasources/map_local_data_source.dart';
import 'package:sakkoja/features/map/data/repositories/map_repository_impl.dart';
import 'package:sakkoja/features/map/data/services/zone_spatial_service.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';

part 'map_di.g.dart';

@Riverpod(keepAlive: true)
MapLocalDataSource mapLocalDataSource(Ref ref) {
  return MapLocalDataSourceImpl();
}

@Riverpod(keepAlive: true)
MapRepository mapRepository(Ref ref) {
  return MapRepositoryImpl(ref.watch(mapLocalDataSourceProvider));
}

@Riverpod(keepAlive: true)
ZoneSpatialService zoneSpatialService(Ref ref) {
  return ZoneSpatialService();
}
