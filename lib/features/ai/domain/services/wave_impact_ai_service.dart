import 'dart:async';
import 'dart:math' as math;
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/motion_permission_helper.dart';
import 'package:sensors_plus/sensors_plus.dart';

enum SlamSeverity {
  smooth('Tasainen', 'Rauhallinen kulku, ei haitallisia iskuja'),
  moderate('Kohtalainen', 'Tuntuvia aallokon iskuja runkoon'),
  hard('Kova', 'Voimakkaita runkoiskuja. Varo irtotavaroita ja selkää'),
  severe(
    'Kriittinen',
    'Vaarallinen rynkytys. Vaurioriski rungolle ja varusteille',
  );

  const SlamSeverity(this.label, this.description);
  final String label;
  final String description;
}

enum WaveAttackDirection {
  calm('Tyyni / Vähäinen'),
  headSeas('Vasta-aallokko'),
  beamSeas('Sivuaallokko'),
  quarteringSeas('Viistoaallokko'),
  followingSeas('Myötäaallokko');

  const WaveAttackDirection(this.label);
  final String label;
}

class WaveImpactState {
  const WaveImpactState({
    required this.currentGForce,
    required this.peakGForceLastMinute,
    required this.hitsPerMinute,
    required this.estimatedWaveHeightM,
    required this.attackDirection,
    required this.isOutlierWave,
    required this.severity,
    required this.skipperAdvice,
    required this.timestamp,
  });

  final double currentGForce;
  final double peakGForceLastMinute;
  final int hitsPerMinute;
  final double estimatedWaveHeightM;
  final WaveAttackDirection attackDirection;
  final bool isOutlierWave;
  final SlamSeverity severity;
  final String skipperAdvice;
  final DateTime timestamp;

  factory WaveImpactState.initial() => WaveImpactState(
    currentGForce: 1,
    peakGForceLastMinute: 1,
    hitsPerMinute: 0,
    estimatedWaveHeightM: 0.2,
    attackDirection: WaveAttackDirection.calm,
    isOutlierWave: false,
    severity: SlamSeverity.smooth,
    skipperAdvice: 'Tasainen kulku, aallokon iskut minimissä.',
    timestamp: DateTime.now(),
  );
}

class WaveImpactAiService {
  final _stateController = StreamController<WaveImpactState>.broadcast();
  Stream<WaveImpactState> get onImpactState => _stateController.stream;

  StreamSubscription<UserAccelerometerEvent>? _accelSub;
  StreamSubscription<GyroscopeEvent>? _gyroSub;

  final List<DateTime> _recentSlamTimestamps = [];
  final List<double> _recentPeakGs = [];
  final List<double> _recentPitchRates = [];
  final List<double> _recentRollRates = [];

  int _totalAccelEvents = 0;
  int _totalGyroEvents = 0;
  int _totalSlamsDetected = 0;
  int _throttledEmissionsCount = 0;
  int _emittedStatesCount = 0;
  DateTime _lastEmissionTime = DateTime.fromMillisecondsSinceEpoch(0);

  int get totalAccelEvents => _totalAccelEvents;
  int get totalGyroEvents => _totalGyroEvents;
  int get totalSlamsDetected => _totalSlamsDetected;
  int get throttledEmissionsCount => _throttledEmissionsCount;
  int get emittedStatesCount => _emittedStatesCount;

  WaveImpactState _currentState = WaveImpactState.initial();
  WaveImpactState get currentState => _currentState;

  bool _isListening = false;
  bool get isListening => _isListening;

  /// Requests iOS WebKit motion sensor permission (DeviceMotionEvent) and starts listening.
  Future<bool> requestPermissionAndStart() async {
    final granted = await MotionPermissionHelper.requestPermission();
    if (granted) {
      stop();
      start();
    }
    return granted;
  }

  void start() {
    if (_isListening) return;
    _isListening = true;
    Log.i(
      '[WaveImpactAI] Started sensor stream for wave roughness and hull slamming.',
    );

    try {
      _accelSub = userAccelerometerEventStream().listen(
        _handleAccelEvent,
        onError: (Object err) {
          Log.w('[WaveImpactAI] Accelerometer error: $err');
        },
      );

      _gyroSub = gyroscopeEventStream().listen(
        _handleGyroEvent,
        onError: (Object err) {
          Log.w('[WaveImpactAI] Gyroscope error: $err');
        },
      );
    } catch (e) {
      Log.w('[WaveImpactAI] Sensor initialization caught error: $e');
    }
  }

