import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart';
import 'package:sakkoja/features/fishing/domain/entities/catch_size.dart';
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';

part 'get_catch_sizes.g.dart';

@riverpod
GetCatchSizes getCatchSizes(Ref ref) {
  return GetCatchSizes(ref.watch(fishingRepositoryProvider));
}

class GetCatchSizes {
  GetCatchSizes(this._repository);
  final FishingRepository _repository;

  Future<Either<Failure, List<CatchSize>>> execute({
    required double lat,
    required double lon,
  }) async {
    return _repository.getCatchSizes(lat: lat, lon: lon);
  }
}
