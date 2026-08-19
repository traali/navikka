import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/weather/di/weather_di.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'get_recent_lightning.g.dart';

@riverpod
GetRecentLightning getRecentLightning(Ref ref) {
  return GetRecentLightning(ref.watch(weatherRepositoryProvider));
}

class GetRecentLightning {
  GetRecentLightning(this._repository);
  final WeatherRepository _repository;

  Future<Either<Failure, List<LightningStrike>>> call({
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    return _repository.getRecentLightning(
      startTime: startTime,
      endTime: endTime,
    );
  }
}
