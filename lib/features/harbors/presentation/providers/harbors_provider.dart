import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/harbors/data/datasources/lipas_remote_data_source.dart';
import 'package:sakkoja/features/harbors/data/repositories/harbor_repository_impl.dart';
import 'package:sakkoja/features/harbors/domain/entities/harbor.dart';
import 'package:sakkoja/features/harbors/domain/repositories/harbor_repository.dart';

part 'harbors_provider.g.dart';

@riverpod
HarborRepository harborRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  final remoteSource = LipasRemoteDataSourceImpl(dio: dio);
  return HarborRepositoryImpl(remoteDataSource: remoteSource);
}

@riverpod
class HarborsNotifier extends _$HarborsNotifier {
  @override
  Future<List<Harbor>> build() async {
    ref.keepAlive();
    final repository = ref.read(harborRepositoryProvider);
    final result = await repository.getHarbors();
    return result.fold(
      (failure) => [],
      (harbors) => harbors,
    );
  }
}
