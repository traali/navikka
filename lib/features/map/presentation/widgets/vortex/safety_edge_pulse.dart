import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';

class SafetyEdgePulse extends ConsumerStatefulWidget {
  const SafetyEdgePulse({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<SafetyEdgePulse> createState() => _SafetyEdgePulseState();
}

class _SafetyEdgePulseState extends ConsumerState<SafetyEdgePulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final insight = ref.read(skipperInsightProvider).asData?.value;
        if (insight != null) _updateAnimation(insight.status);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateAnimation(SafetyStatus status) {
    if (status == SafetyStatus.green) {
      if (_controller.isAnimating) _controller.stop();
    } else {
      if (!_controller.isAnimating) _controller.repeat(reverse: true);
    }
  }

  void _onInsightChange(
    AsyncValue<WeatherInsight>? prev,
    AsyncValue<WeatherInsight> next,
  ) {
    next.whenData((insight) => _updateAnimation(insight.status));
  }

  @override
  Widget build(BuildContext context) {
    final insightAsync = ref.watch(skipperInsightProvider);
    ref.listen(skipperInsightProvider, _onInsightChange);

    return insightAsync.maybeWhen(
      data: (insight) {
        if (insight.status == SafetyStatus.green) {
          return widget.child;
        }

        final Color alertColor = switch (insight.status) {
          SafetyStatus.yellow || SafetyStatus.orange => AppPalette.warning,
          SafetyStatus.red => AppPalette.danger,
          _ => Colors.transparent,
        };

        return Stack(
          children: [
            widget.child,
            IgnorePointer(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: alertColor.withValues(
                          alpha: 0.5 * _animation.value,
                        ),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: alertColor.withValues(
                            alpha: 0.3 * _animation.value,
                          ),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      orElse: () => widget.child,
    );
  }
}
