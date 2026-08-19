import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/weather/di/weather_di.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'get_wave_observations.g.dart';

@riverpod
GetWaveObservations getWaveObservations(Ref ref) {
  return GetWaveObservations(ref.watch(weatherRepositoryProvider));
}

class GetWaveObservations {
  GetWaveObservations(this._repository);
  final WeatherRepository _repository;

  Future<Either<Failure, List<WaveData>>> call() {
    return _repository.getWaveObservations();
  }
}
