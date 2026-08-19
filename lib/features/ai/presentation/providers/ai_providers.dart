import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// Import implementation to access the repository provider
import 'package:sakkoja/features/ai/data/repositories/skipper_settings_repository_impl.dart';
import 'package:sakkoja/features/ai/data/services/model_download_service.dart';
import 'package:sakkoja/features/ai/domain/entities/navigation_context.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/services/heuristic_insight_engine.dart';
import 'package:sakkoja/features/ai/domain/services/hybrid_insight_engine.dart';
import 'package:sakkoja/features/ai/domain/services/open_router_service_impl.dart';
import 'package:sakkoja/features/ai/domain/services/weather_ai_edge_service.dart';
import 'package:sakkoja/features/ai/domain/services/weather_auditor.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/vessel/presentation/controllers/vessel_controller.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

part 'ai_providers.g.dart';

@riverpod
WeatherAIEdgeService weatherAIEdgeService(Ref ref) {
  final downloadService = ref.watch(modelDownloadServiceProvider.notifier);
  return WeatherAIEdgeService(
    getModelPath: downloadService.getModelPathIfReady,
  );
}

@riverpod
WeatherAuditor weatherAuditor(Ref ref) {
  return const WeatherAuditor();
}

@riverpod
HybridInsightEngine hybridInsightEngine(Ref ref) {
  return HybridInsightEngine(
    const HeuristicInsightEngine(),
    ref.watch(weatherAIEdgeServiceProvider),
    ref.watch(weatherAuditorProvider),
    ref.watch(skipperSettingsRepositoryProvider),
    battery: Battery(),
    openRouterService: ref.watch(openRouterServiceProvider),
  );
}

@riverpod
Stream<SkipperSettings> skipperSettings(Ref ref) {
  return ref.watch(skipperSettingsRepositoryProvider).watchSettings();
}

@riverpod
Future<WeatherInsight> skipperInsight(Ref ref) async {
  // 1. Watch the map's weather state
  final weatherState = ref.watch(pointWeatherControllerProvider);

  // 2. Watch Navigation Context (Vessel + Route)
  final vesselProfile = ref.watch(vesselSettingsControllerProvider).value;
  final activeRoute = ref.watch(activeRouteProvider).value;
  final plannedRoute = ref.watch(routePlannerControllerProvider);

  // 3. Obtain the hybrid engine
  final engine = ref.watch(hybridInsightEngineProvider);

  // OPTIMIZATION: Throttle AI inference.
  // We only re-run if weather changed significantly or 5 mins passed.
  // For now, we perform a simple delay to prevent blast-updates.
  await Future<void>.delayed(const Duration(seconds: 2));

  final navContext = NavigationContext(
    vesselType: vesselProfile?.type ?? VesselType.openBoat,
    draftDepth: vesselProfile?.draftDepth,
    hasActiveRoute: activeRoute != null || plannedRoute.waypoints.isNotEmpty,
    activeRouteName:
        activeRoute?.name ??
        (plannedRoute.waypoints.isNotEmpty ? 'Planned Route' : null),
    routePoints: plannedRoute.waypoints
        .map((w) => LatLng(w.lat, w.lon))
        .toList(),
    detectedHazards: plannedRoute.conflicts.map((c) => c.category).toList(),
  );

  // 4. Generate insight based on current weather/waves + context
  final locale = WidgetsBinding.instance.platformDispatcher.locale;
  return engine.getInsight(
    weather: weatherState.weather,
    wave: weatherState.wave,
    forecasts: weatherState.forecast,
    navContext: navContext,
    language: locale.languageCode,
  );
}

@riverpod
class SkipperSettingsController extends _$SkipperSettingsController {
  @override
  FutureOr<SkipperSettings> build() async {
    final repository = ref.watch(skipperSettingsRepositoryProvider);
    final result = await repository.getSettings();
    return result.getOrElse((failure) => throw Exception(failure.toString()));
  }

  Future<void> updateSettings(SkipperSettings settings) async {
    state = const AsyncValue.loading();
    final repository = ref.read(skipperSettingsRepositoryProvider);
    final result = await repository.updateSettings(settings);

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = AsyncValue.data(settings),
    );
  }

  Future<void> resetToDefaults() async {
    state = const AsyncValue.loading();
    final repository = ref.read(skipperSettingsRepositoryProvider);
    final result = await repository.resetToDefaults();

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) async {
        final fresh = await repository.getSettings();
        state = fresh.fold(
          (f) => AsyncValue.error(f, StackTrace.current),
          AsyncValue.data,
        );
      },
    );
  }
}

/// Tracks which insight the user has last acknowledged/dismissed.
/// In-memory only for now; when app restarts, user will see alerts again.
@riverpod
class SkipperInsightAcknowledgment extends _$SkipperInsightAcknowledgment {
  @override
  String? build() => null;

  void acknowledge(String insightId) {
    state = insightId;
  }
}

/// Keeps a rolling history of the last 20 insights for review.
/// In-memory only; history is lost on app restart.
@riverpod
class InsightHistory extends _$InsightHistory {
  static const int _maxHistory = 20;

  @override
  List<WeatherInsight> build() {
    // Watch new insights and append them to history
    ref.listen(skipperInsightProvider, (prev, next) {
      if (next.hasValue) {
        _addInsight(next.value!);
      }
    });
    return [];
  }

  void _addInsight(WeatherInsight insight) {
    // Avoid duplicates (same insightId within 1 minute)
    if (state.isNotEmpty) {
      final last = state.first;
      if (last.insightId == insight.insightId) return;
    }
    state = [insight, ...state].take(_maxHistory).toList();
  }
}
