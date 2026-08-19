import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/presentation/widgets/glass_container.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/animated_wind_arrow.dart';

@immutable
class WeatherHudData {
  const WeatherHudData({
    required this.isLoading,
    required this.syncError,
    required this.weather,
    required this.wave,
    required this.seaLevel,
    required this.waterQuality,
    required this.lightningLevel,
    required this.isStale,
    required this.alertCount,
  });

  final bool isLoading;
  final String? syncError;
  final WeatherData? weather;
  final WaveData? wave;
  final SeaLevel? seaLevel;
  final WaterQualityData? waterQuality;
  final LightningAlarmLevel lightningLevel;
  final bool isStale;
  final int alertCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherHudData &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          syncError == other.syncError &&
          weather == other.weather &&
          wave == other.wave &&
          seaLevel == other.seaLevel &&
          waterQuality == other.waterQuality &&
          lightningLevel == other.lightningLevel &&
          isStale == other.isStale &&
          alertCount == other.alertCount;

  @override
  int get hashCode => Object.hash(
    isLoading,
    syncError,
    weather,
    wave,
    seaLevel,
    waterQuality,
    lightningLevel,
    isStale,
    alertCount,
  );
}

class WeatherHudV2 extends ConsumerWidget {
  const WeatherHudV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hudData = ref.watch(
      pointWeatherControllerProvider.select(
        (s) => WeatherHudData(
          isLoading: s.isLoading,
          syncError: s.syncError,
          weather: s.weather,
          wave: s.wave,
          seaLevel: s.seaLevel,
          waterQuality: s.waterQuality,
          lightningLevel: s.lightningAlarmLevel,
          isStale: s.isStale,
          alertCount: s.activeAlerts.length,
        ),
      ),
    );
    final layout = ref.watch(uiLayoutControllerProvider);

    final hasAnyData =
        hudData.weather != null ||
        hudData.wave != null ||
        hudData.seaLevel != null;

