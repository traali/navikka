import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/map/domain/services/motion_estimator.dart';

void main() {
  group('MotionEstimator', () {
    test('derives speed and course from timed movement', () {
      final estimator = MotionEstimator();
      final timestamp = DateTime.utc(2026, 1, 1, 12);

      estimator.update(
        location: const LatLng(60, 24),
        timestamp: timestamp,
        accuracyMeters: 2,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );
      final estimate = estimator.update(
        location: const LatLng(60.0001, 24),
        timestamp: timestamp.add(const Duration(seconds: 2)),
        accuracyMeters: 2,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );

      expect(estimate.speedKmh, greaterThan(10));
      expect(estimate.heading, closeTo(0, 1));
    });

    test('derives course when speed is present but heading is unavailable', () {
      final estimator = MotionEstimator();
      final timestamp = DateTime.utc(2026, 1, 1, 12);

      estimator.update(
        location: const LatLng(60, 24),
        timestamp: timestamp,
        accuracyMeters: 2,
        reportedSpeedMps: 5,
        reportedHeading: 0,
      );
      final estimate = estimator.update(
        location: const LatLng(60, 24.0001),
        timestamp: timestamp.add(const Duration(seconds: 2)),
        accuracyMeters: 2,
        reportedSpeedMps: 5,
        reportedHeading: 0,
      );

      expect(estimate.speedKmh, 18);
      expect(estimate.heading, closeTo(90, 1));
    });

    test('suppresses stationary movement within the accuracy threshold', () {
      final estimator = MotionEstimator();
      final timestamp = DateTime.utc(2026, 1, 1, 12);

      estimator.update(
        location: const LatLng(60, 24),
        timestamp: timestamp,
        accuracyMeters: 5,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );
      final estimate = estimator.update(
        location: const LatLng(60.00001, 24),
        timestamp: timestamp.add(const Duration(seconds: 1)),
        accuracyMeters: 5,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );

      expect(estimate.speedKmh, 0);
      expect(estimate.heading, 0);
    });

    test('keeps valid browser speed and course', () {
      final estimator = MotionEstimator();

      final estimate = estimator.update(
        location: const LatLng(60, 24),
        timestamp: DateTime.utc(2026, 1, 1, 12),
        accuracyMeters: 2,
        reportedSpeedMps: 5,
        reportedHeading: 270,
      );

      expect(estimate.speedKmh, 18);
      expect(estimate.heading, 270);
    });

    test('rejects an implausible coordinate jump and recovers', () {
      final estimator = MotionEstimator(maximumDerivedSpeedKmh: 60);
      final timestamp = DateTime.utc(2026, 1, 1, 12);

      estimator.update(
        location: const LatLng(60, 24),
        timestamp: timestamp,
        accuracyMeters: 2,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );
      final rejected = estimator.update(
        location: const LatLng(60.01, 24),
        timestamp: timestamp.add(const Duration(seconds: 1)),
        accuracyMeters: 2,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );

      expect(rejected.speedKmh, 0);

      estimator.update(
        location: const LatLng(60, 24),
        timestamp: timestamp.add(const Duration(seconds: 2)),
        accuracyMeters: 2,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );
      final recovered = estimator.update(
        location: const LatLng(60.0001, 24),
        timestamp: timestamp.add(const Duration(seconds: 4)),
        accuracyMeters: 2,
        reportedSpeedMps: 0,
        reportedHeading: 0,
      );

      expect(recovered.speedKmh, greaterThan(10));
      expect(recovered.speedKmh, lessThan(60));
      expect(recovered.heading, closeTo(0, 1));
    });

    test('does not cap reported browser speed', () {
      final estimator = MotionEstimator(maximumDerivedSpeedKmh: 10);

      final estimate = estimator.update(
        location: const LatLng(60, 24),
        timestamp: DateTime.utc(2026, 1, 1, 12),
        accuracyMeters: 2,
        reportedSpeedMps: 50,
        reportedHeading: 45,
      );

      expect(estimate.speedKmh, 180);
      expect(estimate.heading, 45);
    });
  });
}