  void stop() {
    _isListening = false;
    _accelSub?.cancel();
    _gyroSub?.cancel();
    _accelSub = null;
    _gyroSub = null;
    Log.i(
      '[WaveImpactAI] Stopped wave impact sensor listening. Metrics: '
      '$_totalAccelEvents accel events, $_totalGyroEvents gyro events, '
      '$_totalSlamsDetected slams, $_throttledEmissionsCount throttled frames, '
      '$_emittedStatesCount emitted frames.',
    );
  }

  void _handleGyroEvent(GyroscopeEvent event) {
    _totalGyroEvents++;
    // Collect pitch (x-rate) and roll (y-rate) angular velocity samples
    _recentPitchRates.add(event.x.abs());
    _recentRollRates.add(event.y.abs());

    if (_recentPitchRates.length > 50) _recentPitchRates.removeAt(0);
    if (_recentRollRates.length > 50) _recentRollRates.removeAt(0);
  }

  void _handleAccelEvent(UserAccelerometerEvent event) {
    _totalAccelEvents++;
    // Total dynamic acceleration magnitude in m/s^2 (excluding static 9.81g)
    final dynamicAccMps2 = math.sqrt(
      event.x * event.x + event.y * event.y + event.z * event.z,
    );

    // Total G-force (1.0g baseline + dynamic component)
    final gForce = 1.0 + (dynamicAccMps2 / 9.80665);

    processSensorReading(
      gForce: gForce,
      pitchRates: List.from(_recentPitchRates),
      rollRates: List.from(_recentRollRates),
      now: DateTime.now(),
    );
  }

  /// Processes sensor readings into sea state analysis (deterministic and testable).
  WaveImpactState processSensorReading({
    required double gForce,
    required List<double> pitchRates,
    required List<double> rollRates,
    required DateTime now,
    double boatSpeedKnots = 15.0,
  }) {
    // 1. Sliding 60-second window cleanup
    _recentSlamTimestamps.removeWhere(
      (ts) => now.difference(ts).inSeconds > 60,
    );

    // 2. Slam detection thresholding
    final isSlam = gForce >= 1.6;
    if (isSlam) {
      _totalSlamsDetected++;
      _recentSlamTimestamps.add(now);
      _recentPeakGs.add(gForce);
      if (_recentPeakGs.length > 30) _recentPeakGs.removeAt(0);
    }

    final hitsPerMinute = _recentSlamTimestamps.length;

    // 3. Peak G-force in last minute
    final peakG = _recentPeakGs.isEmpty
        ? gForce
        : _recentPeakGs.reduce((a, b) => a > b ? a : b);

    // 4. Attack direction estimation
    final attackDirection = estimateWaveDirection(
      pitchRates: pitchRates,
      rollRates: rollRates,
      hitsPerMinute: hitsPerMinute,
    );

    // 5. Outlier wave detection
    bool isOutlier = false;
    if (_recentPeakGs.length >= 5 && isSlam) {
      final meanG =
          _recentPeakGs.reduce((a, b) => a + b) / _recentPeakGs.length;
      if (gForce >= meanG * 1.8 && gForce >= 2.8) {
        isOutlier = true;
      }
    }

    // 6. Slam severity classification
    final severity = classifySeverity(gForce);

    // 7. Estimated Wave Height Hs (empirical model based on dynamic G and boat speed)
    final estWaveHeight = calculateEstimatedWaveHeight(
      peakG: peakG,
      hitsPerMinute: hitsPerMinute,
      boatSpeedKnots: boatSpeedKnots,
    );

    // 8. Skipper advisory formulation
    final advice = generateSkipperAdvice(
      severity: severity,
      direction: attackDirection,
      hitsPerMinute: hitsPerMinute,
      isOutlier: isOutlier,
      gForce: gForce,
    );

    final newState = WaveImpactState(
      currentGForce: gForce,
      peakGForceLastMinute: peakG,
      hitsPerMinute: hitsPerMinute,
      estimatedWaveHeightM: estWaveHeight,
      attackDirection: attackDirection,
      isOutlierWave: isOutlier,
      severity: severity,
      skipperAdvice: advice,
      timestamp: now,
    );

    _currentState = newState;

    // Throttle UI stream emissions to maximum 4 Hz (250ms), or immediately on critical/hard slam events
    final elapsedMs = now.difference(_lastEmissionTime).inMilliseconds;
    final isCriticalChange =
        isSlam ||
        isOutlier ||
        severity == SlamSeverity.hard ||
        severity == SlamSeverity.severe;

    if (elapsedMs >= 250 || isCriticalChange) {
      _lastEmissionTime = now;
      _emittedStatesCount++;
      _stateController.add(newState);
    } else {
      _throttledEmissionsCount++;
    }

    return newState;
  }

