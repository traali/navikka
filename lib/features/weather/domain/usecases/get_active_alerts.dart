import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/weather/di/weather_di.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'get_active_alerts.g.dart';

@riverpod
GetActiveAlerts getActiveAlerts(Ref ref) {
  return GetActiveAlerts(ref.watch(weatherRepositoryProvider));
}

class GetActiveAlerts {
  GetActiveAlerts(this._repository);
  final WeatherRepository _repository;

  Future<Either<Failure, List<WeatherAlert>>> call() async {
    return _repository.getActiveAlerts();
  }
}
