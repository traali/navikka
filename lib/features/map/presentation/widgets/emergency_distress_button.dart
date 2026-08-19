import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/widgets/nova_glass_card.dart';
import 'package:url_launcher/url_launcher.dart';

/// Single-tap MRCC Turku emergency distress modal dialog.
///
/// Provides immediate one-tap phone dialing to MRCC Turku (+358 294 1000)
/// and displays real-time GPS coordinates formatted specifically for marine voice radio relay.
class EmergencyDistressDialog extends StatelessWidget {
  const EmergencyDistressDialog({
    required this.currentLocation,
    super.key,
  });

  final LatLng? currentLocation;

  static const String mrccPhone = '+3582941000';
  static const String mrccPhoneDisplay = '0294 1000';

  String _formatDegreesDecimalMinutes(double deg, bool isLat) {
    final abs = deg.abs();
    final d = abs.floor();
    final m = (abs - d) * 60.0;
    final dir = isLat ? (deg >= 0 ? 'N' : 'S') : (deg >= 0 ? 'E' : 'W');
    final mStr = m.toStringAsFixed(3).padLeft(6, '0');
    return "$d° $mStr' $dir";
  }

  @override
  Widget build(BuildContext context) {
    final latStr = currentLocation != null
        ? _formatDegreesDecimalMinutes(currentLocation!.latitude, true)
        : 'NO GPS FIX';
    final lonStr = currentLocation != null
        ? _formatDegreesDecimalMinutes(currentLocation!.longitude, false)
        : 'NO GPS FIX';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: NovaGlassCard(
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.redAccent,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'MRCC TURKU DISTRESS',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 24),

            // Coordinates Display Box for Voice Relay
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(160),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.redAccent.withAlpha(100)),
              ),
              child: Column(
                children: [
                  const Text(
                    'YOUR GPS POSITION (VOICE RELAY)',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white60,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  SelectableText(
                    '$latStr  $lonStr',
                    style: const TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Radio Info Callout
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withAlpha(60),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.radio, color: Colors.cyanAccent, size: 22),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Radio Channel: VHF Ch 16 / DSC Ch 70',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Call MRCC Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final uri = Uri.parse('tel:$mrccPhone');
                try {
                  final launched = await launchUrl(uri);
                  if (!launched && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please dial 0294 1000 manually on your phone.',
                        ),
                      ),
                    );
                  }
                } catch (_) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please dial 0294 1000 manually on your phone.',
                        ),
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.phone_in_talk, size: 22),
              label: const Text(
                'CALL MRCC TURKU ($mrccPhoneDisplay)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
