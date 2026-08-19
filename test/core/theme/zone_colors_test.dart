import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/theme/zone_colors.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';

void main() {
  group('ZoneColors', () {
    test('Returns RED for Mandatory Speed Limits (01)', () {
      final zone = SpeedLimitZone(
        id: '1',
        speedLimitKmh: 20, // Use non-10 value to hit typeCode '01' branch
        typeCode: '01',
        rings: [
          [
            const LatLng(0, 0),
            const LatLng(0, 1),
            const LatLng(1, 1),
            const LatLng(0, 0),
          ],
        ],
      );

      final color = ZoneColors.getZoneColor(zone);
      // AppPalette.zoneSpeedLimit = 0xFFDC2626 with alpha 0.3
      expect(color.r, closeTo(0.86, 0.02));
      expect(color.a, closeTo(0.3, 0.01));
    });

    test('Returns ORANGE for No Wake Zones (02)', () {
      final zone = SpeedLimitZone(
        id: '2',
        speedLimitKmh: 0,
        rings: [],
        typeCode: '02',
      );

      final color = ZoneColors.getZoneColor(zone);
      // AppPalette.zoneDefault = 0xFFF97316 (r=0.98, g=0.45, b=0.09)
      expect(color.r, closeTo(0.98, 0.02));
      expect(color.g, greaterThan(0));
      expect(color.a, closeTo(0.2, 0.01));
    });

    group('getRouteSegmentColor', () {
      test('returns cyan when no speed limit', () {
        expect(
          ZoneColors.getRouteSegmentColor(
            speedLimitKmh: null,
            isOverSpeed: false,
          ),
          AppTheme.kNeonCyan,
        );
        expect(
          ZoneColors.getRouteSegmentColor(speedLimitKmh: 0, isOverSpeed: false),
          AppTheme.kNeonCyan,
        );
      });

      test('returns orange when overspeed', () {
        expect(
          ZoneColors.getRouteSegmentColor(speedLimitKmh: 10, isOverSpeed: true),
          AppTheme.kNeonOrange,
        );
      });

      test('returns correct color for banded limits', () {
        expect(
          ZoneColors.getRouteSegmentColor(speedLimitKmh: 5, isOverSpeed: false),
          const Color(0xFFDC2626),
        );
        expect(
          ZoneColors.getRouteSegmentColor(
            speedLimitKmh: 10,
            isOverSpeed: false,
          ),
          const Color(0xFFEA580C),
        );
        expect(
          ZoneColors.getRouteSegmentColor(
            speedLimitKmh: 15,
            isOverSpeed: false,
          ),
          const Color(0xFFF59E0B),
        );
        expect(
          ZoneColors.getRouteSegmentColor(
            speedLimitKmh: 20,
            isOverSpeed: false,
          ),
          const Color(0xFF84CC16),
        );
        expect(
          ZoneColors.getRouteSegmentColor(
            speedLimitKmh: 30,
            isOverSpeed: false,
          ),
          const Color(0xFF22C55E),
        );
      });

      test('interpolates for intermediate values', () {
        final color7 = ZoneColors.getRouteSegmentColor(
          speedLimitKmh: 7,
          isOverSpeed: false,
        );
        expect(color7.r, greaterThan(0.8));
        expect(color7.g, lessThan(0.5));

        final color12 = ZoneColors.getRouteSegmentColor(
          speedLimitKmh: 12,
          isOverSpeed: false,
        );
        expect(color12.r, greaterThan(0.8));
        expect(color12.g, greaterThan(0.3));
      });
    });
  });
}
