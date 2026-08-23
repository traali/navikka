/// Underway radio / HUD policy shared by Flutter PWA (navikka.pages.dev).
///
/// Numbers match `apps/web-pwa/src/lib/navikka/fetch-policy.ts`. A 6 kn boat
/// moves ~3 m/s; FMI stations update every 10 min; Digitraffic AIS is a
/// national dump unless queried with radius. iPhone Chrome is a 4-hour watch.
class UnderwayFetch {
  const UnderwayFetch._();

  /// MET / FMI usable grid. ~5.5 km — NOT GPS precision.
  static const double weatherSnapDeg = 0.05;
  static const Duration weatherTtl = Duration(minutes: 10);

  /// Poll *check* cadence. Fetch only when [aisTtl] says so.
  static const Duration aisPollCheck = Duration(seconds: 15);
  static const Duration aisTtlFollow = Duration(seconds: 60);
  static const Duration aisTtlIdle = Duration(seconds: 180);

  /// Digitraffic `radius` is kilometres. 0.4° ≈ 44 km.
  static const double aisRadiusKm = 45;
  static const double aisBboxDeg = 0.4;
  static const double aisIdleBelowKn = 0.5;

  /// GPS jitter around a station is tens of metres. Bucket the HUD so
  /// "Havaintoasema (502 m)" does not rewrite every location tick.
  static const int stationDistanceBucketM = 100;

  /// Disable cloud/edge AI only on a *real* low-battery reading.
  /// iOS Chrome Battery Status API is missing and often reports 0.
  static const int batteryLowPercent = 20;
}

/// Follow (underway) vs idle AIS TTL from speed over ground in knots.
Duration aisTtl({required double sogKn}) {
  return sogKn >= UnderwayFetch.aisIdleBelowKn
      ? UnderwayFetch.aisTtlFollow
      : UnderwayFetch.aisTtlIdle;
}

/// Whether an AIS HTTP fetch should run. Check interval may be 15 s;
/// fetch is 60 s underway / 180 s idle — never the national dump every tick.
bool shouldFetchAis({
  required DateTime now,
  required DateTime? lastAt,
  required double sogKn,
  bool hidden = false,
  bool inflight = false,
}) {
  if (hidden || inflight) return false;
  if (lastAt == null) return true;
  return now.difference(lastAt) >= aisTtl(sogKn: sogKn);
}

/// iOS Chrome / web Battery Status API often reports 0 when unsupported.
/// Treat 0, negatives, and >100 as unknown — do not disable on-device AI.
bool isBatteryTooLowForAi(int? batteryPercent) {
  if (batteryPercent == null) return false;
  if (batteryPercent <= 0 || batteryPercent > 100) return false;
  return batteryPercent < UnderwayFetch.batteryLowPercent;
}

/// Round station range so GPS jitter does not look like a weather refetch.
String formatStationDistance(double meters) {
  if (!meters.isFinite || meters < 0) return '—';
  if (meters < 950) {
    final bucket =
        (meters / UnderwayFetch.stationDistanceBucketM).round() *
        UnderwayFetch.stationDistanceBucketM;
    final shown = bucket < UnderwayFetch.stationDistanceBucketM
        ? UnderwayFetch.stationDistanceBucketM
        : bucket;
    return '$shown m';
  }
  return '${(meters / 1000).toStringAsFixed(1)} km';
}

String formatStationWithDistance({
  String? stationName,
  required double meters,
}) {
  final name = (stationName == null || stationName.isEmpty)
      ? 'Havaintoasema'
      : stationName;
  return '$name (${formatStationDistance(meters)})';
}

/// Never put DioException / XMLHttpRequest text on the skipper HUD.
String sanitizeNetworkError(
  Object error, {
  String fallback =
      'Säähavaintojen päivitys epäonnistui (yhteyskatkos). '
      'Näytetään viimeisin tallennettu havainto.',
}) {
  final raw = error.toString();
  final lower = raw.toLowerCase();
  const needles = [
    'dioexception',
    'xmlhttprequest',
    'socketexception',
    'connection error',
    'failed host lookup',
    'clientexception',
    'xmlhttp',
  ];
  for (final n in needles) {
    if (lower.contains(n)) return fallback;
  }
  if (raw.length > 160) return fallback;
  return raw;
}
