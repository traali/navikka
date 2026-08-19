import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';

class AISafetyDisclaimerDialog extends StatelessWidget {
  const AISafetyDisclaimerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.warning, width: 2),
      ),
      icon: Icon(
        Icons.warning_amber_rounded,
        color: colors.warning,
        size: 48,
      ),
      title: Text(
        'Vain lisätilannetiedoksi',
        style: AppTextStyles.h3.copyWith(color: colors.textPrimary),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Virtuaalikapteeni-tekoäly on kokeellinen toiminto, joka tuottaa tilannearvioita luonnollisella kielellä.',
              style: AppTextStyles.body.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 16),
            _buildBullet(
              'Malli voi hallusinoida tai antaa epätarkkoja tietoja.',
              colors,
            ),
            _buildBullet(
              'Ei korvaa virallisia merikarttoja tai viranomaistiedotteita.',
              colors,
            ),
            _buildBullet(
              'Aluksen päällikkö vastaa aina kaikista navigointipäätöksistä.',
              colors,
            ),
            const SizedBox(height: 16),
            Text(
              'Kytkemällä ominaisuuden päälle vahvistat ymmärtäväsi nämä rajoitukset.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Peruuta',
            style: TextStyle(color: colors.textSecondary),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colors.warning,
            foregroundColor: colors.canvas,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'Hyväksyn ja jatka',
            style: TextStyle(
              color: colors.canvas,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBullet(String text, AppThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: colors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(color: colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
