import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/harbors/domain/entities/harbor.dart';

class HarborMarker extends StatelessWidget {
  const HarborMarker({required this.harbor, super.key});

  final Harbor harbor;

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    IconData iconData;

    switch (harbor.type) {
      case HarborType.guestHarbor:
        badgeColor = const Color(0xFF00E676);
        iconData = Icons.anchor_rounded;
      case HarborType.excursionDock:
        badgeColor = const Color(0xFF00B0FF);
        iconData = Icons.sailing_rounded;
      case HarborType.smallBoatHarbor:
        badgeColor = const Color(0xFFFFAB00);
        iconData = Icons.directions_boat_rounded;
      case HarborType.boatRamp:
        badgeColor = const Color(0xFFE040FB);
        iconData = Icons.kayaking_rounded;
    }

    return GestureDetector(
      onTap: () {
        SafeHaptics.selection();
        _showHarborDetails(context, harbor);
      },
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1B2A).withValues(alpha: 0.90),
          shape: BoxShape.circle,
          border: Border.all(color: badgeColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: badgeColor.withValues(alpha: 0.4),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              iconData,
              size: 20,
              color: badgeColor,
            ),
            if (harbor.hasSauna || harbor.hasCampfire)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5252),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static void _showHarborDetails(BuildContext context, Harbor harbor) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppPalette.surface.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppPalette.primaryAction.withValues(alpha: 0.3),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      harbor.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.primaryAction.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      harbor.typeLabel,
                      style: const TextStyle(
                        color: AppPalette.primaryAction,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (harbor.municipality != null) ...[
                const SizedBox(height: 4),
                Text(
                  harbor.municipality!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
              const Divider(color: Colors.white24, height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (harbor.berthCount != null)
                    _FacilityBadge(
                      icon: Icons.dock_rounded,
                      label: '${harbor.berthCount} laituripaikkaa',
                    ),
                  if (harbor.depthMeters != null)
                    _FacilityBadge(
                      icon: Icons.waves_rounded,
                      label: 'Syväys ${harbor.depthMeters}m',
                    ),
                  if (harbor.hasSauna)
                    const _FacilityBadge(
                      icon: Icons.hot_tub_rounded,
                      label: 'Sauna',
                      color: Colors.orangeAccent,
                    ),
                  if (harbor.hasCampfire)
                    const _FacilityBadge(
                      icon: Icons.local_fire_department_rounded,
                      label: 'Nuotiopaikka',
                      color: Colors.amberAccent,
                    ),
                  if (harbor.hasWater)
                    const _FacilityBadge(
                      icon: Icons.water_drop_rounded,
                      label: 'Juomavesi',
                      color: Colors.lightBlueAccent,
                    ),
                  if (harbor.hasElectricity)
                    const _FacilityBadge(
                      icon: Icons.power_rounded,
                      label: 'Maasähkö',
                      color: Colors.yellowAccent,
                    ),
                  if (harbor.hasSepticPumpout)
                    const _FacilityBadge(
                      icon: Icons.cleaning_services_rounded,
                      label: 'Imutyhjennys (Septi)',
                      color: Colors.cyanAccent,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Sulje',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FacilityBadge extends StatelessWidget {
  const _FacilityBadge({
    required this.icon,
    required this.label,
    this.color = Colors.white70,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
