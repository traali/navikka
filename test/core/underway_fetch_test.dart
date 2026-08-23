import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/constants/underway_fetch.dart';

void main() {
  group('shouldFetchAis', () {
    final t0 = DateTime.utc(2026, 8, 21, 13, 20);

    test('first sample always fetches', () {
      expect(shouldFetchAis(now: t0, lastAt: null, sogKn: 0), isTrue);
    });

    test('underway does not refetch inside 60 s (Friday 15 s bug)', () {
      expect(
        shouldFetchAis(
          now: t0.add(const Duration(seconds: 15)),
          lastAt: t0,
          sogKn: 18,
        ),
        isFalse,
      );
      expect(
        shouldFetchAis(
          now: t0.add(const Duration(seconds: 59)),
          lastAt: t0,
          sogKn: 18,
        ),
        isFalse,
      );
      expect(
        shouldFetchAis(
          now: t0.add(const Duration(seconds: 60)),
          lastAt: t0,
          sogKn: 18,
        ),
        isTrue,
      );
    });

    test('idle boat waits 180 s', () {
      expect(
        shouldFetchAis(
          now: t0.add(const Duration(seconds: 60)),
          lastAt: t0,
          sogKn: 0.2,
        ),
        isFalse,
      );
      expect(
        shouldFetchAis(
          now: t0.add(const Duration(seconds: 180)),
          lastAt: t0,
          sogKn: 0.2,
        ),
        isTrue,
      );
    });

    test('hidden tab and inflight skip', () {
      expect(
        shouldFetchAis(
          now: t0.add(const Duration(minutes: 5)),
          lastAt: t0,
          sogKn: 18,
          hidden: true,
        ),
        isFalse,
      );
      expect(
        shouldFetchAis(
          now: t0.add(const Duration(minutes: 5)),
          lastAt: t0,
          sogKn: 18,
          inflight: true,
        ),
        isFalse,
      );
    });
  });

  group('isBatteryTooLowForAi', () {
    test('iOS Chrome reporting 0 does not disable Skipper AI', () {
      expect(isBatteryTooLowForAi(0), isFalse);
      expect(isBatteryTooLowForAi(null), isFalse);
      expect(isBatteryTooLowForAi(-1), isFalse);
      expect(isBatteryTooLowForAi(101), isFalse);
    });

    test('real 1-19% disables, 20%+ does not', () {
      expect(isBatteryTooLowForAi(1), isTrue);
      expect(isBatteryTooLowForAi(19), isTrue);
      expect(isBatteryTooLowForAi(20), isFalse);
      expect(isBatteryTooLowForAi(52), isFalse);
    });
  });

  group('formatStationDistance', () {
    test('GPS jitter around 480 m stays on the 500 m bucket', () {
      expect(formatStationDistance(455), '500 m');
      expect(formatStationDistance(502), '500 m');
      expect(formatStationDistance(517), '500 m');
      expect(formatStationDistance(469), '500 m');
    });

    test('real move to 2 km uses 0.1 km steps', () {
      expect(formatStationDistance(2100), '2.1 km');
      expect(formatStationDistance(2300), '2.3 km');
    });

    test('title includes station name', () {
      expect(
        formatStationWithDistance(stationName: null, meters: 502),
        'Havaintoasema (500 m)',
      );
    });
  });

  group('sanitizeNetworkError', () {
    test('strips DioException / XMLHttpRequest from skipper HUD', () {
      const raw =
          'DioException [connection error]: The connection errored: '
          'The XMLHttpRequest onError callback was called.';
      final clean = sanitizeNetworkError(raw);
      expect(clean.contains('DioException'), isFalse);
      expect(clean.contains('XMLHttpRequest'), isFalse);
      expect(clean, contains('yhteyskatkos'));
    });
  });
}
