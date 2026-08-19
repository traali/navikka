import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/layers_panel.dart';

class LayersFab extends ConsumerWidget {
  const LayersFab({super.key, this.isFloating = true});

  final bool isFloating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _LayersFabContent(isFloating: isFloating);
  }
}

class _LayersFabContent extends ConsumerWidget {
  const _LayersFabContent({required this.isFloating});

  final bool isFloating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerFilter = ref.watch(layerFilterProvider);

    int activeCount = 0;
    layerFilter.whenData((state) {
      if (state.showWeatherRadar) activeCount++;
      if (state.showAlgaeLayer) activeCount++;
      if (state.showNavigationAids) activeCount++;
      if (state.showBoatingLines) activeCount++;
      if (state.showSpeedLimits) activeCount++;
      if (state.showMaritimeRestrictions) activeCount++;
    });

    final button = _DiamondButton(
      activeCount: activeCount,
      onPressed: () => _openLayersPanel(context),
    );

    if (isFloating) {
      return Positioned(
        right: 12,
        bottom: 64,
        child: button,
      );
    } else {
      return button;
    }
  }

  void _openLayersPanel(BuildContext context) {
    SafeHaptics.light();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const LayersPanel(),
    );
  }
}

class _DiamondButton extends StatefulWidget {
  const _DiamondButton({required this.activeCount, required this.onPressed});

  final int activeCount;
  final VoidCallback onPressed;

  @override
  State<_DiamondButton> createState() => _DiamondButtonState();
}

class _DiamondButtonState extends State<_DiamondButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 1, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    if (widget.activeCount == 0) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_DiamondButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeCount == oldWidget.activeCount) return;

    if (widget.activeCount == 0 && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (widget.activeCount > 0 && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.value = 0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.activeCount > 0;
    final colors = context.colors;

    final containerColor = isActive
        ? colors.primaryAction.withValues(alpha: 0.2)
        : colors.glassBackground;
    final borderColor = isActive ? colors.primaryAction : colors.glassBorder;
    final iconColor = isActive ? colors.primaryAction : colors.textSecondary;

    return Semantics(
      button: true,
      label: 'Open layers panel. ${widget.activeCount} layers active.',
      child: Tooltip(
        message: 'Layers',
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            final scale = widget.activeCount == 0 ? _pulseAnimation.value : 1.0;
            return Transform.scale(scale: scale, child: child);
          },
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: borderColor,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isActive
                          ? colors.primaryAction.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: math.pi / 4,
                      child: Icon(
                        Icons.diamond_outlined,
                        color: iconColor,
                        size: 20,
                      ),
                    ),
                    if (isActive)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: colors.primaryAction,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              widget.activeCount > 9
                                  ? '9+'
                                  : '${widget.activeCount}',
                              style: TextStyle(
                                color: colors.canvas,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
