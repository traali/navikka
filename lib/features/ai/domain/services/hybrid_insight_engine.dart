import 'package:battery_plus/battery_plus.dart';
import 'package:sakkoja/core/constants/underway_fetch.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ai/domain/entities/navigation_context.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/repositories/skipper_settings_repository.dart';
import 'package:sakkoja/features/ai/domain/services/explanation_prompt_builder.dart';
import 'package:sakkoja/features/ai/domain/services/heuristic_insight_engine.dart';
import 'package:sakkoja/features/ai/domain/services/open_router_service.dart';
import 'package:sakkoja/features/ai/domain/services/weather_ai_edge_service.dart';
import 'package:sakkoja/features/ai/domain/services/weather_auditor.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

class HybridInsightEngine {
  // Preserve the public named argument used by provider composition.
  HybridInsightEngine(
    this._heuristicEngine,
    this._aiService,
    this._auditor,
    this._settingsRepository, {
    Battery? battery,
    this._openRouterService,
  }) : _battery = battery ?? Battery();
  final HeuristicInsightEngine _heuristicEngine;
  final WeatherAIEdgeService _aiService;
  final WeatherAuditor _auditor;
  final SkipperSettingsRepository _settingsRepository;
  final Battery _battery;
  final OpenRouterService? _openRouterService;

  /// Orchestrates the insight generation.
  /// Phase 1: Only uses Heuristic Engine.
  /// Phase 2: Will check isAIEnabled and invoke WeatherAIEdgeService.
  Future<WeatherInsight> getInsight({
    required WeatherData? weather,
    required WaveData? wave,
    required List<WeatherForecast> forecasts,
    required NavigationContext navContext,
    String language = 'en',
  }) async {
    final settingsResult = await _settingsRepository.getSettings();
    final settings = settingsResult.getOrElse((_) => const SkipperSettings());

    // Run Heuristic Logic (always runs as fallback/primary safety)
    final heuristicInsight = _heuristicEngine.analyze(
      weather: weather,
      wave: wave,
      forecasts: forecasts,
      windowHours: settings.forecastWindowHours,
      thresholds: settings.thresholds,
    );

    // 🕵️ Weather Audit: Check for discrepancies between Forecast vs Reality
    // We find the forecast for the current hour (or closest past one)
    final now = DateTime.now();
    final currentForecast = forecasts
        .where(
          (f) => f.timestamp.isBefore(now.add(const Duration(minutes: 30))),
        )
        .lastOrNull;

    final audit = _auditor.audit(
      observation: weather,
      forecast: currentForecast,
      wave: wave,
      thresholds: settings.thresholds,
    );

    // AI Orchestration
    if (settings.isAIEnabled) {
      // 🔋 Battery Safeguard: Don't run AI if battery is < 20%
      int batteryLevel = 100;
      try {
        batteryLevel = await _battery.batteryLevel;
      } catch (e) {
        Log.w('[HybridEngine] Battery check unavailable on platform: $e');
      }
      if (isBatteryTooLowForAi(batteryLevel)) {
        return heuristicInsight.copyWith(
          advice: '${heuristicInsight.advice} (AI Disabled - Low Battery)',
        );
      }

      String aiAdvice;

      // 🌐 Cloud AI: If API key is configured, try OpenRouter first
      if (_openRouterService != null &&
          settings.aiApiKey != null &&
          settings.aiApiKey!.isNotEmpty) {
        try {
          const promptBuilder = ExplanationPromptBuilder();
          final payload = promptBuilder.build(
            insight: heuristicInsight,
            weather: weather,
            wave: wave,
            forecasts: forecasts,
            thresholds: settings.thresholds,
            navContext: navContext,
            language: language,
          );
          final prompt = promptBuilder.buildPrompt(payload);

          final result = await _openRouterService.getExplanation(
            apiKey: settings.aiApiKey!,
            modelId: settings.aiModelId,
            prompt: prompt,
          );

          aiAdvice = result.fold(
            (failure) {
              Log.w('[HybridEngine] OpenRouter failed: ${failure.message}');
              return '';
            },
            (explanation) => explanation,
          );
        } on Exception catch (e) {
          Log.w('[HybridEngine] OpenRouter exception: $e');
          aiAdvice = '';
        }

        // If cloud AI produced advice, use it; otherwise fall back to edge AI
        if (aiAdvice.isNotEmpty) {
          final finalAdvice = audit.status.index > SafetyStatus.green.index
              ? '${audit.message}\n\n$aiAdvice'
              : aiAdvice;

          return heuristicInsight.copyWith(
            status: audit.status.index > heuristicInsight.status.index
                ? audit.status
                : heuristicInsight.status,
            advice: finalAdvice,
            isAIInference: true,
          );
        }
      }

      // 🧠 Edge AI fallback (on-device or existing cloud)
      aiAdvice = await _aiService.getAdvice(
        weather: weather,
        wave: wave,
        forecasts: forecasts,
        status: heuristicInsight.status,
        context: navContext,
      );

      // Mix in the audit warning if critical
      final finalAdvice = audit.status.index > SafetyStatus.green.index
          ? '${audit.message}\n\n$aiAdvice'
          : aiAdvice;

      return heuristicInsight.copyWith(
        status: audit.status.index > heuristicInsight.status.index
            ? audit.status
            : heuristicInsight.status,
        advice: finalAdvice,
        isAIInference: false,
      );

    // Even if AI is disabled, if the audit finds a critical discrepancy, we should warn.
    if (audit.status.index > heuristicInsight.status.index) {
      return heuristicInsight.copyWith(
        status: audit.status,
        advice: '${audit.message}\n\n${heuristicInsight.advice}',
      );
    }

    return heuristicInsight;
  }
}
