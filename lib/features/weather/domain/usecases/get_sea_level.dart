import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/weather/di/weather_di.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'get_sea_level.g.dart';

@riverpod
GetSeaLevel getSeaLevel(Ref ref) {
  return GetSeaLevel(ref.watch(weatherRepositoryProvider));
}

class GetSeaLevel {
  GetSeaLevel(this._repository);
  final WeatherRepository _repository;

  Future<Either<Failure, List<SeaLevel>>> call() {
    return _repository.getSeaLevel();
  }
}
