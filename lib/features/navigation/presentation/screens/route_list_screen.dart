import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';

class RouteListScreen extends ConsumerWidget {
  const RouteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final routesAsync = ref.watch(routesListProvider);
    final activeRouteAsync = ref.watch(activeRouteProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        title: Text(
          'Tallennetut reitit',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: colors.primaryAction),
            tooltip: 'Luo reitti',
            onPressed: () => context.push('/route-planner'),
          ),
        ],
      ),
      body: routesAsync.when(
        data: (routes) {
          if (routes.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 56,
                    color: colors.textSecondary.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ei tallennettuja reittejä.',
                    style: AppTextStyles.h4.copyWith(color: colors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Napauta + luodaksesi uuden reitin.',
                    style: AppTextStyles.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: routes.length,
            separatorBuilder: (_, _) => Divider(color: colors.glassBorder),
            itemBuilder: (context, index) {
              final route = routes[index];
              final isActive = activeRouteAsync.asData?.value?.id == route.id;

              return ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isActive
                        ? colors.primaryAction.withValues(alpha: 0.2)
                        : colors.surfaceHighlight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isActive
                          ? colors.primaryAction
                          : colors.glassBorder,
                    ),
                  ),
                  child: Icon(
                    isActive ? Icons.navigation_rounded : Icons.route_rounded,
                    color: isActive
                        ? colors.primaryAction
                        : colors.textSecondary,
                  ),
                ),
                title: Text(
                  route.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  '${(route.totalDistanceMeters / 1852).toStringAsFixed(2)} NM (${(route.totalDistanceMeters / 1000).toStringAsFixed(1)} km)',
                  style: AppTextStyles.caption.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isActive)
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: colors.primaryAction,
                        ),
                        onPressed: () async {
                          try {
                            await ref
                                .read(navigationRepositoryProvider)
                                .setActiveRoute(route.id);
                            ref.invalidate(activeRouteProvider);
                            ref.invalidate(routesListProvider);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${route.name} asetettu aktiiviseksi',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Aktivointi epäonnistui: $e'),
                                  backgroundColor: colors.danger,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Aktivoi'),
                      ),
                    if (isActive)
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.primaryAction,
                          foregroundColor: colors.canvas,
                        ),
                        onPressed: () {
                          context.go('/');
                        },
                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                        label: const Text('Näytä kartalla'),
                      ),
                  ],
                ),
                onTap: () {
                  // Route detail navigation
                },
              );
            },
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: colors.primaryAction),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Virhe: $err',
            style: TextStyle(color: colors.danger),
          ),
        ),
      ),
    );
  }
}
