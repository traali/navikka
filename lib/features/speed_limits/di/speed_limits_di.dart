import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/speed_limits/data/datasources/speed_limit_local_data_source.dart';
import 'package:sakkoja/features/speed_limits/data/datasources/speed_limit_remote_data_source.dart';
import 'package:sakkoja/features/speed_limits/data/repositories/speed_limit_repository_impl.dart';
import 'package:sakkoja/features/speed_limits/domain/repositories/speed_limit_repository.dart';
import 'package:sakkoja/features/speed_limits/domain/usecases/get_speed_limits_with_bbox.dart';

part 'speed_limits_di.g.dart';

@Riverpod(keepAlive: true)
SpeedLimitRemoteDataSource speedLimitRemoteDataSource(Ref ref) {
  return SpeedLimitRemoteDataSourceImpl(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
SpeedLimitLocalDataSource speedLimitLocalDataSource(Ref ref) {
  return SpeedLimitLocalDataSourceImpl(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
SpeedLimitRepository speedLimitRepository(Ref ref) {
  return SpeedLimitRepositoryImpl(
    ref.watch(speedLimitRemoteDataSourceProvider),
    ref.watch(speedLimitLocalDataSourceProvider),
  );
}

@Riverpod(keepAlive: true)
GetSpeedLimitsWithBBox getSpeedLimitsWithBBoxUseCase(Ref ref) {
  return GetSpeedLimitsWithBBox(ref.watch(speedLimitRepositoryProvider));
}
