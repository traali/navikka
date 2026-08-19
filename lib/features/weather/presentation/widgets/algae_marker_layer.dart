import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/presentation/widgets/glass_container.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

/// Renders interactive SYKE Water Quality & Algae observation markers on flutter_map.
///
/// Provides local pin-level visibility (chlorophyll-a, turbidity, bloom risk,
/// and distance) alongside the satellite WMS heatmap overlay.
class AlgaeMarkerLayer extends ConsumerWidget {
  const AlgaeMarkerLayer({required this.visible, super.key});
  final bool visible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!visible) return const SizedBox.shrink();

    final targetCenter = ref.watch(debouncedMapCameraPositionProvider).center;
    final state = ref.watch(pointWeatherControllerProvider);
    final waterQuality = state.waterQuality;
    final algae = state.algae;

    final markers = <Marker>[];

    // 1. SYKE Water Quality Laboratory Sampling Station
    if (waterQuality != null) {
      markers.add(
        Marker(
          point: waterQuality.location,
          width: 36,
          height: 36,
          child: GestureDetector(
            onTap: () {
              SafeHaptics.light();
              _showWaterQualitySheet(context, waterQuality, targetCenter);
            },
            child: _WaterQualityMarkerPin(
              stationName: waterQuality.stationName,
              chlorophyllA: waterQuality.chlorophyllA,
            ),
          ),
        ),
      );
    }

    // 2. SYKE Citizen Algae Report Sighting
    if (algae != null) {
      markers.add(
        Marker(
          point: algae.location,
          width: 32,
          height: 32,
          child: GestureDetector(
            onTap: () {
              SafeHaptics.light();
              _showAlgaeReportSheet(context, algae, targetCenter);
            },
            child: _AlgaeReportMarkerPin(riskLevel: algae.riskLevel),
          ),
        ),
      );
    }

    if (markers.isEmpty) return const SizedBox.shrink();

    return MarkerLayer(markers: markers);
  }

  void _showWaterQualitySheet(
    BuildContext context,
    WaterQualityData data,
    LatLng targetCenter,
  ) {
    const distCalc = Distance();
    final meters = distCalc.as(LengthUnit.Meter, targetCenter, data.location);
    final distStr = meters < 1000
        ? '${meters.round()} m'
        : '${(meters / 1000).toStringAsFixed(1)} km';

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GlassContainer(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.stationName ?? 'SYKE Havaintoasema',
                          style: AppTextStyles.nvLg.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Vedenlaatuasema • Etäisyys: $distStr',
                          style: AppTextStyles.nvXs.copyWith(
                            color: AppPalette.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.water, color: AppPalette.primaryAction),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _MetricBadge(
                    label: 'Chlorophyll-a',
                    value: data.chlorophyllA != null
                        ? '${data.chlorophyllA!.toStringAsFixed(1)} µg/L'
                        : '-',
                  ),
                  _MetricBadge(
                    label: 'Turbidity',
                    value: data.turbidity != null
                        ? '${data.turbidity!.toStringAsFixed(1)} NTU'
                        : '-',
                  ),
                  _MetricBadge(
                    label: 'Dissolved O₂',
                    value: data.dissolvedOxygen != null
                        ? '${data.dissolvedOxygen!.toStringAsFixed(1)} mg/L'
                        : '-',
                  ),
                  _MetricBadge(
                    label: 'pH',
                    value: data.ph != null ? data.ph!.toStringAsFixed(1) : '-',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAlgaeReportSheet(
    BuildContext context,
    AlgaeData data,
    LatLng targetCenter,
  ) {
    const distCalc = Distance();
    final meters = distCalc.as(LengthUnit.Meter, targetCenter, data.location);
    final distStr = meters < 1000
        ? '${meters.round()} m'
        : '${(meters / 1000).toStringAsFixed(1)} km';

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GlassContainer(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SYKE Levähavainto',
                        style: AppTextStyles.nvLg.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Kansalaishavainto • Etäisyys: $distStr',
                        style: AppTextStyles.nvXs.copyWith(
                          color: AppPalette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.bug_report, color: AppPalette.warning),
                ],
              ),
              const SizedBox(height: 16),
              _MetricBadge(
                label: 'Leväriski / Bloom Risk',
                value: data.riskLevel?.name.toUpperCase() ?? 'NONE',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WaterQualityMarkerPin extends StatelessWidget {
  const _WaterQualityMarkerPin({
    required this.stationName,
    required this.chlorophyllA,
  });

  final String? stationName;
  final double? chlorophyllA;

  @override
  Widget build(BuildContext context) {
    final color = chlorophyllA != null && chlorophyllA! > 10.0
        ? AppPalette.warning
        : AppPalette.primaryAction;

    return Container(
      decoration: BoxDecoration(
        color: AppPalette.canvas.withValues(alpha: 0.85),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Icon(Icons.opacity, size: 18, color: color),
      ),
    );
  }
}

class _AlgaeReportMarkerPin extends StatelessWidget {
  const _AlgaeReportMarkerPin({required this.riskLevel});

  final AlgaeRiskLevel? riskLevel;

  Color _getColor() {
    switch (riskLevel) {
      case AlgaeRiskLevel.low:
        return AppPalette.warning;
      case AlgaeRiskLevel.moderate:
        return Colors.orange;
      case AlgaeRiskLevel.high:
      case AlgaeRiskLevel.veryHigh:
        return AppPalette.danger;
      case null:
        return AppPalette.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.water, size: 16, color: Colors.white),
      ),
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.textPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppPalette.textPrimary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.nvXs.copyWith(color: AppPalette.textSecondary),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextStyles.nvSm.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
