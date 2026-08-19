import 'package:flutter/material.dart';
import 'package:sakkoja/core/widgets/nova_glass_card.dart';

/// User privacy consent dialog for sending vessel context (location, weather) to OpenRouter AI services.
class AiConsentDialog extends StatelessWidget {
  const AiConsentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: NovaGlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.cyanAccent,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  'AI Telemetry & Privacy',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'The AI Skipper Assistant uses OpenRouter to analyze current weather conditions, sea state, and vessel coordinates.\n\n'
              'No personal identifiers are shared. Do you consent to sending localized weather/GPS context to process AI requests?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Decline',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Accept & Continue',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
