import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/presentation/widgets/adaptive_nav_shell.dart';
import 'package:sakkoja/core/router/router.dart';

void main() {
  group('production route contract', () {
    test('registers every declarative page route', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final router = container.read(goRouterProvider);
      addTearDown(router.dispose);

      expect(
        _routePaths(router.configuration.routes),
        containsAll({
          '/',
          '/fishing',
          '/weather',
          '/menu',
          '/route-planner',
          '/skipper-settings',
        }),
      );
    });

    testWidgets('renders the configured unknown-route experience', (
      tester,
    ) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final router = container.read(goRouterProvider)..go('/missing-page');
      addTearDown(router.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sivua ei löydy'), findsOneWidget);
      expect(find.byIcon(Icons.anchor), findsOneWidget);
    });
  });

  group('responsive shell contract', () {
    testWidgets(
      'mobile map renders bottom navigation bar with Valikko destination',
      (
        tester,
      ) async {
        await _setViewport(tester, const Size(390, 844));
        final router = _shellRouter();
        addTearDown(router.dispose);

        await tester.pumpWidget(MaterialApp.router(routerConfig: router));
        await tester.pumpAndSettle();

        expect(find.text('Map page'), findsOneWidget);
        expect(find.byType(NavigationBar), findsOneWidget);
        expect(find.text('Valikko'), findsOneWidget);
        expect(find.byType(NavigationRail), findsNothing);
      },
    );

    testWidgets('tablet and desktop use the navigation rail', (tester) async {
      await _setViewport(tester, const Size(768, 1024));
      final router = _shellRouter();
      addTearDown(router.dispose);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(
        tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
        isFalse,
      );
    });

    testWidgets('wide desktop extends the navigation rail', (tester) async {
      await _setViewport(tester, const Size(1440, 900));
      final router = _shellRouter();
      addTearDown(router.dispose);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(
        tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
        isTrue,
      );
      expect(find.text('Kartta'), findsOneWidget);
    });
  });
}

Set<String> _routePaths(List<RouteBase> routes) {
  final paths = <String>{};
  for (final route in routes) {
    if (route is GoRoute) {
      paths.add(route.path);
      paths.addAll(_routePaths(route.routes));
    } else if (route is StatefulShellRoute) {
      for (final branch in route.branches) {
        paths.addAll(_routePaths(branch.routes));
      }
    } else if (route is ShellRoute) {
      paths.addAll(_routePaths(route.routes));
    }
  }
  return paths;
}

GoRouter _shellRouter({String initialLocation = '/'}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            AdaptiveNavigationShell(navigationShell: shell),
        branches: [
          _branch('/', 'Map page'),
          _branch('/fishing', 'Fishing page'),
          _branch('/weather', 'Weather page'),
          _branch('/menu', 'Menu page'),
        ],
      ),
    ],
  );
}

StatefulShellBranch _branch(String path, String label) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: path,
        builder: (context, state) => Scaffold(body: Center(child: Text(label))),
      ),
    ],
  );
}

Future<void> _setViewport(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
}
