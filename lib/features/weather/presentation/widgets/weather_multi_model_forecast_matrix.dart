import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/widgets/nova_glass_card.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';
import 'package:sakkoja/features/weather/domain/extensions/weather_forecast_extensions.dart';

/// Provider identity constants
const int kProviderFmi = 10;
const int kProviderMetNorway = 5;
const int kProviderOpenMeteo = 3;

/// Groups multi-model forecast snapshots and live observations into an hourly comparison slot.
class MultiModelHourSlot {
  MultiModelHourSlot({
    required this.timestamp,
    required this.isCurrentHour,
    this.fmi,
    this.metNorway,
    this.openMeteo,
  });

  final DateTime timestamp;
  final bool isCurrentHour;
  WeatherForecast? fmi;
  WeatherForecast? metNorway;
  WeatherForecast? openMeteo;

  List<WeatherForecast> get availableForecasts => [
    ...?fmi == null ? null : [fmi!],
    ...?metNorway == null ? null : [metNorway!],
    ...?openMeteo == null ? null : [openMeteo!],
  ];

  double? get minWind {
    final winds = availableForecasts
        .map((f) => f.windSpeed)
        .whereType<double>()
        .toList();
    if (winds.isEmpty) return null;
    return winds.reduce(math.min);
  }

  double? get maxWind {
    final winds = availableForecasts
        .map((f) => f.windSpeed)
        .whereType<double>()
        .toList();
    if (winds.isEmpty) return null;
    return winds.reduce(math.max);
  }

  double get windSpread {
    final min = minWind;
    final max = maxWind;
    if (min == null || max == null) return 0;
    return (max - min).abs();
  }

  bool get hasHighSpread => windSpread >= 2.0;
}

/// Vertical multi-model forecast matrix displaying all available models side-by-side
/// with live ground-truth station observations in the current time slot.
class WeatherMultiModelForecastMatrix extends StatelessWidget {
  const WeatherMultiModelForecastMatrix({
    required this.forecasts,
    required this.currentWeather,
    required this.currentWave,
    required this.targetCenter,
    super.key,
  });

  final List<WeatherForecast> forecasts;
  final WeatherData? currentWeather;
  final WaveData? currentWave;
  final LatLng targetCenter;

  List<MultiModelHourSlot> _groupForecasts() {
    final now = DateTime.now();
    final currentHourKey = DateTime(now.year, now.month, now.day, now.hour);
    final Map<DateTime, MultiModelHourSlot> slots = {};

    // Ensure current hour slot exists if we have current weather
    slots[currentHourKey] = MultiModelHourSlot(
      timestamp: currentHourKey,
      isCurrentHour: true,
    );

    for (final f in forecasts) {
      final hourKey = DateTime(
        f.timestamp.year,
        f.timestamp.month,
        f.timestamp.day,
        f.timestamp.hour,
      );

      // Skip past hours (older than current hour)
      if (hourKey.isBefore(currentHourKey)) continue;

      final isCurrent = hourKey == currentHourKey;
      final slot = slots.putIfAbsent(
        hourKey,
        () => MultiModelHourSlot(
          timestamp: hourKey,
          isCurrentHour: isCurrent,
        ),
      );

      final providerId = f.providerId ?? kProviderFmi;
      if (providerId == kProviderFmi) {
        slot.fmi ??= f;
      } else if (providerId == kProviderMetNorway) {
        slot.metNorway ??= f;
      } else if (providerId == kProviderOpenMeteo) {
        slot.openMeteo ??= f;
      } else {
        // Fallback
        slot.fmi ??= f;
      }
    }

    final sorted = slots.values.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Limit to next 24 hours
    return sorted.take(24).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final slots = _groupForecasts();

    if (slots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.compare_arrows,
                  size: 18,
                  color: colors.primaryAction,
                ),
                const SizedBox(width: 8),
                Text(
                  'ENNUSTE & MALLIVERTAILU (24H)',
                  style: AppTextStyles.nvSm.copyWith(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            Text(
              'FMI • MET • OPEN-METEO',
              style: AppTextStyles.nvXs.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.8),
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Vertical List of Time Slots
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: slots.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final slot = slots[index];
            return _HourlyMultiModelCard(
              slot: slot,
              currentWeather: slot.isCurrentHour ? currentWeather : null,
              currentWave: slot.isCurrentHour ? currentWave : null,
            );
          },
        ),
      ],
    );
  }
}

