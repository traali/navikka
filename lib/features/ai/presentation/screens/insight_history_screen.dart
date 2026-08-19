import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/ai/presentation/widgets/insight_detail_sheet.dart';

class InsightHistoryScreen extends ConsumerWidget {
  const InsightHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final history = ref.watch(insightHistoryProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        title: Text(
          'Tilannekuvahistoria',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
      ),
      body: history.isEmpty
          ? Center(
              child: Text(
                'Ei vielä tilannekuvamerkintöjä.\nVaroitukset ja suositukset näkyvät tässä.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final insight = history[index];
                return _HistoryTile(insight: insight);
              },
            ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.insight});
  final WeatherInsight insight;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final statusColor = _statusColor(insight.status, colors);

    return Card(
      color: colors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colors.glassBorder),
      ),
      child: ListTile(
        leading: Icon(
          _statusIcon(insight.status),
          color: statusColor,
        ),
        title: Text(
          _statusLabel(insight.status),
          style: AppTextStyles.body.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          insight.advice,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption.copyWith(color: colors.textPrimary),
        ),
        trailing: Text(
          _formatTime(insight.timestamp),
          style: AppTextStyles.caption.copyWith(
            color: colors.textSecondary,
          ),
        ),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) => InsightDetailSheet(insight: insight),
          );
        },
      ),
    );
  }

  String _statusLabel(SafetyStatus status) {
    switch (status) {
      case SafetyStatus.green:
        return 'NORMAALI';
      case SafetyStatus.yellow:
        return 'HUOMIO';
      case SafetyStatus.orange:
        return 'VAROITUS';
      case SafetyStatus.red:
        return 'KRIITTINEN';
    }
  }

  Color _statusColor(SafetyStatus status, AppThemeColors colors) {
    switch (status) {
      case SafetyStatus.green:
        return colors.success;
      case SafetyStatus.yellow:
      case SafetyStatus.orange:
        return colors.warning;
      case SafetyStatus.red:
        return colors.danger;
    }
  }

  IconData _statusIcon(SafetyStatus status) {
    switch (status) {
      case SafetyStatus.green:
        return Icons.check_circle_outline;
      case SafetyStatus.yellow:
        return Icons.info_outline;
      case SafetyStatus.orange:
        return Icons.warning_amber_rounded;
      case SafetyStatus.red:
        return Icons.dangerous_outlined;
    }
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
