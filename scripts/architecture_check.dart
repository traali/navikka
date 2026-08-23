// Architecture Enforcement Script
// Runs in CI to verify code follows AGENTS.md rules
//
// Usage: dart run scripts/architecture_check.dart
//
// ignore_for_file: avoid_print

import 'dart:io';

/// Exit codes
const int success = 0;
const int failure = 1;

/// Forbidden imports that should never appear
const forbiddenImports = [
  'package:hive/',
  'package:hive_flutter/',
  'package:provider/',
  'package:get/',
  'package:getx/',
];

/// Forbidden patterns in lib/ code
const forbiddenPatterns = [
  RegexPattern(r'\bprint\s*\(', 'Use Log.d/i/w/e instead of print()'),
  RegexPattern(r'\bdebugPrint\s*\(', 'Use Log.d/i/w/e instead of debugPrint()'),
];

/// Domain layer should not import Flutter
const domainForbiddenImports = ['package:flutter/', 'dart:ui'];

class RegexPattern {
  const RegexPattern(this.pattern, this.message);
  final String pattern;
  final String message;
}

class Violation {
  const Violation(this.file, this.line, this.message);
  final String file;
  final int line;
  final String message;

  @override
  String toString() => '  $file:$line - $message';
}

void main() async {
  print('🔍 Running Architecture Checks...\n');

  final violations = <Violation>[];

  // Get all Dart files in lib/
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('❌ lib/ directory not found');
    exit(failure);
  }

  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !f.path.endsWith('.freezed.dart'))
      .toList();

  print('📁 Scanning ${dartFiles.length} Dart files...\n');

  for (final file in dartFiles) {
    final relativePath = file.path.replaceAll(r'\', '/');
    final lines = file.readAsLinesSync();
    final isDomainLayer = relativePath.contains('/domain/');

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final lineNum = i + 1;

      // Check forbidden imports
      for (final forbidden in forbiddenImports) {
        if (line.contains("import '$forbidden") ||
            line.contains('import "$forbidden')) {
          violations.add(
            Violation(
              relativePath,
              lineNum,
              'Forbidden import: $forbidden (see AGENTS.md §2)',
            ),
          );
        }
      }

      // Check domain layer Flutter imports
      if (isDomainLayer) {
        for (final forbidden in domainForbiddenImports) {
          if (line.contains("import '$forbidden") ||
              line.contains('import "$forbidden')) {
            violations.add(
              Violation(
                relativePath,
                lineNum,
                'Domain layer must not import Flutter: $forbidden (see AGENTS.md §1)',
              ),
            );
          }
        }
      }

      // Check forbidden patterns (only in non-generated files)
      for (final pattern in forbiddenPatterns) {
        if (RegExp(pattern.pattern).hasMatch(line)) {
          // Skip if it's in a comment or string
          final trimmed = line.trim();
          if (!trimmed.startsWith('//') && !trimmed.startsWith('*')) {
            violations.add(
              Violation(
                relativePath,
                lineNum,
                '${pattern.message} (see AGENTS.md §12)',
              ),
            );
          }
        }
      }
    }
  }

  _checkCompanionContract(violations);

  // Report results
  if (violations.isEmpty) {
    print('✅ All architecture checks passed!\n');
    print('Verified:');
    print('  • No forbidden imports (hive, provider, getx)');
    print('  • No print/debugPrint usage');
    print('  • Domain layer has no Flutter dependencies');
    print('  • Companion /cockpit Pages contract');
    exit(success);
  } else {
    print('❌ Found ${violations.length} architecture violation(s):\n');
    for (final v in violations) {
      print(v);
    }
    print('\n📚 Reference: See AGENTS.md for architecture rules');
    exit(failure);
  }
}