/// Single hourly row comparing models side-by-side
class _HourlyMultiModelCard extends StatelessWidget {
  const _HourlyMultiModelCard({
    required this.slot,
    this.currentWeather,
    this.currentWave,
  });

  final MultiModelHourSlot slot;
  final WeatherData? currentWeather;
  final WaveData? currentWave;

  String _formatRelativeTime(DateTime slotTime, bool isCurrent) {
    if (isCurrent) return 'NYT';
    final now = DateTime.now();
    final diffHours = slotTime.difference(now).inHours + 1;
    if (diffHours <= 0) return 'NYT';
    return '+$diffHours h';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isCurrent = slot.isCurrentHour;
    final relativeLabel = _formatRelativeTime(slot.timestamp, isCurrent);

    return NovaGlassCard(
      intensity: isCurrent ? 0.12 : 0.05,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Header & Spread Indicator Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? colors.primaryAction.withValues(alpha: 0.2)
                          : colors.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isCurrent
                            ? colors.primaryAction
                            : colors.glassBorder,
                      ),
                    ),
                    child: Text(
                      relativeLabel,
                      style: AppTextStyles.nvXs.copyWith(
                        color: isCurrent
                            ? colors.primaryAction
                            : colors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    slot.timestamp.formattedTime,
                    style: AppTextStyles.nvSm.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
              if (slot.availableForecasts.length > 1)
                _SpreadBadge(spread: slot.windSpread)
              else if (isCurrent && currentWeather != null)
                Text(
                  'Havaintoasema live',
                  style: AppTextStyles.nvXs.copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),

          // Ground Truth Live Measurement (Current Hour Only)
          if (isCurrent && currentWeather != null) ...[
            const SizedBox(height: 10),
            _LiveObservationStrip(
              weather: currentWeather!,
              wave: currentWave,
            ),
          ],

          const SizedBox(height: 12),

          // Multi-Model Columns Side-by-Side
          _ModelComparisonRow(
            slot: slot,
            fallbackWeather: isCurrent ? currentWeather : null,
          ),
        ],
      ),
    );
  }
}

/// Highlights the actual station measurement alongside the nowcasts
class _LiveObservationStrip extends StatelessWidget {
  const _LiveObservationStrip({
    required this.weather,
    this.wave,
  });

