import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid_type.dart';

class NavigationAidDetailSheet extends StatelessWidget {
  const NavigationAidDetailSheet({required this.aid, super.key});
  final NavigationAid aid;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.7,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: AppPalette.glassBorder())),
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
                    color: AppPalette.textSecondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    // Header
                    Row(
                      children: [
                        _buildTypeIcon(),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                aid.name ?? _getDefaultName(),
                                style: const TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppPalette.textPrimary,
                                ),
                              ),
                              Text(
                                aid.id,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: AppPalette.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Stats Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 2.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        if (aid.lightRangeNm != null)
                          _buildStat(
                            'KANTAMA',
                            '${aid.lightRangeNm!.toStringAsFixed(1)} NM',
                            Icons.light_mode,
                          ),
                        if (aid.lightCharacteristics != null)
                          _buildStat(
                            'VALOTUNNUS',
                            aid.lightCharacteristics!,
                            Icons.visibility,
                          ),
                        if (aid.mounting != null)
                          _buildStat(
                            'RAKENNE',
                            aid.mounting.toString().split('.').last,
                            Icons.construction,
                          ),
                        if (aid.owner != null)
                          _buildStat('OMISTAJA', aid.owner!, Icons.business),
                      ],
                    ),
                    const SizedBox(height: 24),

                    if (aid.signTypeDescription != null) ...[
                      const Text(
                        'LISÄTIEDOT',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.textSecondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        aid.signTypeDescription!,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: AppPalette.textPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypeIcon() {
    IconData icon;
    var color = AppPalette.primaryAction;

    switch (aid.type) {
      case NavigationAidType.lighthouse:
        icon = Icons.fort;
        color = AppPalette.warning;
      case NavigationAidType.trafficSign:
        icon = Icons.signpost;
      case NavigationAidType.safetyEquipment:
        icon = Icons.anchor;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  String _getDefaultName() {
    switch (aid.type) {
      case NavigationAidType.lighthouse:
        return 'Majakka';
      case NavigationAidType.trafficSign:
        return 'Liikennemerkki';
      case NavigationAidType.safetyEquipment:
        return 'Turvalaite';
    }
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppPalette.surfaceHighlight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPalette.glassBorder()),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppPalette.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
