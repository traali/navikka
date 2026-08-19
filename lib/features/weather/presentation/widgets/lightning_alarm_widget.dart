import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/widgets/nova_glass_card.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_state.dart';

class LightningAlarmWidget extends StatelessWidget {
  const LightningAlarmWidget({
    required this.level,
    required this.distanceMeters,
    super.key,
  });

  final LightningAlarmLevel level;
  final double? distanceMeters;

  @override
  Widget build(BuildContext context) {
    if (level == LightningAlarmLevel.none) return const SizedBox.shrink();

    final isDanger = level == LightningAlarmLevel.danger;
    final color = isDanger ? AppPalette.danger : AppPalette.warning;
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