  final WeatherData weather;
  final WaveData? wave;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final windStr = weather.windSpeed != null
        ? '${weather.windSpeed!.toStringAsFixed(1)} m/s'
        : '-';
    final gustStr = weather.windGust != null
        ? ' (puuska ${weather.windGust!.toStringAsFixed(1)} m/s)'
        : '';
    final tempStr = weather.temperature != null
        ? '${weather.temperature!.toStringAsFixed(1)}°C'
        : '';
    final station = weather.stationName ?? 'Asema';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colors.success.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.success.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.sensors, color: colors.success, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.nvXs.copyWith(color: colors.textPrimary),
                children: [
                  TextSpan(
                    text: 'MITATTU HAVAINTO ($station): ',
                    style: TextStyle(
                      color: colors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '$windStr$gustStr',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (tempStr.isNotEmpty) TextSpan(text: ' • $tempStr'),
                  if (wave?.waveHeight != null)
                    TextSpan(
                      text:
                          ' • Aallokko ${wave!.waveHeight!.toStringAsFixed(1)} m',
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Side-by-side columns comparing FMI, MET Norway, and Open-Meteo
class _ModelComparisonRow extends StatelessWidget {
  const _ModelComparisonRow({
    required this.slot,
    this.fallbackWeather,
  });

  final MultiModelHourSlot slot;
  final WeatherData? fallbackWeather;

  @override
  Widget build(BuildContext context) {
    // If no forecasts exist for this hour, synthesize from fallback if current
    final fmi =
        slot.fmi ??
        (fallbackWeather != null
            ? WeatherForecast(
                timestamp: slot.timestamp,
                windSpeed: fallbackWeather!.windSpeed,
                windGust: fallbackWeather!.windGust,
                windDirection: fallbackWeather!.windDirection,
                temperature: fallbackWeather!.temperature,
                providerId: kProviderFmi,
              )
            : null);

    final met = slot.metNorway;
    final openMeteo = slot.openMeteo;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ModelColumn(
            providerName: '🇫🇮 FMI',
            modelName: 'HARMONIE',
            forecast: fmi,
            accentColor: context.colors.primaryAction,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ModelColumn(
            providerName: '🇳🇴 MET NO',
            modelName: 'MEPS Ocean',
            forecast: met,
            accentColor: const Color(0xFF38BDF8),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ModelColumn(
            providerName: '🌐 OPEN-METEO',
            modelName: 'ECMWF/ICON',
            forecast: openMeteo,
            accentColor: const Color(0xFFA78BFA),
          ),
        ),
      ],
    );
  }
}

/// Single model card inside the hourly row displaying wind speed, gusts, direction, temp, and rain
class _ModelColumn extends StatelessWidget {
  const _ModelColumn({
    required this.providerName,
    required this.modelName,
    required this.forecast,
    required this.accentColor,
  });

  final String providerName;
  final String modelName;
  final WeatherForecast? forecast;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final f = forecast;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: colors.textPrimary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.glassBorder,
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          // Provider Title
          Text(
            providerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.nvXs.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          Text(
            modelName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.nvXs.copyWith(
              color: colors.textSecondary.withValues(alpha: 0.7),
              fontSize: 8.5,
            ),
          ),
          const SizedBox(height: 6),

          if (f != null && f.windSpeed != null) ...[
            // Wind Speed & Arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (f.windDirection != null)
                  Transform.rotate(
                    angle: f.windRotationRadians,
                    child: Icon(
                      Icons.navigation,
                      size: 14,
                      color: accentColor,
                    ),
                  ),
                const SizedBox(width: 4),
                Text(
                  f.windSpeed!.toStringAsFixed(1),
                  style: AppTextStyles.nvBase.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                Text(
                  ' m/s',
                  style: AppTextStyles.nvXs.copyWith(
                    color: colors.textSecondary,
                    fontSize: 9,
                  ),
                ),
              ],
            ),

            // Wind Gust (Puuska) prominently shown
            const SizedBox(height: 4),
            if (f.windGust != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: colors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Puuska ${f.windGust!.toStringAsFixed(1)}',
                  style: AppTextStyles.nvXs.copyWith(
                    color: colors.warning,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              Text(
                '–',
                style: AppTextStyles.nvXs.copyWith(
                  color: colors.textSecondary.withValues(alpha: 0.4),
                  fontSize: 9,
                ),
              ),

            // Temperature & Rain
            const SizedBox(height: 4),
            if (f.temperature != null)
              Text(
                '${f.temperature!.toStringAsFixed(0)}°C',
                style: AppTextStyles.nvXs.copyWith(
                  color: colors.textSecondary,
                  fontSize: 9.5,
                ),
              ),
            if (f.precipitation != null && f.precipitation! > 0)
              Text(
                '💧 ${f.precipitation!.toStringAsFixed(1)} mm',
                style: AppTextStyles.nvXs.copyWith(
                  color: const Color(0xFF60A5FA),
                  fontSize: 9,
                ),
              ),
          ] else ...[
            // No Data
            const SizedBox(height: 8),
            Text(
              '–',
              style: AppTextStyles.nvBase.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

/// Shows spread between models
class _SpreadBadge extends StatelessWidget {
  const _SpreadBadge({required this.spread});
  final double spread;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isHigh = spread >= 2.0;
    final isModerate = spread >= 1.0;

    final badgeColor = isHigh
        ? colors.warning
        : (isModerate ? colors.primaryAction : colors.success);

    final label = isHigh
        ? '±${spread.toStringAsFixed(1)} m/s (Hajontaa)'
        : '±${spread.toStringAsFixed(1)} m/s (Yhdenmukainen)';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.4),
          width: 0.8,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.nvXs.copyWith(
          color: badgeColor,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
