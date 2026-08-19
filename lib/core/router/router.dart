import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/presentation/widgets/adaptive_nav_shell.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ai/presentation/screens/insight_history_screen.dart';
import 'package:sakkoja/features/ai/presentation/screens/marine_technical_copilot_screen.dart';
import 'package:sakkoja/features/ai/presentation/screens/skipper_settings_screen.dart';
import 'package:sakkoja/features/fishing/presentation/screens/fishing_screen.dart';
import 'package:sakkoja/features/map/presentation/screens/map_screen.dart';
import 'package:sakkoja/features/map/presentation/screens/offline_regions_screen.dart';
import 'package:sakkoja/features/menu/presentation/screens/menu_screen.dart';
import 'package:sakkoja/features/navigation/presentation/screens/route_list_screen.dart';
import 'package:sakkoja/features/navigation/presentation/screens/route_planner_screen.dart';
import 'package:sakkoja/features/satellite/presentation/screens/satellite_screen.dart';
import 'package:sakkoja/features/vessel/presentation/screens/vessel_settings_screen.dart';
import 'package:sakkoja/features/weather/presentation/screens/weather_screen.dart';

part 'router.g.dart';

// Navigator keys are file-private — they don't need to be global.
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorMapKey = GlobalKey<NavigatorState>(debugLabel: 'shellMap');
final _shellNavigatorFishingKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellFishing',
);
final _shellNavigatorWeatherKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellWeather',
);
final _shellNavigatorMenuKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellMenu',
);

/// GoRouter provider — managed by Riverpod so it can be overridden in tests
/// and extended with redirect guards that read provider state in the future.
@riverpod
Raw<GoRouter> goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AdaptiveNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Map (Home)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMapKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const MapScreen(),
              ),
            ],
          ),
          // Branch 2: Fishing
          StatefulShellBranch(
            navigatorKey: _shellNavigatorFishingKey,
            routes: [
              GoRoute(
                path: '/fishing',
                builder: (context, state) => const FishingScreen(),
              ),
            ],
          ),
          // Branch 3: Weather
          StatefulShellBranch(
            navigatorKey: _shellNavigatorWeatherKey,
            routes: [
              GoRoute(
                path: '/weather',
                builder: (context, state) => const WeatherScreen(),
              ),
            ],
          ),
          // Branch 4: Menu
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMenuKey,
            routes: [
              GoRoute(
                path: '/menu',
                builder: (context, state) => const MenuScreen(),
              ),
            ],
          ),
        ],
      ),
      // Route Planner
      GoRoute(
        path: '/route-planner',
        builder: (context, state) => const RoutePlannerScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      // Skipper Settings
      GoRoute(
        path: '/skipper-settings',
        builder: (context, state) => const SkipperSettingsScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      // Offline Regions
      GoRoute(
        path: '/offline-regions',
        builder: (context, state) => const OfflineRegionsScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      // Insight History
      GoRoute(
        path: '/insight-history',
        builder: (context, state) => const InsightHistoryScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      // Route List
      GoRoute(
        path: '/routes',
        builder: (context, state) => const RouteListScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      // Vessel Settings
      GoRoute(
        path: '/vessel-settings',
        builder: (context, state) => const VesselSettingsScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      // Technical Marine Copilot & Engine Guide
      GoRoute(
        path: '/technical-copilot',
        builder: (context, state) => const MarineTechnicalCopilotScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
      // Earth Observation & Space Satellite Viewer
      GoRoute(
        path: '/satellite',
        builder: (context, state) => const SatelliteScreen(),
        parentNavigatorKey: _rootNavigatorKey,
      ),
    ],
    errorBuilder: (context, state) {
      Log.e('Router: Unknown route requested: ${state.uri}');
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.anchor, size: 48),
              SizedBox(height: 16),
              Text('Sivua ei löydy', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
    },
  );
}
