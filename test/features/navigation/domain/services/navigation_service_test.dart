import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/navigation/domain/services/navigation_service.dart';

void main() {
  group('NavigationService', () {
    group('calculateBearing', () {
      test('North: bearing should be 0 degrees', () {
        final from = const LatLng(0, 0);
        final to = const LatLng(10, 0);
        final bearing = NavigationService.calculateBearing(from, to);
        expect(bearing, closeTo(0, 0.1));
      });

      test('East: bearing should be 90 degrees', () {
        final from = const LatLng(0, 0);
        final to = const LatLng(0, 10);
        final bearing = NavigationService.calculateBearing(from, to);
        expect(bearing, closeTo(90, 0.1));
      });

      test('South: bearing should be 180 degrees', () {
        final from = const LatLng(10, 0);
        final to = const LatLng(0, 0);
        final bearing = NavigationService.calculateBearing(from, to);
        expect(bearing, closeTo(180, 0.1));
      });

      test('West: bearing should be 270 degrees', () {
        final from = const LatLng(0, 10);
        final to = const LatLng(0, 0);
        final bearing = NavigationService.calculateBearing(from, to);
        expect(bearing, closeTo(270, 0.1));
      });

      test('Helsinki to Tallinn: approximate bearing', () {
        final from = const LatLng(60.1699, 24.9384); // Helsinki
        final to = const LatLng(59.4370, 24.7536); // Tallinn
        final bearing = NavigationService.calculateBearing(from, to);
        // Should be roughly south-southwest
        expect(bearing, greaterThan(170));
        expect(bearing, lessThan(210));
      });
    });

    group('calculateDistance', () {
      test('Same point: distance should be 0', () {
        final from = const LatLng(60.0, 25.0);
        final to = const LatLng(60.0, 25.0);
        final distance = NavigationService.calculateDistance(from, to);
        expect(distance, closeTo(0, 1));
      });

      test('Helsinki to Tallinn: approximately 80km', () {
        final from = const LatLng(60.1699, 24.9384); // Helsinki
        final to = const LatLng(59.4370, 24.7536); // Tallinn
        final distance = NavigationService.calculateDistance(from, to);
        // ~80km = 80000m
        expect(distance, greaterThan(75000));
        expect(distance, lessThan(85000));
      });
    });

    group('calculateCrossTrackError', () {
      test('Point on path: XTE should be ~0', () {
        final start = const LatLng(60.0, 25.0);
        final end = const LatLng(60.0, 26.0);
        final point = const LatLng(60.0, 25.5); // Exactly on the path
        final xte = NavigationService.calculateCrossTrackError(
          start,
          end,
          point,
        );
        // Geodesic calculations have some numerical error
        expect(
          xte.abs(),
          lessThan(200),
        ); // Within 200m for geodesic approximation
      });

      test('Point right of path: XTE should be positive', () {
        final start = const LatLng(60.0, 25.0);
        final end = const LatLng(60.0, 26.0);
        final point = const LatLng(
          59.99,
          25.5,
        ); // South (right when facing east) of eastward path
        final xte = NavigationService.calculateCrossTrackError(
          start,
          end,
          point,
        );
        expect(xte, greaterThan(0));
      });

      test('Point left of path: XTE should be negative', () {
        final start = const LatLng(60.0, 25.0);
        final end = const LatLng(60.0, 26.0);
        final point = const LatLng(
          60.01,
          25.5,
        ); // North (left when facing east) of eastward path
        final xte = NavigationService.calculateCrossTrackError(
          start,
          end,
          point,
        );
        expect(xte, lessThan(0));
      });
    });

    group('calculateETA', () {
      test('Zero speed: should return null', () {
        final eta = NavigationService.calculateETA(
          distanceMeters: 1000,
          speedKmh: 0,
        );
        expect(eta, isNull);
      });

      test('10km at 10km/h: should be 1 hour from now', () {
        final now = DateTime(2026, 5, 17, 12, 0);
        final eta = NavigationService.calculateETA(
          distanceMeters: 10000,
          speedKmh: 10,
          fromTime: now,
        );
        expect(eta, isNotNull);
        expect(eta!.hour, 13);
        expect(eta.minute, 0);
      });
    });

    group('isWithinArrivalDistance', () {
      test('Within threshold: should return true', () {
        final current = const LatLng(60.0, 25.0);
        final target = const LatLng(60.0001, 25.0); // ~11m away
        final result = NavigationService.isWithinArrivalDistance(
          current: current,
          target: target,
          thresholdMeters: 50,
        );
        expect(result, isTrue);
      });

      test('Outside threshold: should return false', () {
        final current = const LatLng(60.0, 25.0);
        final target = const LatLng(60.01, 25.0); // ~1.1km away
        final result = NavigationService.isWithinArrivalDistance(
          current: current,
          target: target,
          thresholdMeters: 50,
        );
        expect(result, isFalse);
      });
    });

    group('isPassedWaypoint', () {
      test('Passed waypoint beyond target along leg: should return true', () {
        final previous = const LatLng(60.0, 25.0);
        final target = const LatLng(60.01, 25.0);
        final current = const LatLng(
          60.0105,
          25.0005,
        ); // Passed waypoint 60 m beyond target

        final result = NavigationService.isPassedWaypoint(
          current: current,
          target: target,
          previous: previous,
          arrivalThresholdMeters: 50,
        );
        expect(result, isTrue);
      });

      test('Behind target along leg: should return false', () {
        final previous = const LatLng(60.0, 25.0);
        final target = const LatLng(60.01, 25.0);
        final current = const LatLng(60.005, 25.0); // Halfway to target

        final result = NavigationService.isPassedWaypoint(
          current: current,
          target: target,
          previous: previous,
          arrivalThresholdMeters: 50,
        );
        expect(result, isFalse);
      });
    });

    group('calculateProgressFraction', () {
      test('At start: progress should be ~0', () {
        final waypoints = const [
          LatLng(60.0, 25.0),
          LatLng(60.0, 26.0),
          LatLng(60.0, 27.0),
        ];
        final position = const LatLng(60.0, 25.0);
        final progress = NavigationService.calculateProgressFraction(
          waypoints: waypoints,
          currentPosition: position,
        );
        expect(progress, closeTo(0, 0.01));
      });

      test('At midpoint: progress should be ~0.5', () {
        final waypoints = const [
          LatLng(60.0, 25.0),
          LatLng(60.0, 26.0),
          LatLng(60.0, 27.0),
        ];
        final position = const LatLng(60.0, 26.0);
        final progress = NavigationService.calculateProgressFraction(
          waypoints: waypoints,
          currentPosition: position,
        );
        expect(progress, closeTo(0.5, 0.01));
      });

      test('At end: progress should be ~1.0', () {
        final waypoints = const [
          LatLng(60.0, 25.0),
          LatLng(60.0, 26.0),
          LatLng(60.0, 27.0),
        ];
        final position = const LatLng(60.0, 27.0);
        final progress = NavigationService.calculateProgressFraction(
          waypoints: waypoints,
          currentPosition: position,
        );
        expect(progress, closeTo(1.0, 0.01));
      });
    });

    group('closestPointOnSegment', () {
      test('Point on segment: should return the point', () {
        final start = const LatLng(60.0, 25.0);
        final end = const LatLng(60.0, 26.0);
        final point = const LatLng(60.0, 25.5);
        final closest = NavigationService.closestPointOnSegment(
          start,
          end,
          point,
        );
        expect(closest.latitude, closeTo(60.0, 0.001));
        expect(closest.longitude, closeTo(25.5, 0.001));
      });

      test('Point before start: should return start', () {
        final start = const LatLng(60.0, 25.0);
        final end = const LatLng(60.0, 26.0);
        final point = const LatLng(60.0, 24.0);
        final closest = NavigationService.closestPointOnSegment(
          start,
          end,
          point,
        );
        expect(closest.latitude, closeTo(60.0, 0.001));
        expect(closest.longitude, closeTo(25.0, 0.001));
      });

      test('Point after end: should return end', () {
        final start = const LatLng(60.0, 25.0);
        final end = const LatLng(60.0, 26.0);
        final point = const LatLng(60.0, 27.0);
        final closest = NavigationService.closestPointOnSegment(
          start,
          end,
          point,
        );
        expect(closest.latitude, closeTo(60.0, 0.001));
        expect(closest.longitude, closeTo(26.0, 0.001));
      });
    });
  });
}
