import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/weather/domain/extensions/weather_forecast_extensions.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/offline_banner.dart';

const kHeaderLocalWeather = 'Paikallissää';
const kHeaderForecast = 'Ennuste (seuraavat 24h)';

class WeatherDetailSheet extends ConsumerWidget {
  const WeatherDetailSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final weatherState = ref.watch(pointWeatherControllerProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: colors.glassBorder)),
          ),
          child: Column(
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: colors.textSecondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Expanded(
                child: Builder(
                  builder: (context) {
                    if (weatherState.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colors.primaryAction,
                        ),
                      );
                    }

                    final state = weatherState;
                    if (state.weather == null) {
                      return Center(
                        child: Text(
                          'Ei säätietoja saatavilla',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      );
                    }

                    final weather = state.weather!;
                    final wave = state.wave;

                    return ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        // Header
                        Text(
                          kHeaderLocalWeather,
                          style: AppTextStyles.h2.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 16),
                        OfflineBanner(
                          message: state.syncError,
                          onRetry: () {
                            ref.invalidate(pointWeatherControllerProvider);
                          },
                        ),

                        Row(
                          children: [
                            Text(
                              weather.stationName ?? 'Havaintoasema',
                              style: TextStyle(
                                fontSize: 14,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Updated: ${state.lastUpdated.formattedTime}',
                              style: TextStyle(
                                fontSize: 12,
                                color: colors.textSecondary.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            if (state.isSyncing) ...[
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: colors.primaryAction,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Main Stats Grid
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: [
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.air,
                              label: 'Tuuli',
                              value:
                                  '${weather.windSpeed?.toStringAsFixed(1) ?? "--"} m/s',
                              subValue: weather.windDirection != null
                                  ? '${weather.windDirection?.toStringAsFixed(0)}°'
                                  : null,
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.waves,
                              label: 'Aallokko',
                              value: wave?.waveHeight != null
                                  ? '${wave!.waveHeight!.toStringAsFixed(1)} m'
                                  : '--',
                              subValue: wave?.wavePeriod != null
                                  ? '${wave!.wavePeriod!.toStringAsFixed(1)} s'
                                  : null,
                              color: colors.primaryAction,
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.thermostat,
                              label: 'Ilman lämpötila',
                              value:
                                  '${weather.temperature?.toStringAsFixed(1) ?? "--"}°C',
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.water_drop,
                              label: 'Veden lämpötila',
                              value: wave?.waterTemperature != null
                                  ? '${wave!.waterTemperature!.toStringAsFixed(1)}°C'
                                  : '--',
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.water,
                              label: 'Merivedenkorkeus',
                              value: state.seaLevel != null
                                  ? '${(state.seaLevel!.seaLevel / 10).round()} cm'
                                  : '--',
                              subValue: state.seaLevel?.stationName,
                              color: colors.primaryAction,
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.compress,
                              label: 'Ilmanpaine',
                              value: weather.pressure != null
                                  ? '${weather.pressure!.toStringAsFixed(1)} hPa'
                                  : '--',
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.umbrella_outlined,
                              label: 'Sade (1h)',
                              value: weather.precipitation != null
                                  ? '${weather.precipitation!.toStringAsFixed(1)} mm'
                                  : '--',
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.cloud_outlined,
                              label: 'Pilvisyys',
                              value: weather.cloudCover != null
                                  ? '${weather.cloudCover!.toStringAsFixed(0)}%'
                                  : '--',
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.visibility,
                              label: 'Näkyvyys',
                              value: weather.visibility != null
                                  ? (weather.visibility! >= 1000
                                        ? '${(weather.visibility! / 1000).toStringAsFixed(1)} km'
                                        : '${weather.visibility!.toStringAsFixed(0)} m')
                                  : '--',
                            ),
                            _buildStatCard(
                              colors: colors,
                              icon: Icons.water_drop_outlined,
                              label: 'Ilmankosteus',
                              value: weather.humidity != null
                                  ? '${weather.humidity!.toStringAsFixed(0)}%'
                                  : '--',
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Forecast Section
                        if (state.forecast.isNotEmpty) ...[
                          Text(
                            kHeaderForecast,
                            style: AppTextStyles.h3.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 140,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.forecast.length,
                              itemBuilder: (context, index) {
                                final item = state.forecast[index];
                                return Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: colors.surfaceHighlight,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: colors.glassBorder,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.timestamp.formattedTime,
                                        style: TextStyle(
                                          color: colors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Wind Direction Arrow
                                      if (item.windDirection != null)
                                        Transform.rotate(
                                          angle: item.windRotationRadians,
                                          child: Icon(
                                            Icons.navigation,
                                            size: 20,
                                            color: colors.textPrimary,
                                          ),
                                        ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.windSpeed?.toStringAsFixed(1) ??
                                            '-',
                                        style: AppTextStyles.mono.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        'm/s',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${item.temperature?.toStringAsFixed(1) ?? "-"}°',
                                        style: TextStyle(
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        const SizedBox(height: 32),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required AppThemeColors colors,
    required IconData icon,
    required String label,
    required String value,
    String? subValue,
    Color? color,
  }) {
    final valueColor = color ?? colors.textPrimary;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceHighlight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: colors.textSecondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.mono.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          if (subValue != null)
            Text(
              subValue,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
