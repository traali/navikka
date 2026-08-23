import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Locks the React companion + Flutter Pages contract so a future Dart-only
/// PR cannot silently unship /cockpit or restore the national AIS dump.
String _compact(String text) => text.replaceAll(RegExp(r'\s+'), ' ');

void main() {
  test(
    'Pages redirects send /cockpit and /pwa before the Flutter SPA catch-all',
    () {
      final text = _compact(File('web/_redirects').readAsStringSync());
      final cockpit = text.indexOf('/cockpit /cockpit/');
      final pwa = text.indexOf('/pwa /cockpit/');
      final catchAll = text.indexOf('/* /index.html');
      expect(cockpit, greaterThanOrEqualTo(0));
      expect(pwa, greaterThanOrEqualTo(0));
      expect(catchAll, greaterThan(cockpit));
      expect(catchAll, greaterThan(pwa));
      expect(text, contains('/cockpit/* /cockpit/:splat'));
    },
  );

  test('deploy and CI build the companion at /cockpit/ not relative ./', () {
    for (final path in [
      '.github/workflows/deploy.yml',
      '.github/workflows/ci.yml',
    ]) {
      final body = File(path).readAsStringSync();
      expect(body, contains('--base=/cockpit/'), reason: path);
      expect(body.contains('--base=./'), isFalse, reason: path);
      expect(body.contains('build/web/pwa'), isFalse, reason: path);
    }
  });

  test('CI verify runs companion npm test, not only a production build', () {
    final body = File('.github/workflows/ci.yml').readAsStringSync();
    expect(body, contains('npm test'));
    expect(body, contains('npm run typecheck'));
  });

  test('companion AIS URL is radius-bounded', () {
    final body = File('apps/web-pwa/src/lib/navikka/ais.ts').readAsStringSync();
    expect(body, contains('aisQuery'));
    expect(body.contains('/locations"'), isFalse);
  });

  test('companion GPS kinematics never inherit demo SOG', () {
    final body = File(
      'apps/web-pwa/src/lib/navikka/fetch-policy.ts',
    ).readAsStringSync();
    expect(body, contains('deviceFixKinematics'));
    expect(body, contains('wasDemo'));
    expect(body, contains('WEATHER_RETRY_MS'));
    expect(body, contains('lastAttemptAt: number | null'));
    expect(body.contains('lastAttemptAt?:'), isFalse);
  });

  test('companion fairway lookup uses segments', () {
    final catalog = File(
      'apps/web-pwa/src/lib/navikka/catalog.ts',
    ).readAsStringSync();
    expect(catalog, contains('distToPolylineM'));
    expect(catalog, contains('FAIRWAY_MAX_M'));
    final geo = File('apps/web-pwa/src/lib/navikka/geo.ts').readAsStringSync();
    expect(geo, contains('export function distToSegmentM'));
  });

  test('fishing polygons are added to the Leaflet group', () {
    final body = File(
      'apps/web-pwa/src/components/navikka/map-view.tsx',
    ).readAsStringSync();
    expect(body, contains('.addTo(fish)'));
  });

  test('seed AIS is not live and empty MET timeseries throws', () {
    final store = File(
      'apps/web-pwa/src/lib/navikka/store.ts',
    ).readAsStringSync();
    expect(store, contains('aisSource: "seed"'));
    expect(store, contains('setAisError'));
    final weather = File(
      'apps/web-pwa/src/lib/navikka/weather.ts',
    ).readAsStringSync();
    expect(weather, contains('empty'));
    expect(weather, contains('if (!res.ok) throw'));
    final panels = File(
      'apps/web-pwa/src/components/navikka/panels.tsx',
    ).readAsStringSync();
    expect(panels, contains('aisSource === "live"'));
  });

  test('Pages deploy skips when Cloudflare secrets are unset', () {
    final body = File('.github/workflows/deploy.yml').readAsStringSync();
    expect(body, contains('if: needs.gate.outputs.should_deploy'));
    expect(body, contains('required: false'));
    expect(body, contains('CLOUDFLARE_API_TOKEN'));
    expect(body, contains('CLOUDFLARE_ACCOUNT_ID'));
    expect(body, contains('Skipping Cloudflare Pages deploy'));
  });

  test('Flutter AIS is radius-bounded and TTL-gated like companion', () {
    final ds = File(
      'lib/features/ais/data/datasources/digitraffic_ais_remote_data_source.dart',
    ).readAsStringSync();
    expect(ds, contains('radius'));
    expect(ds, contains('latitude'));
    final prov = File(
      'lib/features/ais/presentation/providers/ais_targets_provider.dart',
    ).readAsStringSync();
    expect(prov, contains('shouldFetchAis'));
    expect(prov, contains('UnderwayFetch.aisPollCheck'));
    expect(
      prov.contains('Timer.periodic(const Duration(seconds: 15)'),
      isFalse,
    );
  });
}