  static SlamSeverity classifySeverity(double gForce) {
    if (gForce >= 4.0) return SlamSeverity.severe;
    if (gForce >= 2.5) return SlamSeverity.hard;
    if (gForce >= 1.6) return SlamSeverity.moderate;
    return SlamSeverity.smooth;
  }

  static WaveAttackDirection estimateWaveDirection({
    required List<double> pitchRates,
    required List<double> rollRates,
    required int hitsPerMinute,
  }) {
    if (hitsPerMinute == 0 && pitchRates.isEmpty && rollRates.isEmpty) {
      return WaveAttackDirection.calm;
    }

    final avgPitch = pitchRates.isEmpty
        ? 0.0
        : pitchRates.reduce((a, b) => a + b) / pitchRates.length;
    final avgRoll = rollRates.isEmpty
        ? 0.0
        : rollRates.reduce((a, b) => a + b) / rollRates.length;

    if (avgPitch < 0.05 && avgRoll < 0.05 && hitsPerMinute < 3) {
      return WaveAttackDirection.calm;
    }

    if (avgPitch > avgRoll * 1.6) {
      return WaveAttackDirection.headSeas;
    } else if (avgRoll > avgPitch * 1.6) {
      return WaveAttackDirection.beamSeas;
    } else {
      return WaveAttackDirection.quarteringSeas;
    }
  }

  static double calculateEstimatedWaveHeight({
    required double peakG,
    required int hitsPerMinute,
    required double boatSpeedKnots,
  }) {
    if (hitsPerMinute == 0 && peakG <= 1.2) return 0.2;
    // Empirical marine model: Hs proportional to peak shock and wave slam rate normalized by vessel speed
    final speedFactor = math.max(boatSpeedKnots, 5) / 15.0;
    final rawHs =
        ((peakG - 1.0) * 0.45 + (hitsPerMinute * 0.025)) / speedFactor;
    return (rawHs.clamp(0.2, 4.5) * 10).round() / 10.0;
  }

  static String generateSkipperAdvice({
    required SlamSeverity severity,
    required WaveAttackDirection direction,
    required int hitsPerMinute,
    required bool isOutlier,
    required double gForce,
  }) {
    if (isOutlier) {
      return '⚠️ Yksittäinen poikkeuksellisen korkea aalto (${gForce.toStringAsFixed(1)}g)! Pidä ohjaus vakaana.';
    }

    switch (severity) {
      case SlamSeverity.severe:
        return '🚨 Vaarallinen rynkytys (${gForce.toStringAsFixed(1)}g, $hitsPerMinute iskua/min)! Laske nopeutta välittömästi tai muuta kurssia saariston suojaan.';
      case SlamSeverity.hard:
        if (direction == WaveAttackDirection.headSeas) {
          return '⚡ Kovaa vasta-aallokon hakkausta. Suositus: Laske nopeutta 3-5 kn tai aja 15° siksakkia terävän iskun vaimentamiseksi.';
        } else if (direction == WaveAttackDirection.beamSeas) {
          return '⚡ Voimakas sivuaallokon rullaus. Tasapainota painopistettä ja vältä jyrkkiä käännöksiä.';
        }
        return '⚡ Voimakkaita runkoiskuja ($hitsPerMinute/min). Laske nopeutta ja varo selkärankaan kohdistuvia tärähdyksiä.';
      case SlamSeverity.moderate:
        return '🌊 Kohtalaista aallokkoa ($hitsPerMinute iskua/min, ${direction.label}). Kulku hallinnassa.';
      case SlamSeverity.smooth:
        return '🟢 Tasainen ajo, runkoiskut minimissä.';
    }
  }

  void dispose() {
    stop();
    _stateController.close();
  }
}
