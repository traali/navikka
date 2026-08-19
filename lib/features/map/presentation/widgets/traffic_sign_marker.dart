import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart';

/// Renders official Finnish nautical traffic signs using SVG assets.
class TrafficSignMarker extends StatelessWidget {
  const TrafficSignMarker({required this.sign, super.key, this.size = 44.0});
  final TrafficSign sign;
  final double size;

  @override
  Widget build(BuildContext context) {
    final typeName = sign.typeName.toLowerCase();

    // 1. Dynamic Value Signs (Limits/Restrictions)
    if (sign.value != null) {
      String frameAsset;

      if (typeName.contains('korkeus') || typeName.contains('height')) {
        frameAsset =
            'assets/icons/nautical/official/restriction_height_frame.svg';
      } else if (typeName.contains('syvyys') || typeName.contains('depth')) {
        frameAsset =
            'assets/icons/nautical/official/restriction_depth_frame.svg';
      } else if (typeName.contains('leveys') || typeName.contains('width')) {
        frameAsset =
            'assets/icons/nautical/official/restriction_width_frame.svg';
      } else {
        // Default to Speed Limit for numerical values if no other type matches
        frameAsset = 'assets/icons/nautical/official/limit_speed_frame.svg';
      }

      return _DynamicValueSign(
        assetPath: frameAsset,
        value: sign.value!,
        size: size,
      );
    }

    // 2. Static Icon Signs (Prohibitions, Warnings, Mandates)
    String? assetPath;

    if (typeName.contains('aallokon') || typeName.contains('wake')) {
      assetPath = 'assets/icons/nautical/official/prohibition_no_waves.svg';
    } else if (typeName.contains('moottorivoima') ||
        typeName.contains('motor')) {
      assetPath = 'assets/icons/nautical/official/prohibition_motorboat.svg';
    } else if (typeName.contains('ankkur') || typeName.contains('anchor')) {
      assetPath = 'assets/icons/nautical/official/prohibition_anchoring.svg';
    } else if (typeName.contains('kiinnittyminen') ||
        typeName.contains('dock') ||
        typeName.contains('mooring')) {
      assetPath = 'assets/icons/nautical/official/prohibition_docking.svg';
    } else if (typeName.contains('ohittamiskielto') ||
        typeName.contains('overtak')) {
      assetPath = 'assets/icons/nautical/official/prohibition_overtaking.svg';
    } else if (typeName.contains('kohtaaminen') ||
        typeName.contains('meeting')) {
      assetPath = 'assets/icons/nautical/official/prohibition_meeting.svg';
    } else if (typeName.contains('vesiskootteri') ||
        typeName.contains('jet ski')) {
      assetPath = 'assets/icons/nautical/official/prohibition_jetski.svg';
    } else if (typeName.contains('vesihiihto') ||
        typeName.contains('water ski')) {
      assetPath = 'assets/icons/nautical/official/prohibition_waterski.svg';
    } else if (typeName.contains('puhelin') || typeName.contains('radio')) {
      assetPath = 'assets/icons/nautical/official/info_phone.svg';
    } else if (typeName.contains('varoitus') || typeName.contains('warning')) {
      assetPath = 'assets/icons/nautical/official/warning_general.svg';
    }

    if (assetPath != null) {
      return SvgPicture.asset(assetPath, width: size, height: size);
    }

    // 3. Fallback for unknown signs
    return _UnknownMarker(text: sign.text, size: size);
  }
}

/// Renders a sign frame with a centered dynamic value.
class _DynamicValueSign extends StatelessWidget {
  const _DynamicValueSign({
    required this.assetPath,
    required this.value,
    required this.size,
  });
  final String assetPath;
  final double value;
  final double size;

  @override
  Widget build(BuildContext context) {
    // Format value: display int for whole numbers, decimal for others.
    final text = value % 1 == 0 ? value.toInt().toString() : value.toString();

    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(assetPath, width: size, height: size),
        // Adjust text size relative to marker size
        Padding(
          padding: EdgeInsets.only(
            top: size * 0.1,
          ), // Slight offset often looks better for these signs
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: size * 0.35, // Approx 35% of container size
              fontWeight: FontWeight.bold,
              fontFamily: 'Arial', // Match official style
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}

/// Fallback marker for unknown types
class _UnknownMarker extends StatelessWidget {
  const _UnknownMarker({required this.text, required this.size});
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppPalette.textPrimary,
        border: Border.all(color: AppPalette.textSecondary),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Icon(
          Icons.help_outline,
          size: size * 0.6,
          color: AppPalette.textSecondary,
        ),
      ),
    );
  }
}
