import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/weather/di/weather_di.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'get_weather_observations.g.dart';

@riverpod
GetWeatherObservations getWeatherObservations(Ref ref) {
  return GetWeatherObservations(ref.watch(weatherRepositoryProvider));
}

class GetWeatherObservations {
  GetWeatherObservations(this._repository);
  final WeatherRepository _repository;

  Future<Either<Failure, List<WeatherData>>> call({
    required double lat,
    required double lon,
  }) {
    return _repository.getWeatherObservations(lat: lat, lon: lon);
  }
}
