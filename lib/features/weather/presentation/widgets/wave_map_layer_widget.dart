import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/feature_flag_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/presentation/providers/wave_layer_provider.dart';
import 'package:sakkoja/features/weather/presentation/providers/wind_wave_providers.dart';
import 'package:sakkoja/features/weather/presentation/widgets/wave_height_painter.dart';

/// Dedicated Wave Layer for Sakkoja Map.
/// Renders live wave height contours and dynamic FMI Wave Buoy markers from SQLite.
class WaveMapLayerWidget extends ConsumerWidget {
  const WaveMapLayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(waveLayerProvider);
    if (!isVisible) return const SizedBox.shrink();

    final camera = MapCamera.of(context);
    final isFlagEnabled = ref.watch(windWaveFeatureFlagProvider);
    final waveFieldAsync = ref.watch(waveFieldProvider);
    final liveWavesAsync = ref.watch(allWaveObservationsStreamProvider);

    return Stack(
      children: [
        // 1. Live Continuous Wave Contour Heatmap
        if (isFlagEnabled)
          waveFieldAsync.when(
            data: (field) {
              if (field.points.isEmpty) return const SizedBox.shrink();
              return RepaintBoundary(
                child: CustomPaint(
                  size: camera.size,
                  painter: WaveHeightPainter(
                    field: field,
                    camera: camera,
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),

        // 2. Dynamic FMI Buoy Station Markers (Real telemetry from SQLite)
        liveWavesAsync.when(
          data: (waves) {
            if (waves.isEmpty) return const SizedBox.shrink();
            return MarkerLayer(
              markers: waves.map((wave) {
                final height = wave.waveHeight ?? 0.0;
                final direction = wave.waveDirection ?? 0.0;
                final waveColor = _getWaveColor(height);

                return Marker(
                  point: wave.location,
                  width: 80,
                  height: 64,
                  rotate: false,
                  child: GestureDetector(
                    onTap: () {
                      SafeHaptics.selection();
                      _showBuoyBottomSheet(context, wave);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppPalette.navikkaSurface.withValues(
                              alpha: 0.9,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: waveColor,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: waveColor.withValues(alpha: 0.4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (wave.waveDirection != null) ...[
                                Transform.rotate(
                                  angle: direction * (math.pi / 180),
                                  child: Icon(
                                    Icons.navigation,
                                    size: 12,
                                    color: waveColor,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                wave.waveHeight != null
                                    ? '${wave.waveHeight!.toStringAsFixed(1)}m'
                                    : '--',
                                style: TextStyle(
                                  color: waveColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Color _getWaveColor(double height) {
    if (height < 0.5) return AppPalette.success;
    if (height < 1.2) return AppPalette.warning;
    if (height < 2.5) return const Color(0xFFF97316); // Orange
    return AppPalette.danger;
  }

  void _showBuoyBottomSheet(BuildContext context, WaveData wave) {
    final waveColor = _getWaveColor(wave.waveHeight ?? 0.0);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppPalette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      wave.stationName ?? 'FMI Aaltopoiju',
                      style: const TextStyle(
                        color: AppPalette.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: waveColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: waveColor),
                    ),
                    child: Text(
                      'FMI AALTOPOIJU',
                      style: TextStyle(
                        color: waveColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MetricCard(
                    label: 'Merkitsevä aallokko',
                    value: wave.waveHeight != null
                        ? '${wave.waveHeight!.toStringAsFixed(1)} m'
                        : '--',
                    icon: Icons.waves,
                    color: waveColor,
                  ),
                  _MetricCard(
                    label: 'Aallon jakso (Tp)',
                    value: wave.wavePeriod != null
                        ? '${wave.wavePeriod!.toStringAsFixed(1)} s'
                        : '--',
                    icon: Icons.timer_outlined,
                    color: AppPalette.primaryAction,
                  ),
                  _MetricCard(
                    label: 'Veden lämpötila',
                    value: wave.waterTemperature != null
                        ? '${wave.waterTemperature!.toStringAsFixed(1)} °C'
                        : '--',
                    icon: Icons.thermostat,
                    color: AppPalette.textPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: AppPalette.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
