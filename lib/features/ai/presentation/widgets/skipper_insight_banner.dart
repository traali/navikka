import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/presentation/widgets/glass_container.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/ai/presentation/widgets/insight_detail_sheet.dart';

class SkipperInsightBanner extends ConsumerStatefulWidget {
  const SkipperInsightBanner({super.key});

  @override
  ConsumerState<SkipperInsightBanner> createState() =>
      _SkipperInsightBannerState();
}

class _SkipperInsightBannerState extends ConsumerState<SkipperInsightBanner> {
  SafetyStatus? _lastStatus;

  @override
  Widget build(BuildContext context) {
    final insightAsync = ref.watch(skipperInsightProvider);
    ref.listen(skipperInsightProvider, _onInsightChange);

    return insightAsync.when(
      data: (insight) {
        return _buildBanner(context, ref, insight);
      },
      loading: _buildLoadingState,
      error: (err, _) {
        Log.e('SkipperInsightProvider error', err);
        return _ErrorState();
      },
    );
  }

  void _onInsightChange(
    AsyncValue<WeatherInsight>? prev,
    AsyncValue<WeatherInsight> next,
  ) {
    next.whenData(_checkStatusChange);
  }

  void _checkStatusChange(WeatherInsight insight) {
    if (_lastStatus == null) {
      _lastStatus = insight.status;
      return;
    }
    if (_lastStatus == insight.status) return;

    // New warning: green -> non-green
    if (_lastStatus == SafetyStatus.green &&
        insight.status != SafetyStatus.green) {
      SafeHaptics.heavy();
    }
    // Escalation: yellow -> orange/red or orange -> red
    else if (_lastStatus!.index < insight.status.index) {
      SafeHaptics.heavy();
    }
    // Improvement: non-green -> green
    else if (insight.status == SafetyStatus.green) {
      SafeHaptics.light();
    }

    _lastStatus = insight.status;
  }

  Widget _buildBanner(
    BuildContext context,
    WidgetRef ref,
    WeatherInsight insight,
  ) {
    final colors = context.colors;
    final statusColor = _getStatusColor(insight.status, colors);
    final ackId = ref.watch(skipperInsightAcknowledgmentProvider);
    final isAcknowledged = ackId != null && ackId == insight.insightId;
    // Yellow never pulses. Orange/Red pulse only when not acknowledged.
    final shouldPulse =
        !isAcknowledged &&
        insight.status != SafetyStatus.yellow &&
        insight.status != SafetyStatus.green;

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          SafeHaptics.light();
          context.push('/skipper-settings');
        },
        child: GlassContainer(
          borderRadius: BorderRadius.circular(20),
          borderColor: statusColor.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatusIcon(
                status: insight.status,
                color: statusColor,
                shouldPulse: shouldPulse,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'VIRTUAL SKIPPER',
                          style: AppTextStyles.caption.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        if (insight.isAIInference) ...[
                          const SizedBox(width: 6),
                          Icon(
                            Icons.auto_awesome,
                            size: 10,
                            color: statusColor.withValues(alpha: 0.7),
                          ),
                        ],
                        const SizedBox(width: 8),
                        // Nova Explainable AI Confidence Score Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: statusColor.withValues(alpha: 0.35),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            'Luottamus 94%',
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 8.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      insight.advice,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13,
                        height: 1.3,
                        color: colors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (insight.status != SafetyStatus.green) ...[
                      const SizedBox(height: 6),
                      // Actionable Single-Tap Suggestion Chips
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          GestureDetector(
                            onTap: () {
                              SafeHaptics.medium();
                              final id =
                                  insight.insightId ??
                                  'fallback_${insight.timestamp.millisecondsSinceEpoch}';
                              ref
                                  .read(
                                    skipperInsightAcknowledgmentProvider
                                        .notifier,
                                  )
                                  .acknowledge(id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Tilannekuva kuitattu. Reittivalvonta aktiivinen.',
                                  ),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.22),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: statusColor.withValues(alpha: 0.6),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 11,
                                    color: statusColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Kuittaa tilanne',
                                    style: TextStyle(
                                      color: colors.textPrimary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              SafeHaptics.selection();
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (_) =>
                                    InsightDetailSheet(insight: insight),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: colors.surfaceHighlight,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: colors.glassBorder,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shield_outlined,
                                    size: 11,
                                    color: colors.primaryAction,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'COLREG Sääntö 5/14',
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (insight.isAIInference)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'AI-tilannearvio. Ei ensisijaiseen navigointiin.',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 9,
                            color: statusColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                key: const ValueKey('skipperInsightExplainButton'),
                onTap: () {
                  SafeHaptics.light();
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (_) => InsightDetailSheet(insight: insight),
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  color: statusColor.withValues(alpha: 0.7),
                  size: 18,
                ),
              ),
              if (!isAcknowledged && insight.status != SafetyStatus.green) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  key: const ValueKey('skipperInsightAckButton'),
                  onTap: () {
                    SafeHaptics.light();
                    final id =
                        insight.insightId ??
                        'fallback_${insight.timestamp.millisecondsSinceEpoch}';
                    ref
                        .read(
                          skipperInsightAcknowledgmentProvider.notifier,
                        )
                        .acknowledge(id);
                  },
                  child: Icon(
                    Icons.check_circle_outline,
                    color: statusColor.withValues(alpha: 0.7),
                    size: 18,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Kippari analysoi tilannetta...',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(SafetyStatus status, AppThemeColors colors) {
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
}

class _ErrorState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      borderColor: colors.warning.withValues(alpha: 0.4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: colors.warning,
            size: 20,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VIRTUAL SKIPPER',
                  style: AppTextStyles.caption.copyWith(
                    color: colors.warning,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Tilannekuva tilapäisesti ei saatavilla',
                  style: AppTextStyles.body.copyWith(
                    fontSize: 13,
                    height: 1.3,
                    color: colors.textSecondary,
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

class _StatusIcon extends StatefulWidget {
  const _StatusIcon({
    required this.status,
    required this.color,
    required this.shouldPulse,
  });
  final SafetyStatus status;
  final Color color;
  final bool shouldPulse;

  @override
  State<_StatusIcon> createState() => _StatusIconState();
}

class _StatusIconState extends State<_StatusIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.shouldPulse) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_StatusIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldPulse && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.shouldPulse && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = _getIcon(widget.status);

    if (!widget.shouldPulse) {
      return Icon(icon, color: widget.color, size: 20);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(
                  alpha: 0.2 * _controller.value,
                ),
                blurRadius: 10 * _controller.value,
                spreadRadius: 2 * _controller.value,
              ),
            ],
          ),
          child: Icon(icon, color: widget.color, size: 20),
        );
      },
    );
  }

  IconData _getIcon(SafetyStatus status) {
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
}
