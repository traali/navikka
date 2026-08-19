import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/menu/presentation/screens/menu_screen.dart';

/// A responsive shell that adapts navigation based on screen width.
///
/// - Mobile (< 600dp): Uses compact [NavigationBar] at the bottom (58dp height).
/// - Tablet/Desktop (>= 600dp): Uses [NavigationRail] on the left.
class AdaptiveNavigationShell extends StatelessWidget {
  const AdaptiveNavigationShell({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // 600dp is the standard breakpoint for Tablet/Desktop layout in M3
    final isDesktop = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: isDesktop
          ? _DesktopLayout(navigationShell: navigationShell)
          : _MobileLayout(navigationShell: navigationShell),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.canvas,
      body: navigationShell,
      endDrawer: Drawer(
        backgroundColor: colors.canvas,
        child: const MenuScreen(showAppBar: false),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return NavigationBarTheme(
            data: NavigationBarThemeData(
              height: 56,
              indicatorColor: colors.primaryAction.withValues(alpha: 0.2),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(
                    color: colors.primaryAction,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  );
                }
                return TextStyle(
                  color: colors.textSecondary,
                  fontSize: 10,
                );
              }),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return IconThemeData(
                    color: colors.primaryAction,
                    size: 20,
                  );
                }
                return IconThemeData(
                  color: colors.textSecondary,
                  size: 20,
                );
              }),
            ),
            child: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              backgroundColor: colors.surface.withValues(alpha: 0.95),
              elevation: 8,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map),
                  label: 'Kartta',
                ),
                NavigationDestination(
                  icon: Icon(Icons.phishing_outlined),
                  selectedIcon: Icon(Icons.phishing),
                  label: 'Kalastus',
                ),
                NavigationDestination(
                  icon: Icon(Icons.wb_sunny_outlined),
                  selectedIcon: Icon(Icons.wb_sunny),
                  label: 'Sää',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_outlined),
                  selectedIcon: Icon(Icons.menu),
                  label: 'Valikko',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        NavigationRail(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) =>
              _onDestinationSelected(context, index),
          backgroundColor: colors.surface,
          indicatorColor: colors.primaryAction.withValues(alpha: 0.2),
          extended:
              MediaQuery.sizeOf(context).width >=
              1200, // Expand on large screens
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: Text('Kartta'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.phishing_outlined),
              selectedIcon: Icon(Icons.phishing),
              label: Text('Kalastus'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.wb_sunny_outlined),
              selectedIcon: Icon(Icons.wb_sunny),
              label: Text('Sää'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.menu_outlined),
              selectedIcon: Icon(Icons.menu),
              label: Text('Valikko'),
            ),
          ],
        ),
        VerticalDivider(
          thickness: 1,
          width: 1,
          color: colors.glassBorder,
        ),
        Expanded(child: navigationShell),
      ],
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
