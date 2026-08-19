import 'package:flutter/material.dart';
import 'package:sakkoja/features/map/presentation/widgets/vortex/vortex_adaptive_dashboard.dart';
import 'package:sakkoja/features/map/presentation/widgets/vortex/vortex_arc_menu.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';

class VortexHudAssembly extends StatelessWidget {
  const VortexHudAssembly({
    required this.hasLocation,
    required this.currentSpeed,
    required this.currentZone,
    required this.heading,
    required this.isFishingMode,
    required this.entranceController,
    super.key,
  });

  final bool hasLocation;
  final double currentSpeed;
  final SpeedLimitZone? currentZone;
  final double heading;
  final bool isFishingMode;
  final AnimationController entranceController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: entranceController,
      child: Stack(
        children: [
          // Adaptive Dashboard (Top Left)
          Positioned(
            top: MediaQuery.paddingOf(context).top + 16,
            left: 16,
            child: VortexAdaptiveDashboard(
              currentSpeedKmh: currentSpeed,
              heading: heading,
              speedLimitKmh: (currentZone?.speedLimitKmh ?? 0).toDouble(),
              hasLocation: hasLocation,
            ),
          ),

          // Arc Menu (Bottom Right)
          const Positioned(
            bottom: 0,
            right: 0,
            child: VortexArcMenu(),
          ),
        ],
      ),
    );
  }
}
