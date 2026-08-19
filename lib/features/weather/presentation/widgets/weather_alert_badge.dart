import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/providers/weather_alert_dismissal_provider.dart';

class WeatherAlertBadge extends ConsumerWidget {
  const WeatherAlertBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(
      pointWeatherControllerProvider.select((state) => state.activeAlerts),
    );
    final dismissedAlerts = ref.watch(weatherAlertDismissalProvider);

    // Filter out alerts acknowledged by the skipper
    final visibleAlerts = alerts
        .where((a) => !dismissedAlerts.contains('${a.event}_${a.description}'))
        .toList();

    if (visibleAlerts.isEmpty) return const SizedBox.shrink();

    return WeatherAlertBadgeContent(
      count: visibleAlerts.length,
      onTap: () => _showAlertDetails(context, ref, visibleAlerts),
    );
  }

  void _showAlertDetails(
    BuildContext context,
    WidgetRef ref,
    List<WeatherAlert> alerts,
  ) {
    final colors = context.colors;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.sizeOf(context).height * 0.65,
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.border, width: 1.5)),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: colors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Säähälytykset (${alerts.length})',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primaryAction,
                    foregroundColor: colors.canvas,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    final keys = alerts.map(
                      (a) => '${a.event}_${a.description}',
                    );
                    ref
                        .read(weatherAlertDismissalProvider.notifier)
                        .dismissAllAlerts(keys);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.done_all_rounded, size: 16),
                  label: const Text(
                    'Kuittaa kaikki',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: alerts.length,
                separatorBuilder: (context, index) => Divider(
                  color: colors.border.withValues(alpha: 0.3),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  final alertKey = '${alert.event}_${alert.description}';
                  final onsetStr =
                      '${alert.onset.day}.${alert.onset.month}. klo ${alert.onset.hour.toString().padLeft(2, '0')}:${alert.onset.minute.toString().padLeft(2, '0')}';
                  final expiresStr =
                      '${alert.expires.day}.${alert.expires.month}. klo ${alert.expires.hour.toString().padLeft(2, '0')}:${alert.expires.minute.toString().padLeft(2, '0')}';
                  final issuedStr = alert.issued != null
                      ? '${alert.issued!.day}.${alert.issued!.month}. klo ${alert.issued!.hour.toString().padLeft(2, '0')}:${alert.issued!.minute.toString().padLeft(2, '0')}'
                      : null;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        alert.event,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (alert.areaDescription.isNotEmpty) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  size: 12,
                                  color: colors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Alue: ${alert.areaDescription}',
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                          ],
                          Text(
                            alert.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (issuedStr != null) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.edit_calendar_rounded,
                                  size: 12,
                                  color: colors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Annettu: $issuedStr',
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                          ],
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 12,
                                color: colors.primaryAction,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Voimassa: $onsetStr – $expiresStr',
                                  style: TextStyle(
                                    color: colors.primaryAction,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        tooltip: 'Kuittaa hälytys',
                        icon: Icon(
                          Icons.check_circle_outline_rounded,
                          color: colors.textSecondary,
                        ),
                        onPressed: () {
                          ref
                              .read(weatherAlertDismissalProvider.notifier)
                              .dismissAlert(alertKey);
                        },
                      ),
                      onTap: () => _openAlertDetailDialog(
                        context,
                        ref,
                        alert,
                        alertKey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAlertDetailDialog(
    BuildContext context,
    WidgetRef ref,
    WeatherAlert alert,
    String alertKey,
  ) {
    final colors = context.colors;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: colors.danger),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                alert.event,
                style: TextStyle(color: colors.textPrimary),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (alert.areaDescription.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 14,
                      color: colors.primaryAction,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Alue: ${alert.areaDescription}',
                        style: TextStyle(
                          color: colors.primaryAction,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              if (alert.issued != null) ...[
                Row(
                  children: [
                    Icon(
                      Icons.edit_calendar_rounded,
                      size: 14,
                      color: colors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Annettu: ${alert.issued!.day}.${alert.issued!.month}. klo ${alert.issued!.hour.toString().padLeft(2, '0')}:${alert.issued!.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: colors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Voimassa: ${alert.onset.day}.${alert.onset.month}. klo ${alert.onset.hour.toString().padLeft(2, '0')}:${alert.onset.minute.toString().padLeft(2, '0')} – ${alert.expires.day}.${alert.expires.month}. klo ${alert.expires.hour.toString().padLeft(2, '0')}:${alert.expires.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                alert.description.isNotEmpty
                    ? alert.description
                    : 'Ei lisätietoja saatavilla.',
                style: TextStyle(color: colors.textPrimary, height: 1.4),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Sulje'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.danger,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              ref
                  .read(weatherAlertDismissalProvider.notifier)
                  .dismissAlert(alertKey);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close bottom sheet
            },
            icon: const Icon(Icons.check, size: 18),
            label: const Text('Kuittaa hälytys'),
          ),
        ],
      ),
    );
  }
}

class WeatherAlertBadgeContent extends StatelessWidget {
  const WeatherAlertBadgeContent({
    required this.count,
    required this.onTap,
    super.key,
  });
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final badgeColor = colors.danger;
    final borderRadius = BorderRadius.circular(16);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.25),
                borderRadius: borderRadius,
                border: Border.all(color: badgeColor, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: badgeColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/nautical/warning_signal.svg',
                    colorFilter: ColorFilter.mode(
                      colors.textPrimary,
                      BlendMode.srcIn,
                    ),
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${count.toString().padLeft(2, '0')} ${count == 1 ? 'VAROITUS' : 'VAROITUSTA'}',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
