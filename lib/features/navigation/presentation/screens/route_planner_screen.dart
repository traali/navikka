import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/services/weather_ai_edge_service.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/map/presentation/widgets/map_content.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

class RoutePlannerScreen extends ConsumerStatefulWidget {
  const RoutePlannerScreen({super.key});

  @override
  ConsumerState<RoutePlannerScreen> createState() => _RoutePlannerScreenState();
}

class _RoutePlannerScreenState extends ConsumerState<RoutePlannerScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(routePlannerControllerProvider.notifier).clear();
      }
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleAddPoint() {
    final center = _mapController.camera.center;
    ref
        .read(routePlannerControllerProvider.notifier)
        .addWaypoint(center.latitude, center.longitude);
  }

  Future<void> _handleSave() async {
    final plannerState = ref.read(routePlannerControllerProvider);
    if (plannerState.waypoints.isEmpty) return;

    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        final colors = context.colors;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            'Tallenna reitti',
            style: TextStyle(color: colors.textPrimary),
          ),
          content: TextField(
            controller: _nameController,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Reitin nimi (esim. Kesäretki)',
              hintStyle: TextStyle(
                color: colors.textSecondary.withValues(alpha: 0.6),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.glassBorder),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.primaryAction),
              ),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Peruuta',
                style: TextStyle(color: colors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  Navigator.pop(context, _nameController.text);
                }
              },
              child: Text(
                'Tallenna',
                style: TextStyle(
                  color: colors.primaryAction,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (name != null && mounted) {
      await ref.read(routePlannerControllerProvider.notifier).saveRoute(name);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Reitti tallennettu')));
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final plannerState = ref.watch(routePlannerControllerProvider);
    final weatherState = ref.watch(pointWeatherControllerProvider);

    return PopScope(
      canPop: plannerState.waypoints.isEmpty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: colors.surface,
            title: Text(
              'Hylätäänkö luonnos?',
              style: TextStyle(color: colors.textPrimary),
            ),
            content: Text(
              'Reittiluonnoksessa on tallentamattomia reittipisteitä. Haluatko varmasti hylätä ne?',
              style: TextStyle(color: colors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Peruuta',
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Hylkää',
                  style: TextStyle(
                    color: colors.danger,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        if (shouldPop == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: colors.canvas,
        appBar: AppBar(
          title: Text(
            'Reittisuunnittelu',
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: colors.surface,
          elevation: 0,
          actions: [
            TextButton(
              onPressed:
                  (plannerState.waypoints.isEmpty ||
                      plannerState.isCheckingRestrictions)
                  ? null
                  : _handleSave,
              child: plannerState.isCheckingRestrictions
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.primaryAction,
                      ),
                    )
                  : Text(
                      'Tallenna',
                      style: TextStyle(
                        color: plannerState.waypoints.isEmpty
                            ? colors.textSecondary.withValues(alpha: 0.4)
                            : colors.primaryAction,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
        body: Stack(
          children: [
            // 1. Map Layer
            MapContent(mapController: _mapController),

            // 2. Safety Warning Banner
            if (plannerState.restrictionCheckError != null)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: _RestrictionCheckWarning(colors: colors),
              )
            else if (plannerState.conflicts.isNotEmpty)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: _ConflictWarning(
                  conflicts: plannerState.conflicts,
                  colors: colors,
                ),
              )
            else if (plannerState.isCheckingRestrictions)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: LinearProgressIndicator(
                  backgroundColor: colors.surfaceHighlight,
                  color: colors.primaryAction,
                ),
              ),

            // 3. Crosshair (Center)
            Center(
              child: Icon(
                Icons.add_circle_outline,
                size: 40,
                color: colors.primaryAction,
              ),
            ),

            // 4. Waypoint List (Bottom Sheet / Draggable scrollable)
            DraggableScrollableSheet(
              initialChildSize: 0.25,
              minChildSize: 0.1,
              maxChildSize: 0.5,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: 0.95),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    border: Border.all(color: colors.glassBorder),
                  ),
                  child: Column(
                    children: [
                      // Handle
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colors.textSecondary.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Stats
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${plannerState.waypoints.length} reittipistettä',
                                  style: AppTextStyles.caption.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                                Text(
                                  '${(plannerState.totalDistanceMeters / 1852).toStringAsFixed(2)} NM '
                                  '(${(plannerState.totalDistanceMeters / 1000).toStringAsFixed(1)} km)',
                                  style: AppTextStyles.h4.copyWith(
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'ARVIOITU AIKA',
                                  style: AppTextStyles.caption.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                                Text(
                                  '${plannerState.totalDurationMinutes} min',
                                  style: AppTextStyles.h4.copyWith(
                                    color: colors.primaryAction,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(color: colors.glassBorder),
                      // AI Weather-Route Briefing Card
                      if (plannerState.waypoints.length >= 2) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colors.primaryAction.withValues(
                                alpha: 0.08,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: colors.primaryAction.withValues(
                                  alpha: 0.25,
                                ),
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: colors.primaryAction,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'SKIPPER REITTIARVIO',
                                            style: AppTextStyles.nvXs.copyWith(
                                              color: colors.primaryAction,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        WeatherAIEdgeService.analyzeRoute(
                                          waypoints: plannerState.waypoints,
                                          totalDistanceMeters:
                                              plannerState.totalDistanceMeters,
                                          totalDurationMinutes:
                                              plannerState.totalDurationMinutes,
                                          weather: weatherState.weather,
                                          wave: weatherState.wave,
                                        ),
                                        style: AppTextStyles.nvXs.copyWith(
                                          color: colors.textPrimary,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      // List
                      Expanded(
                        child: ReorderableListView.builder(
                          scrollController: scrollController,
                          itemCount: plannerState.waypoints.length,
                          onReorderItem: (oldIndex, newIndex) {
                            ref
                                .read(routePlannerControllerProvider.notifier)
                                .reorderWaypoints(oldIndex, newIndex);
                          },
                          itemBuilder: (context, index) {
                            final wp = plannerState.waypoints[index];
                            return ListTile(
                              key: ValueKey(wp),
                              title: Text(
                                wp.label ?? 'Piste ${index + 1}',
                                style: TextStyle(color: colors.textPrimary),
                              ),
                              subtitle: Text(
                                '${wp.lat.toStringAsFixed(4)}, ${wp.lon.toStringAsFixed(4)}',
                                style: TextStyle(color: colors.textSecondary),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: colors.danger,
                                ),
                                tooltip: 'Poista reittipiste',
                                onPressed: () {
                                  ref
                                      .read(
                                        routePlannerControllerProvider.notifier,
                                      )
                                      .removeWaypoint(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colors.primaryAction,
          foregroundColor: colors.canvas,
          onPressed: _handleAddPoint,
          child: const Icon(Icons.add_location_alt),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class _RestrictionCheckWarning extends StatelessWidget {
  const _RestrictionCheckWarning({required this.colors});
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.warning,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_off, color: colors.canvas),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Rajoitustarkistus ei saatavilla. Tarkista verkkoyhteys ennen reitin käyttöä.',
              style: TextStyle(
                color: colors.canvas,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConflictWarning extends StatelessWidget {
  const _ConflictWarning({required this.conflicts, required this.colors});
  final List<FishingRestriction> conflicts;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.danger.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: colors.textPrimary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reittirajoitus havaittu',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Reittisi kulkee ${conflicts.length} rajoitusalueen läpi.',
                  style: TextStyle(
                    color: colors.textPrimary.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
