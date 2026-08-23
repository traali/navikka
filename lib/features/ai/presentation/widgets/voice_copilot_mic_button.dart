import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/services/voice_copilot_service.dart';

class VoiceCopilotMicButton extends StatefulWidget {
  const VoiceCopilotMicButton({super.key});

  @override
  State<VoiceCopilotMicButton> createState() => _VoiceCopilotMicButtonState();
}

class _VoiceCopilotMicButtonState extends State<VoiceCopilotMicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  VoiceCommandResult? _lastResult;

  final List<String> _quickCommands = [
    'Kuinka paljon vettä on kapeikossa?',
    'Mikä on lähin suojaisa satama?',
    'Merkitse hyvä ankkuripohja',
    'Mikä on tuuliennuste?',
    'How deep is the fairway?',
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showVoiceModal(BuildContext context) {
    final colors = context.colors;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, color: colors.primaryAction),
                      const SizedBox(width: 8),
                      Text(
                        'HEI KIPPARI / HEY SKIPPER',
                        style: AppTextStyles.h4.copyWith(
                          color: colors.primaryAction,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pikakomennot — ei mikrofoni. Napauta sirua.',
                    style: AppTextStyles.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_lastResult != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.primaryAction.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colors.primaryAction.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"${_lastResult!.rawTranscript}"',
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _lastResult!.responseMessage,
                            style: TextStyle(
                              color: colors.primaryAction,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    'Kokeile komentoa:',
                    style: TextStyle(color: colors.textSecondary, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: _quickCommands.map((cmd) {
                      return ActionChip(
                        label: Text(cmd),
                        backgroundColor: colors.surfaceHighlight,
                        labelStyle: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 11,
                        ),
                        onPressed: () {
                          final res = VoiceCopilotService.parseSpeech(cmd);
                          setModalState(() {
                            _lastResult = res;
                          });
                          setState(() {
                            _lastResult = res;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return FloatingActionButton.small(
      heroTag: 'voice_copilot_fab',
      backgroundColor: colors.surface,
      foregroundColor: colors.primaryAction,
      shape: CircleBorder(
        side: BorderSide(
          color: colors.primaryAction.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      tooltip: 'Hei Kippari (pikakomennot, ei mikki)',
      onPressed: () => _showVoiceModal(context),
      child: const Icon(Icons.mic, size: 20),
    );
  }
}
