import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/presentation/utils/fishing_colors.dart';

class FishingRestrictionDetailSheet extends StatelessWidget {
  const FishingRestrictionDetailSheet({required this.restrictions, super.key});
  final List<FishingRestriction> restrictions;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.85,
          ),
          decoration: BoxDecoration(
            color: AppTheme.kSurfaceColor.withValues(alpha: 0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(color: AppTheme.kBorderColor),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.kOnGlass.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title if multiple
              if (restrictions.length > 1)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${restrictions.length} Rajoitusta Tällä Alueella',
                    style: TextStyle(
                      color: AppTheme.kOnGlass.withValues(alpha: 0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < restrictions.length; i++) ...[
                        if (i > 0)
                          Divider(
                            color: AppTheme.kOnGlass.withValues(alpha: 0.2),
                            height: 32,
                          ),
                        _RestrictionDetail(restriction: restrictions[i]),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Action Button (Close)
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Sulje'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RestrictionDetail extends StatelessWidget {
  const _RestrictionDetail({required this.restriction});
  final FishingRestriction restriction;

  @override
  Widget build(BuildContext context) {
    final typeColor = FishingColors.getRestrictionColor(restriction.type);
    final typeIcon = FishingColors.getRestrictionIcon(restriction.type);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with Icon
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: typeColor.withValues(alpha: 0.4)),
              ),
              child: Icon(typeIcon, color: typeColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restriction.title,
                    style: const TextStyle(
                      color: AppTheme.kOnGlass,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  if (restriction.type != null)
                    Text(
                      restriction.type!,
                      style: TextStyle(
                        color: typeColor.withValues(alpha: 0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Validity Period
        if (restriction.validity != null &&
            restriction.validity!.isNotEmpty) ...[
          Text(
            'VOIMASSAOLO',
            style: TextStyle(
              color: AppTheme.kOnGlass.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: AppTheme.kOnGlass.withValues(alpha: 0.7),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                restriction.validity!,
                style: const TextStyle(
                  color: AppTheme.kOnGlass,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],

        // Description
        if (restriction.description != null &&
            restriction.description!.isNotEmpty) ...[
          Text(
            'LISÄTIEDOT',
            style: TextStyle(
              color: AppTheme.kOnGlass.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              restriction.description!,
              style: const TextStyle(
                color: AppTheme.kOnGlass,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
