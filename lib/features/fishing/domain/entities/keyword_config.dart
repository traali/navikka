// Domain entity for keyword configuration. Must not import Flutter.

/// Configuration for a single fishing restriction category.
class CategoryConfig {
  const CategoryConfig({
    required this.id,
    required this.label,
    required this.keywords,
    required this.colorValue,
    required this.iconName,
  });

  factory CategoryConfig.fromJson(Map<String, dynamic> json) {
    return CategoryConfig(
      id: json['id'] as String,
      label: json['label'] as String,
      keywords: (json['keywords'] as List<dynamic>?)?.cast<String>() ?? [],
      colorValue: _parseColorValue(json['color'] as String?),
      iconName: json['icon'] as String? ?? 'help_outline',
    );
  }
  final String id;
  final String label;
  final List<String> keywords;
  final int colorValue;
  final String iconName;

  static int _parseColorValue(String? hex) {
    if (hex == null || hex.isEmpty) return 0xFF64748B;
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('FF');
    buffer.write(hex.replaceFirst('#', ''));
    return int.parse(buffer.toString(), radix: 16);
  }
}

/// Full remote configuration for keyword-based categorization.
class KeywordConfig {
  const KeywordConfig({
    required this.version,
    required this.categories,
    required this.defaultCategory,
  });

  factory KeywordConfig.fromJson(Map<String, dynamic> json) {
    return KeywordConfig(
      version: json['version'] as int? ?? 1,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      defaultCategory: json['defaultCategory'] != null
          ? CategoryConfig.fromJson(
              json['defaultCategory'] as Map<String, dynamic>,
            )
          : const CategoryConfig(
              id: 'muu',
              label: 'Muu',
              keywords: [],
              colorValue: 0xFF06B6D4,
              iconName: 'help_outline',
            ),
    );
  }
  final int version;
  final List<CategoryConfig> categories;
  final CategoryConfig defaultCategory;

  /// Bundled fallback configuration (matches current hardcoded values).
  static KeywordConfig get fallback => const KeywordConfig(
    version: 1,
    categories: [
      CategoryConfig(
        id: 'verkkorajoitukset',
        label: 'Verkkorajoitukset',
        keywords: ['verkkojen solmuväli', 'verkoissa sallittu'],
        colorValue: 0xFFEF4444,
        iconName: 'grid_on',
      ),
      CategoryConfig(
        id: 'verkkokalastus',
        label: 'Verkkokalastus',
        keywords: ['verkko', 'net'],
        colorValue: 0xFFEF4444,
        iconName: 'grid_on',
      ),
      CategoryConfig(
        id: 'pyydyskalastus',
        label: 'Pyydyskalastus',
        keywords: ['rysä', 'trap', 'katiska'],
        colorValue: 0xFFF59E0B,
        iconName: 'inventory_2',
      ),
      CategoryConfig(
        id: 'veneilyrajoitus',
        label: 'Veneilyrajoitus',
        keywords: ['moottori', 'motor', 'nopeus'],
        colorValue: 0xFF3B82F6,
        iconName: 'anchor',
      ),
      CategoryConfig(
        id: 'kalastuskielto',
        label: 'Kalastuskielto',
        keywords: [
          'kutualue',
          'spawn',
          'kalastusrajoitus',
          'kalastus kielletty',
        ],
        colorValue: 0xFF10B981,
        iconName: 'water_drop',
      ),
    ],
    defaultCategory: CategoryConfig(
      id: 'muu',
      label: 'Muu',
      keywords: [],
      colorValue: 0xFF06B6D4,
      iconName: 'warning_amber_rounded',
    ),
  );
}
