import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/navigation_aids/data/datasources/navigation_aids_local_data_source.dart';
import 'package:sakkoja/features/navigation_aids/data/datasources/navigation_aids_remote_data_source.dart';
import 'package:sakkoja/features/navigation_aids/data/repositories/navigation_aids_repository_impl.dart';
import 'package:sakkoja/features/navigation_aids/domain/repositories/navigation_aids_repository.dart';

part 'navigation_aids_di.g.dart';

@Riverpod(keepAlive: true)
NavigationAidsRemoteDataSource navigationAidsRemoteDataSource(Ref ref) {
  return NavigationAidsRemoteDataSourceImpl(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
NavigationAidsLocalDataSource navigationAidsLocalDataSource(Ref ref) {
  return NavigationAidsLocalDataSourceImpl(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
NavigationAidsRepository navigationAidsRepository(Ref ref) {
  return NavigationAidsRepositoryImpl(
    ref.watch(navigationAidsLocalDataSourceProvider),
    ref.watch(navigationAidsRemoteDataSourceProvider),
  );
}
