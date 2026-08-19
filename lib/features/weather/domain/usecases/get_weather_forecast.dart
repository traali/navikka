import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/weather/di/weather_di.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'get_weather_forecast.g.dart';

@riverpod
GetWeatherForecast getWeatherForecast(Ref ref) {
  return GetWeatherForecast(ref.watch(weatherRepositoryProvider));
}

class GetWeatherForecast {
  GetWeatherForecast(this._repository);
  final WeatherRepository _repository;

  Future<Either<Failure, List<WeatherForecast>>> call({
    required double lat,
    required double lon,
  }) {
    return _repository.getWeatherForecast(lat: lat, lon: lon);
  }
}
