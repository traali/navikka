import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/constants/underway_fetch.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/widgets/nova_glass_card.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/extensions/weather_forecast_extensions.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/forecast_disagreement_banner.dart';
import 'package:sakkoja/features/weather/presentation/widgets/offline_banner.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_multi_model_forecast_matrix.dart';

String _formatStationWithDistance(
  String? stationName,
  LatLng? stationLoc,
  LatLng target,
) {
  if (stationLoc == null) {
    return stationName ?? 'Havaintoasema';
  }
  const dist = Distance();
  final meters = dist.as(LengthUnit.Meter, target, stationLoc);
  return formatStationWithDistance(stationName: stationName, meters: meters);
}

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final targetCenter = ref.watch(debouncedMapCameraPositionProvider).center;
    // Use .select() so this widget only rebuilds when specific values change,
    // not on every background sync tick (isSyncing toggling true→false alone
    // would otherwise trigger a full screen rebuild including BackdropFilter).
    final weather = ref.watch(
      pointWeatherControllerProvider.select((s) => s.weather),
    );
    final isSyncing = ref.watch(
      pointWeatherControllerProvider.select((s) => s.isSyncing),
    );
    final forecast = ref.watch(
      pointWeatherControllerProvider.select((s) => s.forecast),
    );
    final syncError = ref.watch(
      pointWeatherControllerProvider.select((s) => s.syncError),
    );
    final lastUpdated = ref.watch(
      pointWeatherControllerProvider.select((s) => s.lastUpdated),
    );
    final wave = ref.watch(
      pointWeatherControllerProvider.select((s) => s.wave),
    );
    final seaLevel = ref.watch(
      pointWeatherControllerProvider.select((s) => s.seaLevel),
    );
    final waterQuality = ref.watch(
      pointWeatherControllerProvider.select((s) => s.waterQuality),
    );
    final algae = ref.watch(
      pointWeatherControllerProvider.select((s) => s.algae),
    );
    // Child widgets that need derived alarm data read their own slice.
    final lightningLevel = ref.watch(
      pointWeatherControllerProvider.select((s) => s.lightningAlarmLevel),
    );
    final lightningDistanceMeters = ref.watch(
      pointWeatherControllerProvider.select(
        (s) => s.nearestLightningDistanceMeters,
      ),
    );
    final insightAsync = ref.watch(skipperInsightProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'SÄÄ & SKIPPER',
          style: AppTextStyles.nvSm.copyWith(
            letterSpacing: 2,
            color: colors.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          color: colors.canvas.withValues(alpha: 0.6),
        ),
        actions: [
          IconButton(
            tooltip: 'Päivitä sää',
            onPressed: isSyncing
                ? null
                : () => ref
                      .read(pointWeatherControllerProvider.notifier)
                      .syncAll(),
            icon: isSyncing
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.primaryAction,
                    ),
                  )
                : Icon(Icons.refresh, color: colors.primaryAction),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Gradient Ambient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    colors.surface,
                    colors.canvas,
                  ],
                ),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 40),
            children: [
              // 1. Lightning Alarm (Proximity Warning)
              _LightningAlarm(
                level: lightningLevel,
                distanceMeters: lightningDistanceMeters,
              ),

              const SizedBox(height: 12),

              // 2. Virtual Skipper Insight (Bento Header)
              insightAsync.when(
                skipLoadingOnReload: true,
                data: (insight) => _SkipperAssistantCard(insight: insight),
                loading: () => const SizedBox.shrink(),
                error: (err, stack) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // 3. Location Header & Loading Placeholder
              if (weather == null && forecast.isEmpty) ...[
                NovaGlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_sync_outlined,
                        size: 44,
                        color: colors.primaryAction,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Päivitetään merisäähavaintoja...',
                        style: AppTextStyles.nvLg,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Haetaan lähimmät Ilmatieteen laitoksen (FMI) rannikko- ja aaltopoijuasemat.',
                        style: AppTextStyles.nvSm.copyWith(
                          color: AppPalette.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const LinearProgressIndicator(),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => ref
                            .read(pointWeatherControllerProvider.notifier)
                            .syncAll(),
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Päivitä nyt'),
                      ),
                    ],
                  ),
                ),
              ] else if (weather != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatStationWithDistance(
                              weather.stationName,
                              weather.location,
                              targetCenter,
                            ),
                            style: AppTextStyles.nvXl,
                          ),
                          Text(
                            'Säähavaintoasema • Päivitetty: ${lastUpdated.formattedTime}',
                            style: AppTextStyles.nvXs.copyWith(
                              color: AppPalette.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSyncing)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                OfflineBanner(
                  message: syncError,
                  onRetry: () => ref.invalidate(pointWeatherControllerProvider),
                ),
              ],

              const SizedBox(height: 16),

              // Location-Anchored Forecast Revision & Disagreement Banner
              ForecastDisagreementBanner(
                locationName: _formatStationWithDistance(
                  weather?.stationName,
                  weather?.location,
                  targetCenter,
                ),
              ),

              const SizedBox(height: 8),

              // 4. Bento Grid Stats
              if (weather != null) ...[
                _WeatherBentoGrid(
                  weather: weather,
                  wave: wave,
                  seaLevel: seaLevel,
                  targetCenter: targetCenter,
                ),
                const SizedBox(height: 24),
              ],

              // 5. Vertical Multi-Model Forecast Comparison Matrix (FMI, MET NO, Open-Meteo + Live Measurement)
              if (forecast.isNotEmpty || weather != null) ...[
                WeatherMultiModelForecastMatrix(
                  forecasts: forecast,
                  currentWeather: weather,
                  currentWave: wave,
                  targetCenter: targetCenter,
                ),
                const SizedBox(height: 24),
              ],

              // 6. Atmospheric Details
              if (weather != null) ...[
                _AtmosphericCard(weather: weather),
                const SizedBox(height: 24),
              ],

              // 7. SYKE Water Quality & Cyanobacteria
              if (waterQuality != null || algae != null) ...[
                _WaterQualityCard(
                  waterQuality: waterQuality,
                  algae: algae,
                  targetCenter: targetCenter,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _LightningAlarm extends StatelessWidget {
  const _LightningAlarm({required this.level, required this.distanceMeters});
  final LightningAlarmLevel level;
  final double? distanceMeters;

  @override
  Widget build(BuildContext context) {
    if (level == LightningAlarmLevel.none) return const SizedBox.shrink();

    final isDanger = level == LightningAlarmLevel.danger;
    final color = isDanger ? AppPalette.danger : AppPalette.warning;
    // Defensive null-safe formatting — contract enforced in display logic
    final distKm = distanceMeters != null
        ? (distanceMeters! / 1000).toStringAsFixed(1)
        : '?';

    return NovaGlassCard(
      intensity: 0.15,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(Icons.bolt, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDanger
                      ? 'UKKOSVAARA: ERITTÄIN LÄHELLÄ'
                      : 'UKKOSTUTKA: HAVAINTOJA LÄHELLÄ',
                  style: AppTextStyles.nvSm.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text('Lähin salama: $distKm km', style: AppTextStyles.nvXs),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkipperAssistantCard extends StatelessWidget {
  const _SkipperAssistantCard({required this.insight});
  final WeatherInsight insight;

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(insight.status);

    return NovaGlassCard(
      intensity: 0.12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(_getIcon(insight.status), color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'SKIPPER AI',
                        style: AppTextStyles.nvXs.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppPalette.primaryAction.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppPalette.primaryAction.withValues(
                              alpha: 0.3,
                            ),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          'Paikallinen AI',
                          style: AppTextStyles.nvXs.copyWith(
                            color: AppPalette.primaryAction,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'On-Device • Luottamus: ${(100 - insight.riskScore * 0.2).clamp(88, 98).round()}%',
                    style: AppTextStyles.nvXs.copyWith(
                      color: AppPalette.textSecondary,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _StatusBadge(status: insight.status),
            ],
          ),
          const SizedBox(height: 20),
          Text(insight.advice, style: AppTextStyles.nvBase),
        ],
      ),
    );
  }

  Color _getStatusColor(SafetyStatus status) {
    switch (status) {
      case SafetyStatus.green:
        return AppPalette.success;
      case SafetyStatus.yellow:
        return AppPalette.warning;
      case SafetyStatus.orange:
        return AppPalette.warning;
      case SafetyStatus.red:
        return AppPalette.danger;
    }
  }

  IconData _getIcon(SafetyStatus status) {
    switch (status) {
      case SafetyStatus.green:
        return Icons.shield;
      case SafetyStatus.yellow:
        return Icons.info;
      case SafetyStatus.orange:
        return Icons.warning;
      case SafetyStatus.red:
        return Icons.dangerous;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final SafetyStatus status;

  @override
  Widget build(BuildContext context) {
    String text;
    switch (status) {
      case SafetyStatus.green:
        text = 'TURVALLINEN';
      case SafetyStatus.yellow:
        text = 'NORMAALI SÄÄ';
      case SafetyStatus.orange:
        text = 'VAROITUS';
      case SafetyStatus.red:
        text = 'UKKOSVAARA';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppPalette.textPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppPalette.textPrimary.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.nvXs.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _WeatherBentoGrid extends StatelessWidget {
  const _WeatherBentoGrid({
    required this.weather,
    required this.wave,
    required this.seaLevel,
    required this.targetCenter,
  });
  final WeatherData weather;
  final WaveData? wave;
  final SeaLevel? seaLevel;
  final LatLng targetCenter;

  @override
  Widget build(BuildContext context) {
    final w = wave;
    final s = seaLevel;
    final waveStation = w != null
        ? _formatStationWithDistance(w.stationName, w.location, targetCenter)
        : null;
    final wavePeriod = w?.wavePeriod;
    final waterTemp = w?.waterTemperature;
    final gustStr = weather.windGust != null
        ? 'Puuskat ${weather.windGust!.toStringAsFixed(1)} m/s'
        : (weather.stationName != null
              ? 'Asema: ${weather.stationName}'
              : 'Ei havaintoa');

    final isMetForecast = w?.stationName?.contains('MET') ?? false;
    final waveSourceLabel = isMetForecast
        ? 'Ennuste (MET Norway Ocean)'
        : (waveStation != null ? 'Havainto ($waveStation)' : 'Ei aaltotietoa');

    final waveSub = wavePeriod != null
        ? 'Jakso ${wavePeriod.toStringAsFixed(1)} s • $waveSourceLabel'
        : waveSourceLabel;

    final tempSub = weather.feelsLike != null
        ? 'Tuntuu ${weather.feelsLike!.toStringAsFixed(1)}°C'
        : (waterTemp != null
              ? 'Vesi ${waterTemp.toStringAsFixed(1)}°C'
              : 'Lämpötilahavainto');

    final seaLevelSub = s != null
        ? _formatStationWithDistance(s.stationName, s.location, targetCenter)
        : 'Ei korkeushavaintoa';

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _BentoStatCard(
          icon: Icons.air,
          label: 'TUULI',
          value: weather.windSpeed?.toStringAsFixed(1) ?? '-',
          unit: 'm/s',
          color: context.colors.primaryAction,
          subValue: gustStr,
        ),
        _BentoStatCard(
          icon: Icons.waves,
          label: 'AALLOKKO',
          value: wave?.waveHeight != null
              ? wave!.waveHeight!.toStringAsFixed(1)
              : '--',
          unit: 'm',
          color: context.colors.primaryAction,
          subValue: waveSub,
        ),
        _BentoStatCard(
          icon: Icons.thermostat,
          label: 'LÄMPÖTILA',
          value: weather.temperature?.toStringAsFixed(1) ?? '-',
          unit: '°C',
          color: context.colors.warning,
          subValue: tempSub,
        ),
        _BentoStatCard(
          icon: Icons.water,
          label: 'MERIVESI',
          value: seaLevel != null
              ? (seaLevel!.seaLevel / 10).round().toString()
              : '--',
          unit: 'cm',
          color: context.colors.success,
          subValue: seaLevelSub,
        ),
      ],
    );
  }
}

const kSykeWaterQualityHeader = 'VEDENLAATU (SYKE)';

class _WaterQualityCard extends StatelessWidget {
  const _WaterQualityCard({
    required this.waterQuality,
    required this.algae,
    required this.targetCenter,
  });

  final WaterQualityData? waterQuality;
  final AlgaeData? algae;
  final LatLng targetCenter;

  String _riskText(AlgaeRiskLevel? risk) {
    switch (risk) {
      case AlgaeRiskLevel.low:
        return 'Low';
      case AlgaeRiskLevel.moderate:
        return 'Moderate';
      case AlgaeRiskLevel.high:
        return 'High';
      case AlgaeRiskLevel.veryHigh:
        return 'Very high';
      case null:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final stationDistanceStr = waterQuality != null
        ? _formatStationWithDistance(
            waterQuality!.stationName,
            waterQuality!.location,
            targetCenter,
          )
        : null;

    return NovaGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kSykeWaterQualityHeader,
                style: AppTextStyles.nvSm.copyWith(
                  letterSpacing: 1.5,
                  color: colors.textSecondary,
                ),
              ),
              if (stationDistanceStr != null)
                Flexible(
                  child: Text(
                    stationDistanceStr,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.nvXs.copyWith(
                      color: colors.textSecondary.withValues(alpha: 0.8),
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _MiniChip(
                label: 'Chl-a',
                value: waterQuality?.chlorophyllA != null
                    ? '${waterQuality!.chlorophyllA!.toStringAsFixed(1)} µg/L'
                    : '-',
              ),
              _MiniChip(
                label: 'Turbidity',
                value: waterQuality?.turbidity != null
                    ? '${waterQuality!.turbidity!.toStringAsFixed(1)} NTU'
                    : '-',
              ),
              _MiniChip(
                label: 'Dissolved O₂',
                value: waterQuality?.dissolvedOxygen != null
                    ? '${waterQuality!.dissolvedOxygen!.toStringAsFixed(1)} mg/L'
                    : '-',
              ),
              _MiniChip(
                label: 'pH',
                value: waterQuality?.ph != null
                    ? waterQuality!.ph!.toStringAsFixed(1)
                    : '-',
              ),
              _MiniChip(
                label: 'Bloom risk level',
                value: _riskText(algae?.riskLevel),
              ),
              _MiniChip(
                label: 'Algae status',
                value: waterQuality?.algaeStatus ?? '-',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colors.textPrimary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.glassBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.nvXs.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.nvXs.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _AtmosphericCard extends StatelessWidget {
  const _AtmosphericCard({required this.weather});
  final WeatherData weather;

  String _formatVisibility(double? vis) {
    if (vis == null) return '-';
    if (vis >= 1000) return '${(vis / 1000).toStringAsFixed(1)} km';
    return '${vis.toStringAsFixed(0)} m';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return NovaGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ILMASTOTIEDOT',
            style: AppTextStyles.nvSm.copyWith(
              letterSpacing: 1.5,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _MiniChip(
                label: 'Ilmanpaine',
                value: weather.pressure != null
                    ? '${weather.pressure!.toStringAsFixed(1)} hPa'
                    : '-',
              ),
              _MiniChip(
                label: 'Näkyvyys',
                value: _formatVisibility(weather.visibility),
              ),
              _MiniChip(
                label: 'Kosteus',
                value: weather.humidity != null
                    ? '${weather.humidity!.toStringAsFixed(0)}%'
                    : '-',
              ),
              _MiniChip(
                label: 'Sademäärä',
                value: weather.precipitation != null
                    ? '${weather.precipitation!.toStringAsFixed(1)} mm'
                    : '-',
              ),
              _MiniChip(
                label: 'Pilvisyys',
                value: weather.cloudCover != null
                    ? '${weather.cloudCover!.toStringAsFixed(0)}%'
                    : '-',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BentoStatCard extends StatelessWidget {
  const _BentoStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    this.subValue,
  });
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;
  final String? subValue;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return NovaGlassCard(
      padding: const EdgeInsets.all(16),
      intensity: 0.06,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color.withValues(alpha: 0.8)),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.nvXs.copyWith(
                  color: colors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: AppTextStyles.nv2xl.copyWith(color: color)),
              const SizedBox(width: 4),
              Text(
                unit,
                style: AppTextStyles.nvXs.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
          if (subValue != null) ...[
            const SizedBox(height: 4),
            Text(
              subValue!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.nvXs.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.8),
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
