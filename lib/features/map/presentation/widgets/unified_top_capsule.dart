import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/cockpit_mode_pill_selector.dart';
import 'package:sakkoja/features/map/presentation/widgets/marine_search_bar.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

/// Single unified top glass container integrating search, safety alerts,
/// and camera mode toggles with zero overlap.
/// Constrained to max width on desktop/web screens to prevent full-width stretching.
class UnifiedTopCapsule extends ConsumerStatefulWidget {
  const UnifiedTopCapsule({
    required this.onSelectLocation,
    super.key,
  });

  final void Function(LatLng target) onSelectLocation;

  @override
  ConsumerState<UnifiedTopCapsule> createState() => _UnifiedTopCapsuleState();
}

class _UnifiedTopCapsuleState extends ConsumerState<UnifiedTopCapsule> {
  bool _isSearchExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final is3dTiltEnabled = ref.watch(map3dTiltProvider);
    final lightningLevel =
        ref.watch(pointWeatherControllerProvider).lightningAlarmLevel;
    final hasLightning = lightningLevel.index > 0;

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 68),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: hasLightning
                          ? colors.danger.withValues(alpha: 0.7)
                          : colors.glassBorder,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Active Lightning Alarm Header (if active)
                      if (hasLightning)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colors.danger.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: colors.danger.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  size: 18,
                                  color: colors.danger,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'SALAMANISKU VAROITUS AKTIIVINEN',
                                    style: TextStyle(
                                      color: colors.danger,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Compact Bar: Search Toggle + 2D/3D Mode Pill Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (_isSearchExpanded) ...[
                            Expanded(
                              child: MarineSearchBar(
                                onSelectLocation: (target) {
                                  widget.onSelectLocation(target);
                                  setState(() => _isSearchExpanded = false);
                                },
                              ),
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: colors.textSecondary,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                SafeHaptics.selection();
                                setState(() => _isSearchExpanded = false);
                              },
                            ),
                          ] else ...[
                            // Compact Search Button (Optional Search)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  SafeHaptics.selection();
                                  setState(() => _isSearchExpanded = true);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.surface.withValues(
                                      alpha: 0.6,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: colors.glassBorder,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        size: 16,
                                        color: colors.textPrimary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Hae paikkaa',
                                        style: TextStyle(
                                          color: colors.textPrimary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(width: 8),

                          // 2D/3D Tilt Mode Toggle
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                SafeHaptics.selection();
                                ref.read(map3dTiltProvider.notifier).toggle();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: is3dTiltEnabled
                                      ? colors.primaryAction.withValues(
                                          alpha: 0.2,
                                        )
                                      : colors.surface.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: is3dTiltEnabled
                                        ? colors.primaryAction
                                        : colors.glassBorder,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      is3dTiltEnabled
                                          ? Icons.view_in_ar
                                          : Icons.map,
                                      size: 16,
                                      color: is3dTiltEnabled
                                          ? colors.primaryAction
                                          : colors.textPrimary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      is3dTiltEnabled ? '3D' : '2D',
                                      style: TextStyle(
                                        color: is3dTiltEnabled
                                            ? colors.primaryAction
                                            : colors.textPrimary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Cockpit Mode Pill Selector Row (Cruising, Harbor, Fishing, Emergency)
                      if (!_isSearchExpanded) ...[
                        const SizedBox(height: 8),
                        const CockpitModePillSelector(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
