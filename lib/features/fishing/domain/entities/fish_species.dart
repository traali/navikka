/// Finnish fish species commonly caught in Finnish waters.
///
/// Extensible enum for recording catches.
enum FishSpecies {
  ahven('Ahven', '🐟'), // Perch
  hauki('Hauki', '🐊'), // Pike
  kuha('Kuha', '🐠'), // Zander / Pikeperch
  lahna('Lahna', '🐡'), // Bream
  made('Made', '🐍'), // Burbot
  lohi('Lohi', '🐟'), // Salmon
  taimen('Taimen', '🐟'), // Trout
  siika('Siika', '🐟'), // Whitefish
  kirjolohi('Kirjolohi', '🌈'), // Rainbow trout
  muikku('Muikku', '🐟'), // Vendace
  sarki('Särki', '🐟'), // Roach
  kiiski('Kiiski', '🐟'), // Ruffe
  other('Muu', '❓'); // Other / Unknown

  final String displayName;
  final String emoji;

  const FishSpecies(this.displayName, this.emoji);

  /// Get species from string name (case-insensitive).
  static FishSpecies? fromName(String name) {
    final lowerName = name.toLowerCase();
    for (final species in FishSpecies.values) {
      if (species.name.toLowerCase() == lowerName ||
          species.displayName.toLowerCase() == lowerName) {
        return species;
      }
    }
    return null;
  }
}

/// Fishing methods for categorizing how the fish was caught.
enum FishingMethod {
  trolling('Vetouistelu'),
  spinning('Heittouistelu'),
  jigging('Pilkintä'),
  flyfishing('Perhokalastus'),
  netting('Verkkokalastus'),
  other('Muu');

  final String displayName;

  const FishingMethod(this.displayName);
}
