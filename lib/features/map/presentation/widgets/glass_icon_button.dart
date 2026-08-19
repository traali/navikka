import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';

/// A premium glass-styled icon button.
/// Automatically expands to 64x64dp when Rough Sea / Glove Mode is active.
class GlassIconButton extends ConsumerWidget {
  const GlassIconButton({
    required this.onPressed,
    super.key,
    this.icon,
    this.iconWidget,
    this.onLongPress,
    this.tooltip,
    this.iconColor,
    this.activeColor,
    this.size = 56.0,
    this.iconSize,
  }) : assert(
         icon != null || iconWidget != null,
         'Either icon or iconWidget must be provided',
       );
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final String? tooltip;
  final Color? iconColor;
  final Color? activeColor;
  final double size;
  final double? iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final isRoughSea = ref.watch(roughSeaModeControllerProvider);
    final double effectiveSize = isRoughSea ? math.max(size, 64) : size;

    final borderRadius = BorderRadius.circular(isRoughSea ? 20 : 16);

    final finalBgColor = activeColor != null
        ? activeColor!.withValues(alpha: 0.2)
        : colors.glassBackground;

    final finalBorderColor = activeColor ?? colors.glassBorder;

    final finalIconColor =
        iconColor ?? (activeColor != null ? activeColor! : colors.textPrimary);

    final content = Center(
      child:
          iconWidget ??
          Icon(
            icon,
            color: finalIconColor,
            size: iconSize ?? (effectiveSize * 0.5),
          ),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: effectiveSize,
        height: effectiveSize,
        decoration: BoxDecoration(
          color: finalBgColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: finalBorderColor,
            width: activeColor != null ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              SafeHaptics.light();
              onPressed();
            },
            onLongPress: onLongPress != null
                ? () {
                    SafeHaptics.medium();
                    onLongPress!();
                  }
                : null,
            borderRadius: borderRadius,
            splashColor: colors.primaryAction.withValues(alpha: 0.3),
            highlightColor: colors.primaryAction.withValues(alpha: 0.15),
            child: tooltip != null
                ? Tooltip(message: tooltip, child: content)
                : content,
          ),
        ),
      ),
    );
  }
}
