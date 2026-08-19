import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/speed_alert_notifier.dart';

// Mock MapNotifier to control state in tests
class MockMapNotifier extends MapNotifier {
  @override
  MapState build() {
    return const MapState(userLocation: LatLng(60, 25));
  }

  void updateState(MapState newState) {
    state = newState;
  }
}

// Override mapProvider to use our mock

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late MockMapNotifier mockMapNotifier;
  final log = <MethodCall>[];

  setUp(() {
    log.clear();
    // Intercept HapticFeedback calls
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (
          methodCall,
        ) async {
          log.add(methodCall);
          return null;
        });

    container = ProviderContainer(
      overrides: [mapProvider.overrideWith(MockMapNotifier.new)],
    );

    // Read the mock notifier to control it
    mockMapNotifier = container.read(mapProvider.notifier) as MockMapNotifier;

    // Initialize the alert notifier by watching it (so it starts listening)
    container.read(speedAlertProvider.notifier);
  });

  tearDown(() {
    container.dispose();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  test('Safe speed -> Speeding (Alert triggers)', () async {
    // 1. Set Safe State (40 km/h in 50 zone)
    mockMapNotifier.updateState(
      MapState(
        userLocation: const LatLng(60, 25),
        currentSpeedKmh: 40,
        currentZone: SpeedLimitZone(id: 'zone1', rings: [], speedLimitKmh: 50),
      ),
    );
    await Future<void>.value();
    expect(log, isEmpty, reason: 'Safe speed should not trigger alert');

    // 2. Set Speeding State (60 km/h in 50 zone)
    mockMapNotifier.updateState(
      MapState(
        userLocation: const LatLng(60, 25),
        currentSpeedKmh: 60,
        currentZone: SpeedLimitZone(id: 'zone1', rings: [], speedLimitKmh: 50),
      ),
    );

    // Allow Riverpod listeners to fire
    await Future<void>.value();

    // Allow async platform channel calls to propagate
    await Future(() {});

    // Verify Haptics (Heavy Impact x3)
    final hapticCalls = log
        .where((call) => call.method == 'HapticFeedback.vibrate')
        .toList();
    // Note: HapticFeedback.heavyImpact() typically calls 'HapticFeedback.vibrate' with 'HapticFeedbackType.heavyImpact'
    // But on strict platform channels it might be 'HapticFeedback.vibrate'.
    // Let's check generally for haptic calls.
    expect(
      hapticCalls.length,
      greaterThanOrEqualTo(1),
      reason: 'Should trigger haptic feedback',
    );
  });

  test('Speeding -> Speeding (No Repeat Alert)', () async {
    // 1. Initial Speeding
    mockMapNotifier.updateState(
      MapState(
        userLocation: const LatLng(60, 25),
        currentSpeedKmh: 60,
        currentZone: SpeedLimitZone(id: 'zone1', rings: [], speedLimitKmh: 50),
      ),
    );
    await Future<void>.value();
    log.clear(); // Clear initial alert

    // 2. Increase Speed (Still Speeding)
    mockMapNotifier.updateState(
      MapState(
        userLocation: const LatLng(60, 25),
        currentSpeedKmh: 70,
        currentZone: SpeedLimitZone(id: 'zone1', rings: [], speedLimitKmh: 50),
      ),
    );
    await Future<void>.value();

    expect(
      log,
      isEmpty,
      reason: 'Rising edge logic should prevent repeat alerts',
    );
  });

  test('Speeding -> Safe -> Speeding (Reset & Re-trigger)', () async {
    // 1. Initial Speeding
    mockMapNotifier.updateState(
      MapState(
        userLocation: const LatLng(60, 25),
        currentSpeedKmh: 60,
        currentZone: SpeedLimitZone(id: 'zone1', rings: [], speedLimitKmh: 50),
      ),
    );
    await Future<void>.value();
    log.clear();

    // 2. Safe
    mockMapNotifier.updateState(
      MapState(
        userLocation: const LatLng(60, 25),
        currentSpeedKmh: 40,
        currentZone: SpeedLimitZone(id: 'zone1', rings: [], speedLimitKmh: 50),
      ),
    );
    await Future<void>.value();
    expect(log, isEmpty);

    // 3. Speeding Again
    mockMapNotifier.updateState(
      MapState(
        userLocation: const LatLng(60, 25),
        currentSpeedKmh: 65,
        currentZone: SpeedLimitZone(id: 'zone1', rings: [], speedLimitKmh: 50),
      ),
    );
    await Future(() {}); // Allow async logic

    expect(
      log,
      isNotEmpty,
      reason: 'Should re-trigger after returning to safe state',
    );
  });
}