    if (hudData.isLoading && !hasAnyData) {
      if (layout == UiLayout.ghost) {
        return const SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(strokeWidth: 1.5),
        );
      }
      return GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(AppPalette.primaryAction),
          ),
        ),
      );
    }

    if (hudData.syncError != null && hudData.weather == null) {
      return _buildErrorState(hudData.syncError!);
    }

    if (!hasAnyData) return _buildEmptyState();

    switch (layout) {
      case UiLayout.ghost:
      case UiLayout.vortex:
      case UiLayout.horizon3D:
        return Semantics(
          button: true,
          label: 'Avaa säätiedot',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.go('/weather'),
              borderRadius: BorderRadius.circular(20),
              child: _AiGlowOverlay(
                child: _GhostWeatherRibbon(hudData: hudData),
              ),
            ),
          ),
        );
      case UiLayout.classic:
      case UiLayout.commandBar:
      case UiLayout.omni:
        return _ClassicWeatherHud(hudData: hudData);
    }
  }

  Widget _buildErrorState(String error) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_off,
            color: AppPalette.warning,
            size: 16,
          ),
          const SizedBox(width: 8),
          Tooltip(
            message: error,
            child: Text(
              'Sää ei saatavilla',
              style: AppTheme.kCaption.copyWith(color: AppPalette.warning),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_queue,
            color: AppPalette.textSecondary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            'Odota säätietoja...',
            style: AppTheme.kCaption.copyWith(color: AppPalette.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _GhostWeatherRibbon extends StatelessWidget {
  const _GhostWeatherRibbon({required this.hudData});
  final WeatherHudData hudData;

  @override
  Widget build(BuildContext context) {
    final windSpeed = hudData.weather?.windSpeed?.toStringAsFixed(1) ?? '--';
    final windDir = hudData.weather?.windDirection ?? 0.0;
    final airTemp = hudData.weather?.temperature?.toStringAsFixed(1) ?? '--';
    final waterTemp = hudData.waterQuality?.temperature?.toStringAsFixed(1);
    final waveHeight = hudData.wave?.waveHeight?.toStringAsFixed(1);
    final seaLevel = hudData.seaLevel?.seaLevel;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Air Temp
        const Icon(Icons.thermostat, size: 12, color: AppPalette.primaryAction),
        const SizedBox(width: 4),
        Text(
          '$airTemp°C',
          style: const TextStyle(
            color: AppPalette.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        _Divider(),

        // Wind
        AnimatedWindArrow(
          directionDegrees: windDir,
          size: 12,
          color: AppPalette.primaryAction,
        ),
        const SizedBox(width: 4),
        Text(
          '$windSpeed m/s',
          style: const TextStyle(
            color: AppPalette.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),

        if (waveHeight != null) ...[
          _Divider(),
          const Icon(Icons.waves, size: 12, color: AppPalette.primaryAction),
          const SizedBox(width: 4),
          Text(
            '$waveHeight m',
            style: const TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],

        if (seaLevel != null) ...[
          _Divider(),
          const Icon(Icons.water, size: 12, color: AppPalette.primaryAction),
          const SizedBox(width: 4),
          Text(
            '${(seaLevel / 10).round()} cm',
            style: const TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],

        if (waterTemp != null) ...[
          _Divider(),
          const Icon(
            Icons.water_drop,
            size: 12,
            color: AppPalette.primaryAction,
          ),
          const SizedBox(width: 4),
          Text(
            '$waterTemp°C',
            style: const TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],

        if (hudData.lightningLevel != LightningAlarmLevel.none) ...[
          _Divider(),
          Icon(
            Icons.bolt,
            size: 14,
            color: hudData.lightningLevel == LightningAlarmLevel.danger
                ? AppPalette.danger
                : AppPalette.warning,
          ),
        ],
      ],
    );
  }
}

/// Separate ConsumerWidget so only the glow overlay rebuilds on AI insight changes,
/// not the entire weather ribbon underneath.
class _AiGlowOverlay extends ConsumerWidget {
  final Widget child;
  const _AiGlowOverlay({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightState = ref.watch(skipperInsightProvider);

    Color? glowColor;
    if (insightState.hasValue && insightState.value != null) {
      final status = insightState.value!.status;
      if (status == SafetyStatus.yellow || status == SafetyStatus.orange) {
        glowColor = AppPalette.warning.withValues(alpha: 0.4);
      } else if (status == SafetyStatus.red) {
        glowColor = AppPalette.danger.withValues(alpha: 0.4);
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: glowColor ?? AppPalette.navikkaSurface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color:
              glowColor?.withValues(alpha: 0.8) ??
              AppPalette.navikkaCyanGlow.withValues(alpha: 0.4),
          width: glowColor != null ? 1.5 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color:
                glowColor?.withValues(alpha: 0.3) ??
                AppPalette.navikkaCyanGlow.withValues(alpha: 0.15),
            blurRadius: 14,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 1,
      color: AppPalette.textSecondary.withValues(alpha: 0.4),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

class _ClassicWeatherHud extends ConsumerWidget {
  const _ClassicWeatherHud({required this.hudData});
  final WeatherHudData hudData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightState = ref.watch(skipperInsightProvider);

    final hasWeather =
        hudData.weather?.temperature != null ||
        hudData.weather?.windSpeed != null;
    final hasWave = hudData.wave?.waveHeight != null;
    final hasSeaLevel = hudData.seaLevel?.seaLevel != null;

    final isStale = hudData.isStale;

    Color? glowColor;
    if (insightState.hasValue && insightState.value != null) {
      final status = insightState.value!.status;
      if (status == SafetyStatus.yellow) {
        glowColor = AppPalette.warning.withValues(alpha: 0.3);
      }
      if (status == SafetyStatus.orange) {
        glowColor = AppPalette.warning.withValues(alpha: 0.3);
      }
      if (status == SafetyStatus.red) {
        glowColor = AppPalette.danger.withValues(alpha: 0.3);
      }
    }

    if (isStale) {
      glowColor = AppPalette.textSecondary.withValues(alpha: 0.3);
    }

    final borderColor = isStale
        ? AppPalette.warning.withValues(alpha: 0.5)
        : glowColor?.withValues(alpha: 0.6);

    final windSpeed = hudData.weather?.windSpeed?.toStringAsFixed(1) ?? '--';
    final windDir = hudData.weather?.windDirection ?? 0.0;
    final temperature =
        hudData.weather?.temperature?.toStringAsFixed(1) ?? '--';
    final waveHeight = hudData.wave?.waveHeight?.toStringAsFixed(1) ?? '--';
    final seaLevel = hudData.seaLevel?.seaLevel;

    return RepaintBoundary(
      child: Semantics(
        button: true,
        label: 'Avaa säätiedot',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              SafeHaptics.light();
              context.go('/weather');
            },
            borderRadius: BorderRadius.circular(24),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(24),
              borderColor: borderColor,
              color: glowColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasWeather) ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.thermostat,
                          size: 16,
                          color: AppPalette.primaryAction,
                        ),
                        const SizedBox(height: 4),
                        _AnimatedValue(
                          value: '$temperature°C',
                          style: AppTheme.kData.copyWith(
                            fontSize: 12,
                            color: AppPalette.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    _VerticalDivider(),
                  ],
                  if (hasWeather) ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedWindArrow(
                          directionDegrees: windDir,
                          size: 16,
                          color: AppPalette.primaryAction,
                        ),
                        const SizedBox(height: 4),
                        _AnimatedValue(
                          value: '$windSpeed m/s',
                          style: AppTheme.kData.copyWith(
                            fontSize: 12,
                            color: AppPalette.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (hasWeather && (hasWave || hasSeaLevel))
                    _VerticalDivider(),
                  if (hasWave) ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.waves,
                          size: 16,
                          color: AppPalette.primaryAction,
                        ),
                        const SizedBox(height: 4),
                        _AnimatedValue(
                          value: '$waveHeight m',
                          style: AppTheme.kData.copyWith(
                            fontSize: 12,
                            color: AppPalette.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (hasSeaLevel) ...[
                    if (hasWave) _VerticalDivider(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.water,
                          size: 16,
                          color: AppPalette.primaryAction,
                        ),
                        const SizedBox(height: 4),
                        _AnimatedValue(
                          value: '${(seaLevel! / 10).round()} cm',
                          style: AppTheme.kData.copyWith(
                            fontSize: 12,
                            color: AppPalette.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      color: AppPalette.glassBorder(),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class _AnimatedValue extends StatelessWidget {
  const _AnimatedValue({required this.value, required this.style});
  final String value;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Text(value, key: ValueKey<String>(value), style: style),
    );
  }
}
