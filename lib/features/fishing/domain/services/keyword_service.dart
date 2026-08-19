import 'package:sakkoja/features/fishing/domain/entities/keyword_config.dart';

/// Service for categorizing fishing restrictions based on remote configuration.
///
/// This service consumes [KeywordConfig] and provides category lookup,
/// color, and icon resolution for fishing restriction types.
class KeywordService {
  KeywordService(this._config);
  final KeywordConfig _config;

  /// Returns the category label for the given text.
  /// Searches title, description, and type fields.
  String categorize(String title, String? description, String? type) {
    final searchText = [
      title,
      description,
      type,
    ].whereType<String>().join(' ').toLowerCase();

    // Check patterns in order (more specific first due to list ordering)
    for (final category in _config.categories) {
      if (category.keywords.any(
        (kw) => searchText.contains(kw.toLowerCase()),
      )) {
        return category.label;
      }
    }
    return _config.defaultCategory.label;
  }

  /// Returns the color value (int) for a given category label.
  int getColorForCategory(String categoryLabel) {
    final category = _config.categories.firstWhere(
      (c) => c.label == categoryLabel,
      orElse: () => _config.defaultCategory,
    );
    return category.colorValue;
  }

  /// Returns the icon name (String) for a given category label.
  String getIconForCategory(String categoryLabel) {
    final category = _config.categories.firstWhere(
      (c) => c.label == categoryLabel,
      orElse: () => _config.defaultCategory,
    );
    return category.iconName;
  }

  /// Returns the color value for the given text (searches for matching keywords).
  int getColorForText(String? text) {
    if (text == null) return _config.defaultCategory.colorValue;

    final searchText = text.toLowerCase();
    for (final category in _config.categories) {
      if (category.keywords.any(
        (kw) => searchText.contains(kw.toLowerCase()),
      )) {
        return category.colorValue;
      }
    }
    return _config.defaultCategory.colorValue;
  }

  /// Returns the icon name for the given text (searches for matching keywords).
  String getIconForText(String? text) {
    if (text == null) return _config.defaultCategory.iconName;

    final searchText = text.toLowerCase();
    for (final category in _config.categories) {
      if (category.keywords.any(
        (kw) => searchText.contains(kw.toLowerCase()),
      )) {
        return category.iconName;
      }
    }
    return _config.defaultCategory.iconName;
  }
}
