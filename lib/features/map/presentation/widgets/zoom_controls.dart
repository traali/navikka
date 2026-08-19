import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';

class ZoomControls extends StatelessWidget {
  const ZoomControls({
    required this.onZoomIn,
    required this.onZoomOut,
    super.key,
  });
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControl(
          context,
          icon: Icons.add_rounded,
          onTap: onZoomIn,
          isTop: true,
        ),
        const SizedBox(
          height: 1,
        ), // Tiny gap using standard border color or just gap
        _buildControl(
          context,
          icon: Icons.remove_rounded,
          onTap: onZoomOut,
          isBottom: true,
        ),
      ],
    );
  }

  Widget _buildControl(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    bool isTop = false,
    bool isBottom = false,
  }) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: isTop ? const Radius.circular(12) : Radius.zero,
        bottom: isBottom ? const Radius.circular(12) : Radius.zero,
      ),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: colors.glassBackground,
          border: Border.all(color: colors.glassBorder),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: colors.primaryAction.withValues(alpha: 0.3),
            highlightColor: colors.primaryAction.withValues(alpha: 0.15),
            child: Icon(icon, color: colors.textPrimary),
          ),
        ),
      ),
    );
  }
}
