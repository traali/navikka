import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_theme.dart';

class FishingColors {
  static const Color netRestriction = Color(0xFFEF4444); // Red
  static const Color trapRestriction = Color(0xFFF59E0B); // Amber
  static const Color seasonalRestriction = Color(0xFF10B981); // Emerald
  static const Color mooringRestriction = Color(0xFF3B82F6); // Blue
  static const Color defaultRestriction = Color(0xFF64748B); // Slate

  static Color getRestrictionColor(String? type) {
    if (type == null) return defaultRestriction;

    final t = type.toLowerCase();
    if (t.contains('verkko') || t.contains('net')) return AppTheme.kVibrantRed;
    if (t.contains('rysä') || t.contains('trap') || t.contains('katiska')) {
      return trapRestriction;
    }
    if (t.contains('kutualue') ||
        t.contains('spawn') ||
        t.contains('kalastusrajoitus') ||
        t.contains('kalastus kielletty')) {
      return AppTheme.kVibrantEmerald;
    }
    if (t.contains('kiinnittyminen') ||
        t.contains('mooring') ||
        t.contains('ankkurointi') ||
        t.contains('moottorivoim') ||
        t.contains('nopeus')) {
      return AppTheme.kVibrantBlue;
    }

    return AppTheme.kTechCyan;
  }

  /// Optimized color lookup using cached category
  static Color getColorForCategory(String category) {
    switch (category) {
      case 'Verkkorajoitukset':
      case 'Verkkokalastus':
        return AppTheme.kVibrantRed;
      case 'Pyydyskalastus':
        return trapRestriction;
      case 'Kalastuskielto':
        return AppTheme.kVibrantEmerald;
      case 'Luonnonsuojelualue':
        return const Color(0xFFA855F7); // Purple
      case 'Erityiskalastusalue':
        return const Color(0xFFEAB308); // Gold/Yellow
      case 'Veneilyrajoitus':
        return AppTheme.kVibrantBlue;
      default:
        return AppTheme.kTechCyan;
    }
  }

  static IconData getRestrictionIcon(String? type) {
    if (type == null) return Icons.help_outline;

    final t = type.toLowerCase();
    if (t.contains('verkko') || t.contains('net')) return Icons.grid_on;
    if (t.contains('rysä') || t.contains('trap')) return Icons.inventory_2;
    if (t.contains('kutualue') || t.contains('spawn')) return Icons.water_drop;
    if (t.contains('kiinnittyminen') || t.contains('mooring')) {
      return Icons.anchor;
    }

    return Icons.warning_amber_rounded;
  }
}
