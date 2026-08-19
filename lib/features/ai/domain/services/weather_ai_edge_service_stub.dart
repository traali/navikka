import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ai/domain/entities/navigation_context.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

/// Web stub for WeatherAIEdgeService.
/// On web, the Gemma AI model is not available, so we return placeholder responses.
class WeatherAIEdgeService {
  // ignore: avoid_unused_constructor_parameters
  WeatherAIEdgeService({required Future<String?> Function() getModelPath});

  Future<void> init() async {
    Log.i('AIEdgeService: Web platform - AI features not available');
  }

  /// Generates a human-readable explanation for the current weather.
  /// On web, returns a placeholder message.
  Future<String> getAdvice({
    required WeatherData? weather,
    required WaveData? wave,
    required List<WeatherForecast> forecasts,
    required SafetyStatus status,
    required NavigationContext context,
  }) async {
    return 'AI weather analysis is not available on web. '
        'For full Virtual Skipper features, use the mobile app. '
        'Current status: ${status.name.toUpperCase()}.';
  }
}
