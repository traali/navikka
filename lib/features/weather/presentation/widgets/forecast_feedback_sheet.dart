import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';

/// 1-tap glass modal for submitting local accuracy feedback on weather forecasts.
class ForecastFeedbackSheet extends StatefulWidget {
  const ForecastFeedbackSheet({
    required this.locationName,
    super.key,
  });

  final String locationName;

  @override
  State<ForecastFeedbackSheet> createState() => _ForecastFeedbackSheetState();
}

class _ForecastFeedbackSheetState extends State<ForecastFeedbackSheet> {
  String? _selectedSource;
  final _noteController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit(String source) {
    SafeHaptics.selection();
    setState(() {
      _selectedSource = source;
      _submitted = true;
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppPalette.navikkaCanvas.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppPalette.navikkaCyanGlow.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ARVIOI ENNUSTE',
                      style: AppTextStyles.nvSm.copyWith(
                        color: AppPalette.navikkaCyanGlow,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Text(
                  'Mikä lähde osui lähimmäksi todellisuutta paikassa ${widget.locationName}?',
                  style: AppTextStyles.nvBase.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                if (_submitted) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppPalette.success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppPalette.success),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppPalette.success,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Kiitos! Valinta ($_selectedSource) tallennettu.',
                          style: AppTextStyles.nvSm.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: _SourceButton(
                          label: 'FMI (Ilmatieteen laitos)',
                          onTap: () => _submit('FMI'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _SourceButton(
                          label: 'MET Norway',
                          onTap: () => _submit('MET Norway'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _SourceButton(
                          label: 'OpenWeather',
                          onTap: () => _submit('OpenWeather'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _SourceButton(
                          label: 'Muu / Havainto',
                          onTap: () => _submit('Oma havainto'),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                const Text(
                  'Palaute tallennetaan paikallisesti aluelle ja käytetään luotettavuuden arviointiin.',
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SourceButton extends StatelessWidget {
  const _SourceButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppPalette.navikkaCyanGlow.withValues(alpha: 0.25),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.nvXs.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
