import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';

class SpeedHudWidget extends ConsumerStatefulWidget {
  const SpeedHudWidget({
    required this.hasLocation,
    required this.currentSpeedKmh,
    required this.speedLimitKmh,
    this.onRequestGps,
    super.key,
  });
  final bool hasLocation;
  final double currentSpeedKmh;
  final int speedLimitKmh;
  final VoidCallback? onRequestGps;

  @override
  ConsumerState<SpeedHudWidget> createState() => _SpeedHudWidgetState();
}

class _SpeedHudWidgetState extends ConsumerState<SpeedHudWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _wasSpeeding = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _pulseAnimation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateAnimation());
  }

  @override
  void didUpdateWidget(SpeedHudWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isSpeeding =
        widget.speedLimitKmh > 0 &&
        widget.currentSpeedKmh > widget.speedLimitKmh;

    if (isSpeeding && !_wasSpeeding) {
      SafeHaptics.heavy();
    }
    _wasSpeeding = isSpeeding;

    _updateAnimation();
  }

  void _updateAnimation() {
    if (!mounted) return;
    final isSpeeding =
        widget.speedLimitKmh > 0 &&
        widget.currentSpeedKmh > widget.speedLimitKmh;
    if (!widget.hasLocation || !isSpeeding) {
      _pulseController.stop();
      _pulseController.value = 0;
    } else if (!_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.hasLocation) {
      return _buildNoGpsState();
    }

    final layout = ref.watch(uiLayoutControllerProvider);
    final isSpeeding =
        widget.speedLimitKmh > 0 &&
        widget.currentSpeedKmh > widget.speedLimitKmh;

    final isFishingMode = ref.watch(
      fishingModeControllerProvider.select((s) => s.value?.isEnabled ?? false),
    );

    Widget content;
    switch (layout) {
      case UiLayout.ghost:
      case UiLayout.vortex:
      case UiLayout.horizon3D:
        content = _GhostSpeedHud(
          currentSpeed: widget.currentSpeedKmh,
          speedLimit: widget.speedLimitKmh,
          isSpeeding: isSpeeding,
          isFishingMode: isFishingMode,
          pulseAnimation: _pulseAnimation,
        );
      case UiLayout.classic:
      case UiLayout.commandBar:
      case UiLayout.omni:
        content = _ClassicSpeedHud(
          currentSpeed: widget.currentSpeedKmh,
          speedLimit: widget.speedLimitKmh,
          isSpeeding: isSpeeding,
          isFishingMode: isFishingMode,
          pulseAnimation: _pulseAnimation,
        );
    }

    return content;
  }

  Widget _buildNoGpsState() {
    final colors = context.colors;
    return GestureDetector(
      onTap: widget.onRequestGps,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colors.glassBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.warning.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_disabled,
              color: colors.warning,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              widget.onRequestGps != null
                  ? 'Napauta salliaaksesi GPS'
                  : 'GPS pois',
              style: TextStyle(
                color: colors.warning,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GhostSpeedHud extends StatelessWidget {
  const _GhostSpeedHud({
    required this.currentSpeed,
    required this.speedLimit,
    required this.isSpeeding,
    required this.isFishingMode,
    required this.pulseAnimation,
  });

  final double currentSpeed;
  final int speedLimit;
  final bool isSpeeding;
  final bool isFishingMode;
  final Animation<double> pulseAnimation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedOpacity(
      opacity: isFishingMode ? 0.3 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Stack(
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.none,
        children: [
          // Subtle Legibility Vignette
          Positioned(
            left: -20,
            top: -10,
            child: Container(
              width: 160,
              height: 80,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    (context.isDarkMode ? Colors.black : Colors.white)
                        .withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                  center: const Alignment(-0.5, 0),
                  radius: 0.8,
                ),
              ),
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // Current Speed
              AnimatedBuilder(
                animation: pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isSpeeding ? pulseAnimation.value : 1.0,
                    child: Text(
                      currentSpeed.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: isSpeeding ? colors.danger : colors.textPrimary,
                        shadows: context.isDarkMode
                            ? [
                                const Shadow(
                                  blurRadius: 4,
                                  color: Colors.black87,
                                ),
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withValues(alpha: 0.54),
                                ),
                              ]
                            : [
                                const Shadow(
                                  blurRadius: 2,
                                  color: Colors.white70,
                                ),
                              ],
                      ),
                    ),
                  );
                },
              ),
              Text(
                'km/h',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colors.textSecondary.withValues(alpha: 0.38),
                  shadows: context.isDarkMode
                      ? const [Shadow(blurRadius: 4)]
                      : null,
                ),
              ),

              if (speedLimit > 0) ...[
                const SizedBox(width: 16),
                // Circular Speed Limit "Sign"
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: colors.textPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.danger, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '$speedLimit',
                      style: TextStyle(
                        color: colors.danger,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ClassicSpeedHud extends StatelessWidget {
  const _ClassicSpeedHud({
    required this.currentSpeed,
    required this.speedLimit,
    required this.isSpeeding,
    required this.pulseAnimation,
    this.isFishingMode = false,
  });

  final double currentSpeed;
  final int speedLimit;
  final bool isSpeeding;
  final bool isFishingMode;
  final Animation<double> pulseAnimation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedOpacity(
      opacity: isFishingMode ? 0.3 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: AnimatedBuilder(
        animation: pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isSpeeding ? pulseAnimation.value : 1.0,
            child: child,
          );
        },
        child: _GlassContainer(
          isSpeeding: isSpeeding,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/nautical/speed_meter.svg',
                      colorFilter: ColorFilter.mode(
                        isSpeeding
                            ? colors.danger
                            : colors.textPrimary.withValues(alpha: 0.7),
                        BlendMode.srcIn,
                      ),
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'NOPEUS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: isSpeeding ? colors.danger : colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (currentSpeed * 0.539957).toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: isSpeeding ? colors.danger : colors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'kn',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSpeeding ? colors.danger : colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${currentSpeed.toStringAsFixed(1)} km/h',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: colors.textSecondary.withValues(alpha: 0.8),
                  ),
                ),
                if (speedLimit > 0) ...[
                  const SizedBox(height: 6),
                  Container(height: 1, color: colors.glassBorder),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'RAJOITUS: ',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: colors.textSecondary,
                        ),
                      ),
                      Text(
                        '$speedLimit km/h',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: isSpeeding ? colors.danger : colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassContainer extends StatelessWidget {
  const _GlassContainer({
    required this.child,
    this.isSpeeding = false,
  });
  final Widget child;
  final bool isSpeeding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final borderRadius = BorderRadius.circular(16);

    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSpeeding
                  ? colors.danger.withValues(alpha: 0.25)
                  : colors.glassBackground,
              borderRadius: borderRadius,
              border: Border.all(
                color: isSpeeding ? colors.danger : colors.glassBorder,
                width: isSpeeding ? 2.0 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSpeeding
                      ? colors.danger.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
