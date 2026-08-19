import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/fishing/presentation/utils/fishing_colors.dart';

class FishingLayers extends ConsumerStatefulWidget {
  const FishingLayers({super.key});

  @override
  ConsumerState<FishingLayers> createState() => _FishingLayersState();
}

class _FishingLayersState extends ConsumerState<FishingLayers>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      // PERFORMANCE: 3s duration = 33% fewer animation frames than 2s
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // PERFORMANCE: Use sync provider for instant updates without flicker
    final restrictions = ref.watch(displayedFishingRestrictionsProvider);

    // Filter valid restrictions once
    final validRestrictions = restrictions
        .where((r) => r.rings.isNotEmpty && r.rings.first.isNotEmpty)
        .toList();

    // OPTIMIZATION: Single-pass partition
    final activeRestrictions = <FishingRestriction>[];
    final inactiveRestrictions = <FishingRestriction>[];

    for (final r in validRestrictions) {
      if (r.isCurrentlyActive) {
        activeRestrictions.add(r);
      } else {
        inactiveRestrictions.add(r);
      }
    }

    // DEBUG: Log waterway feature counts by type

    // Build static layers ONCE (passed as child to AnimatedBuilder)
    final staticLayers = Stack(
      children: [
        // STATIC: Inactive fishing restrictions (majority of polygons)
        PolygonLayer(
          polygons: inactiveRestrictions.map((r) {
            // OPTIMIZATION: Use cached category for color lookup
            final color = FishingColors.getColorForCategory(r.category);
            return Polygon(
              points: r.rings.first,
              holePointsList: r.rings.length > 1 ? r.rings.sublist(1) : null,
              color: color.withValues(alpha: 0.40),
              borderColor: color.withValues(alpha: 0.8),
              borderStrokeWidth: 2,
              label: r.title,
              labelStyle: TextStyle(
                color: AppPalette.textPrimary.withValues(alpha: 0.8),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            );
          }).toList(),
        ),
      ],
    );

    // Return early if no active restrictions (no animation needed)
    if (activeRestrictions.isEmpty) {
      return staticLayers;
    }

    // AnimatedBuilder: Only rebuilds ACTIVE restrictions on each frame
    return AnimatedBuilder(
      animation: _pulseAnimation,
      // PERFORMANCE: Static layers passed as child (not rebuilt on animation)
      child: staticLayers,
      builder: (context, child) {
        final pulseValue = _pulseAnimation.value;

        return Stack(
          children: [
            // Static layers (from child param - NOT rebuilt)
            child!,

            // ANIMATED: Active restrictions only (typically <5% of total)
            PolygonLayer(
              polygons: activeRestrictions.map((r) {
                // OPTIMIZATION: Use cached category for color lookup
                final color = FishingColors.getColorForCategory(r.category);
                return Polygon(
                  points: r.rings.first,
                  holePointsList: r.rings.length > 1
                      ? r.rings.sublist(1)
                      : null,
                  color: color.withValues(alpha: 0.35),
                  borderColor: color.withValues(alpha: pulseValue),
                  borderStrokeWidth: 4,
                  label: r.title,
                  labelStyle: TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    shadows: [Shadow(blurRadius: 4 * pulseValue)],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
