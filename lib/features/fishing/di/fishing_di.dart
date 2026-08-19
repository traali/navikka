/// Fishing Feature Dependency Injection Module
///
/// All Riverpod providers for the fishing feature data layer.
/// Domain usecases should import from here.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/fishing/data/datasources/fishing_local_data_source.dart';
import 'package:sakkoja/features/fishing/data/datasources/fishing_remote_data_source.dart';
import 'package:sakkoja/features/fishing/data/repositories/drift_catch_repository.dart';
import 'package:sakkoja/features/fishing/data/repositories/fishing_repository_impl.dart';
import 'package:sakkoja/features/fishing/domain/repositories/catch_repository.dart';
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';

part 'fishing_di.g.dart';

// --- Data Sources ---

@Riverpod(keepAlive: true)
FishingRemoteDataSource fishingRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FishingRemoteDataSourceImpl(dio);
}

@Riverpod(keepAlive: true)
FishingLocalDataSource fishingLocalDataSource(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return FishingLocalDataSourceImpl(db);
}

// --- Repositories ---

@Riverpod(keepAlive: true)
FishingRepository fishingRepository(Ref ref) {
  return FishingRepositoryImpl(
    ref.watch(fishingRemoteDataSourceProvider),
    ref.watch(fishingLocalDataSourceProvider),
  );
}

@Riverpod(keepAlive: true)
CatchRepository catchRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftCatchRepository(db);
}
