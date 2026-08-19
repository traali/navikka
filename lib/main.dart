import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/initialization/app_initializer.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/router/router.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  const version = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: 'unknown',
  );
  const hash = String.fromEnvironment(
    'APP_VERSION_HASH',
    defaultValue: 'unknown',
  );
  const branch = String.fromEnvironment(
    'APP_VERSION_BRANCH',
    defaultValue: 'unknown',
  );
  const buildTime = String.fromEnvironment(
    'APP_VERSION_BUILD_TIME',
    defaultValue: 'unknown',
  );

  Log.i('🔵 Navikka v$version ($hash) branch:$branch built:$buildTime');

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Perform system initialization
      await AppInitializer.initialize();

      // Pre-resolve persistent dependencies
      final prefs = await SharedPreferences.getInstance();

      runApp(
        ProviderScope(
          overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      Log.e('Global Crash Error: $error', error, stackTrace);
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeModeAsync = ref.watch(appThemeControllerProvider);
    final themeMode = themeModeAsync.value ?? AppThemeMode.nightCaptain;

    final ThemeData activeTheme;
    switch (themeMode) {
      case AppThemeMode.nightCaptain:
        activeTheme = AppTheme.nightCaptain();
      case AppThemeMode.solarFlare:
        activeTheme = AppTheme.solarFlare();
      case AppThemeMode.deepSea:
        activeTheme = AppTheme.deepSea();
      case AppThemeMode.borealAurora:
        activeTheme = AppTheme.borealAurora();
      case AppThemeMode.redWatch:
        activeTheme = AppTheme.redWatch();
    }

    final isDark = activeTheme.brightness == Brightness.dark;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: isDark ? AppTheme.solarFlare() : activeTheme,
      darkTheme: isDark ? activeTheme : AppTheme.nightCaptain(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
