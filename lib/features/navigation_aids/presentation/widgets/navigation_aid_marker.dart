import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid_type.dart';
import 'package:sakkoja/features/navigation_aids/presentation/mappers/official_sign_mapper.dart';

/// Individual navigation aid marker with animations.
class NavigationAidMarker extends StatelessWidget {
  const NavigationAidMarker({required this.aid, super.key});
  final NavigationAid aid;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 300)),
        ScaleEffect(
          begin: Offset(0.8, 0.8),
          end: Offset(1, 1),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
        ),
      ],
      child: _buildMarkerIcon(),
    );
  }

  Widget _buildMarkerIcon() {
    switch (aid.type) {
      case NavigationAidType.lighthouse:
        return _LighthouseMarker(aid: aid);

      case NavigationAidType.trafficSign:
        final assetPath = OfficialSignMapper.getAssetPath(aid.signTypeCode);
        if (assetPath == null) return const SizedBox.shrink();
        return _OfficialSignMarker(aid: aid, assetPath: assetPath);

      case NavigationAidType.safetyEquipment:
        return _SafetyEquipmentMarker(aid: aid);
    }
  }
}

/// Lighthouse marker with static yellow light effect and optional sector indicators.
class _LighthouseMarker extends StatelessWidget {
  const _LighthouseMarker({required this.aid});
  final NavigationAid aid;

  @override
  Widget build(BuildContext context) {
    final chars = (aid.lightCharacteristics ?? aid.name ?? '').toUpperCase();
    final hasRed = chars.contains('R');
    final hasGreen = chars.contains('G');

    return Stack(
      alignment: Alignment.center,
      children: [
        // Subtle yellow light background glow
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber.withValues(alpha: 0.15),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.35),
            ),
          ),
        ),
        // Lighthouse SVG Icon
        SvgPicture.asset(
          'assets/icons/nautical/lighthouse.svg',
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            AppPalette.warning,
            BlendMode.srcIn,
          ),
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Icon(Icons.wb_sunny, size: 10, color: Colors.black),
            );
          },
        ),
        // Sector marker on top of the lighthouse
        if (hasRed || hasGreen)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: _buildTopMarker(hasRed, hasGreen),
            ),
          ),
      ],
    );
  }

  Widget _buildTopMarker(bool hasRed, bool hasGreen) {
    if (hasRed && hasGreen) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
              border: Border.all(color: Colors.white, width: 0.8),
            ),
          ),
          const SizedBox(width: 1.5),
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
              border: Border.all(color: Colors.white, width: 0.8),
            ),
          ),
        ],
      );
    } else if (hasRed) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.4),
              blurRadius: 2,
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.4),
              blurRadius: 2,
            ),
          ],
        ),
      );
    }
  }
}

/// Safety equipment marker (beacon/buoy) with IALA-A implementation.
class _SafetyEquipmentMarker extends StatelessWidget {
  const _SafetyEquipmentMarker({required this.aid});
  final NavigationAid aid;

  @override
  Widget build(BuildContext context) {
    final assetPath = _IALAAMapper.getAssetPath(aid.ialaCode);
    const size = 24.0;

    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) {
          // Robust fallback marker if SVG fails to load
          final color = _getFallbackColor(aid.ialaCode);
          return Center(
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Color _getFallbackColor(String? code) {
    switch (code) {
      case '1' || '01':
        return Colors.red;
      case '2' || '02':
        return Colors.green;
      case '3' || '03' || '4' || '04' || '5' || '05' || '6' || '06':
        return Colors.yellow;
      case '7' || '07':
        return Colors.black;
      case '8' || '08':
        return Colors.redAccent;
      default:
        return Colors.amber;
    }
  }
}

/// Helper to map Väylävirasto codes to IALA-A assets.
class _IALAAMapper {
  static String getAssetPath(String? ialaCode) {
    const basePath = 'assets/icons/nautical/iala_a/';

    switch (ialaCode) {
      case '1' || '01':
        return '${basePath}port.svg';
      case '2' || '02':
        return '${basePath}starboard.svg';
      case '3' || '03':
        return '${basePath}cardinal_north.svg';
      case '4' || '04':
        return '${basePath}cardinal_south.svg';
      case '5' || '05':
        return '${basePath}cardinal_east.svg';
      case '6' || '06':
        return '${basePath}cardinal_west.svg';
      case '7' || '07':
        return '${basePath}isolated_danger.svg';
      case '8' || '08':
        return '${basePath}safe_water.svg';
      case '9' || '09' || '99':
        return '${basePath}special_mark.svg';
      default:
        return '${basePath}special_mark.svg';
    }
  }
}

/// Renders an official Väylävirasto SVG sign with optional text value.
class _OfficialSignMarker extends StatelessWidget {
  const _OfficialSignMarker({
    required this.aid,
    required this.assetPath,
  });
  final NavigationAid aid;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    const size = 24.0;
    const fontSize = 8.5;

    final displayValue = OfficialSignMapper.getDisplayValue(
      aid.signTypeCode,
      aid.restrictionValue?.toInt().toString(),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          assetPath,
          width: size,
          height: size,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            );
          },
        ),
        if (displayValue != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              displayValue,
              style: const TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                fontFamily: 'JetBrains Mono',
              ),
            ),
          ),
      ],
    );
  }
}
