import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';

/// A premium glass-styled container with consistent visual properties.
///
/// Encapsulates blur, border, gradient, and standard decoration to ensure
/// adherence to the "Night Captain" design system.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.useGradient = true,
  });

  /// The child widget.
  final Widget? child;

  /// Custom width.
  final double? width;

  /// Custom height.
  final double? height;

  /// Custom padding. Default is [padding].
  final EdgeInsetsGeometry? padding;

  /// Custom margin.
  final EdgeInsetsGeometry? margin;

  /// Border radius. Defaults to [AppTheme.kBorderRadius].
  final BorderRadiusGeometry? borderRadius;

  /// Background color override. Defaults to [AppTheme.kSurfaceColor] (semi-transparent).
  final Color? color;

  /// Border color override. Defaults to [AppTheme.kBorderColor].
  final Color? borderColor;

  /// Whether to use the standard technical gradient. Defaults to true.
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppTheme.kBorderRadius;
    final themeColors = context.colors;

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color:
            color ??
            themeColors.glassBackground.withValues(alpha: kIsWeb ? 0.95 : 0.9),
        borderRadius: effectiveBorderRadius,
        border: Border.all(color: borderColor ?? themeColors.glassBorder),
        gradient: useGradient
            ? (context.isDarkMode
                  ? AppTheme.kSurfaceGradient
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        themeColors.surfaceHighlight,
                        themeColors.surface,
                      ],
                    ))
            : null,
        boxShadow: AppTheme.kElevationShadows,
      ),
      child: child,
    );

    // PERFORMANCE OPTIMIZATION: BackdropFilter is expensive on Web/CanvasKit.
    // We bypass it on Web to maintain 60 FPS, using a slightly more opaque color instead.
    if (kIsWeb) {
      return Container(
        width: width,
        height: height,
        margin: margin,
        child: ClipRRect(borderRadius: effectiveBorderRadius, child: content),
      );
    }

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppTheme.kBlurSigma,
            sigmaY: AppTheme.kBlurSigma,
          ),
          child: content,
        ),
      ),
    );
  }
}