void _checkCompanionContract(List<Violation> violations) {
  const redirectsPath = 'web/_redirects';
  final redirects = File(redirectsPath);
  if (!redirects.existsSync()) {
    violations.add(const Violation(redirectsPath, 1, 'web/_redirects missing'));
    return;
  }
  final text = redirects.readAsStringSync().replaceAll(RegExp(r'\s+'), ' ');
  final cockpit = text.indexOf('/cockpit /cockpit/');
  final pwa = text.indexOf('/pwa /cockpit/');
  final catchAll = text.indexOf('/* /index.html');
  if (cockpit < 0) {
    violations.add(
      const Violation(
        redirectsPath,
        1,
        'Must 301 /cockpit → /cockpit/ before the Flutter SPA catch-all',
      ),
    );
  } else if (catchAll >= 0 && catchAll < cockpit) {
    violations.add(
      const Violation(
        redirectsPath,
        1,
        'Flutter SPA catch-all /* must come AFTER /cockpit redirects',
      ),
    );
  }
  if (pwa < 0) {
    violations.add(
      const Violation(
        redirectsPath,
        1,
        'Must 301 /pwa → /cockpit/ (do not ship a second copy)',
      ),
    );
  } else if (catchAll >= 0 && catchAll < pwa) {
    violations.add(
      const Violation(
        redirectsPath,
        1,
        'Flutter SPA catch-all /* must come AFTER /pwa redirects',
      ),
    );
  }

  for (final yml in [
    '.github/workflows/deploy.yml',
    '.github/workflows/ci.yml',
  ]) {
    final f = File(yml);
    if (!f.existsSync()) continue;
    final body = f.readAsStringSync();
    if (!body.contains('--base=/cockpit/')) {
      violations.add(
        Violation(yml, 1, 'Companion must build with --base=/cockpit/'),
      );
    }
    if (body.contains('--base=./')) {
      violations.add(
        Violation(
          yml,
          1,
          'Companion must build with --base=/cockpit/ '
          '(relative ./ breaks /cockpit without slash)',
        ),
      );
    }
    if (body.contains('build/web/pwa')) {
      violations.add(
        Violation(
          yml,
          1,
          'Do not ship a second copy under /pwa; 301 /pwa → /cockpit/',
        ),
      );
    }
  }

  final ci = File('.github/workflows/ci.yml');
  if (ci.existsSync()) {
    final body = ci.readAsStringSync();
    if (!body.contains('npm test')) {
      violations.add(
        const Violation(
          '.github/workflows/ci.yml',
          1,
          'CI verify must run companion npm test (not only build)',
        ),
      );
    }
  }

  final ais = File('apps/web-pwa/src/lib/navikka/ais.ts');
  if (ais.existsSync()) {
    final body = ais.readAsStringSync();
    if (!body.contains('aisQuery')) {
      violations.add(
        const Violation(
          'apps/web-pwa/src/lib/navikka/ais.ts',
          1,
          'AIS fetch must pass Digitraffic latitude/longitude/radius '
              '(no national dump)',
        ),
      );
    }
  }

  final flutterAisDs = File(
    'lib/features/ais/data/datasources/digitraffic_ais_remote_data_source.dart',
  );
  if (flutterAisDs.existsSync()) {
    final body = flutterAisDs.readAsStringSync();
    if (!body.contains("'radius':") && !body.contains('"radius":')) {
      violations.add(
        const Violation(
          'lib/features/ais/data/datasources/'
              'digitraffic_ais_remote_data_source.dart',
          1,
          'Flutter AIS must query Digitraffic with radius, '
              'not the national dump',
        ),
      );
    }
  }

  final flutterAisProv = File(
    'lib/features/ais/presentation/providers/ais_targets_provider.dart',
  );
  if (flutterAisProv.existsSync()) {
    final body = flutterAisProv.readAsStringSync();
    if (!body.contains('shouldFetchAis') ||
        !body.contains('UnderwayFetch.aisPollCheck')) {
      violations.add(
        const Violation(
          'lib/features/ais/presentation/providers/ais_targets_provider.dart',
          1,
          'Flutter AIS must check every 15s but fetch on 60s/180s TTL',
        ),
      );
    }
    if (body.contains('Timer.periodic(const Duration(seconds: 15)')) {
      violations.add(
        const Violation(
          'lib/features/ais/presentation/providers/ais_targets_provider.dart',
          1,
          'Do not HTTP-fetch AIS every 15s; use UnderwayFetch TTL',
        ),
      );
    }
    if (body.contains('reasonMoved')) {
      violations.add(
        const Violation(
          'lib/features/ais/presentation/providers/ais_targets_provider.dart',
          1,
          'Map pan must not bypass shouldFetchAis 60s/180s TTL',
        ),
      );
    }
  }

  final aiProviders = File(
    'lib/features/ai/presentation/providers/ai_providers.dart',
  );
  if (aiProviders.existsSync()) {
    final body = aiProviders.readAsStringSync();
    if (body.contains('.select(') &&
        !body.contains(
          "import 'package:flutter_riverpod/flutter_riverpod.dart'",
        )) {
      violations.add(
        const Violation(
          'lib/features/ai/presentation/providers/ai_providers.dart',
          1,
          'skipperInsight .select requires flutter_riverpod import',
        ),
      );
    }
  }

  final weatherScreen = File(
    'lib/features/weather/presentation/screens/weather_screen.dart',
  );
  if (weatherScreen.existsSync()) {
    final body = weatherScreen.readAsStringSync();
    if (!body.contains('skipLoadingOnReload: true')) {
      violations.add(
        const Violation(
          'lib/features/weather/presentation/screens/weather_screen.dart',
          1,
          'Sää skipper card must keep last insight on reload',
        ),
      );
    }
  }

  final skipperBanner = File(
    'lib/features/ai/presentation/widgets/skipper_insight_banner.dart',
  );
  if (skipperBanner.existsSync()) {
    final body = skipperBanner.readAsStringSync();
    if (!body.contains('skipLoadingOnReload: true')) {
      violations.add(
        const Violation(
          'lib/features/ai/presentation/widgets/'
              'skipper_insight_banner.dart',
          1,
          'Skipper banner must keep last insight on reload '
              '(skipLoadingOnReload: true)',
        ),
      );
    }
  }

  final fetchPolicy = File('apps/web-pwa/src/lib/navikka/fetch-policy.ts');
  if (fetchPolicy.existsSync()) {
    final body = fetchPolicy.readAsStringSync();
    if (!body.contains('AIS_RETRY_MS') ||
        !body.contains('lastAttemptAt: number | null')) {
      violations.add(
        const Violation(
          'apps/web-pwa/src/lib/navikka/fetch-policy.ts',
          1,
          'AIS fetch must require lastAttemptAt and 60s retry backoff',
        ),
      );
    }
  }

  final deployYml = File('.github/workflows/deploy.yml');
  if (deployYml.existsSync()) {
    final body = deployYml.readAsStringSync();
    if (!body.contains("if: needs.gate.outputs.should_deploy == 'true'") ||
        !body.contains('required: false')) {
      violations.add(
        const Violation(
          '.github/workflows/deploy.yml',
          1,
          'Pages deploy must skip when CLOUDFLARE_API_TOKEN is unset '
              "(if: needs.gate.outputs.should_deploy == 'true'; "
              'secrets required: false)',
        ),
      );
    }
  }

  for (final rel in [
    'lib/features/map/presentation/widgets/map_content.dart',
    'lib/features/satellite/presentation/screens/satellite_screen.dart',
  ]) {
    final f = File(rel);
    if (!f.existsSync()) continue;
    if (f.readAsStringSync().contains("'User-Agent':")) {
      violations.add(
        Violation(
          rel,
          1,
          'Web NetworkTileProvider must not set User-Agent/Referer '
          '(Chrome forbids them; Traficom CORS preflight 403s the chart)',
        ),
      );
    }
  }

  for (final rel in [
    'lib/features/ai/presentation/widgets/skipper_insight_banner.dart',
    'lib/features/weather/presentation/screens/weather_screen.dart',
    'lib/features/navigation/presentation/screens/route_planner_screen.dart',
  ]) {
    final f = File(rel);
    if (!f.existsSync()) continue;
    final src = f.readAsStringSync();
    if (src.contains('Luottamus 94%') ||
        src.contains('Luottamus: 96%') ||
        src.contains('clamp(88, 98)')) {
      violations.add(
        Violation(
          rel,
          1,
          'Skipper HUD must not invent a confidence percentage',
        ),
      );
    }
  }

  final catalog = File('apps/web-pwa/src/lib/navikka/catalog.ts');
  if (catalog.existsSync() &&
      catalog.readAsStringSync().contains('targets.length ? targets : seed')) {
    violations.add(
      Violation(
        'apps/web-pwa/src/lib/navikka/catalog.ts',
        1,
        'Seed AIS (MEGASTAR) must never paint on an empty live list',
      ),
    );
  }
  final cockpitHud = File('apps/web-pwa/src/components/navikka/cockpit.tsx');
  if (cockpitHud.existsSync() &&
      !cockpitHud.readAsStringSync().contains('gpsLive ? fmtSpeed(sog')) {
    violations.add(
      Violation(
        'apps/web-pwa/src/components/navikka/cockpit.tsx',
        1,
        'HUD SOG must stay em-dash until LIVE GPS',
      ),
    );
  }
  final weatherTs = File('apps/web-pwa/src/lib/navikka/weather.ts');
  if (weatherTs.existsSync()) {
    final wx = weatherTs.readAsStringSync();
    if (wx.contains('windMs * 1.4') || wx.contains('FALLBACK.dewC')) {
      violations.add(
        Violation(
          'apps/web-pwa/src/lib/navikka/weather.ts',
          1,
          'Compact MET must not invent gusts (wind×1.4) or dew 11.1 °C',
        ),
      );
    }
  }
}
