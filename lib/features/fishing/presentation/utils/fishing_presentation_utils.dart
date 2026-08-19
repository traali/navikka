import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';

/// Presentation utilities for Premium Catch Logger.
///
/// Implements beautiful, species-specific visual categorization in line
/// with the "Night Captain" design system guidelines.
abstract class FishingPresentationUtils {
  /// Returns a rich, premium color gradient for a specific fish species.
  static LinearGradient getSpeciesGradient(FishSpecies species) {
    switch (species) {
      case FishSpecies.ahven: // Olive / Forest Green
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(90, 50, 25), // Warm Olive
            AppPalette.fromHsl(120, 55, 12), // Deep Forest
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.kuha: // Golden Zander
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(45, 95, 45), // Golden Amber
            AppPalette.fromHsl(30, 80, 20), // Dark Gold Bronze
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.hauki: // Deep Emerald Pike
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(155, 75, 25), // Vibrant Emerald
            AppPalette.fromHsl(175, 80, 12), // Deep Forest Teal
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.lohi: // Coral Salmon
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(12, 90, 55), // Bright Coral
            AppPalette.fromHsl(345, 85, 40), // Deep Salmon Rose
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.taimen: // Bronze Trout
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(32, 65, 38), // Copper Bronze
            AppPalette.fromHsl(22, 70, 16), // Dark Earth
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.kirjolohi: // Rainbow Violet
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(275, 85, 50), // Violet Royal
            AppPalette.fromHsl(325, 90, 52), // Electric Magenta
            AppPalette.fromHsl(10, 85, 55), // Rainbow Coral
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.lahna: // Shimmering Slate Bream
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(200, 20, 50), // Metallic Silver
            AppPalette.fromHsl(215, 35, 18), // Deep Steel
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.made: // Muddy Burbot
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(35, 45, 24), // Dark Soil
            AppPalette.fromHsl(68, 50, 14), // Dark Swamp Green
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.siika: // Ice Whitefish
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(195, 80, 75), // Glacier Blue
            AppPalette.fromHsl(210, 30, 42), // Shimmering Silver
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.muikku: // Cyan Shimmer
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(185, 90, 48), // Shimmering Cyan
            AppPalette.fromHsl(215, 85, 22), // Deep Water Blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.sarki: // Silver & Orange Roach
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(205, 15, 55), // Silver Chrome
            AppPalette.fromHsl(16, 90, 45), // Roach Orange/Fin Color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.kiiski: // Sandy Ruffe
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(40, 55, 38), // Sand Gold
            AppPalette.fromHsl(75, 40, 18), // Ruffe Olive
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case FishSpecies.other: // Midnight Slate
        return LinearGradient(
          colors: [
            AppPalette.fromHsl(220, 20, 28), // Slate Grey
            AppPalette.fromHsl(240, 30, 12), // Deep Ocean Midnight
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  /// Returns a beautiful flat glow/badge color corresponding to the species.
  static Color getSpeciesColor(FishSpecies species) {
    switch (species) {
      case FishSpecies.ahven:
        return AppPalette.fromHsl(90, 50, 45);
      case FishSpecies.kuha:
        return AppPalette.fromHsl(45, 95, 45);
      case FishSpecies.hauki:
        return AppPalette.fromHsl(155, 75, 35);
      case FishSpecies.lohi:
        return AppPalette.fromHsl(12, 90, 55);
      case FishSpecies.taimen:
        return AppPalette.fromHsl(32, 65, 45);
      case FishSpecies.kirjolohi:
        return AppPalette.fromHsl(325, 90, 55);
      case FishSpecies.lahna:
        return AppPalette.fromHsl(200, 20, 60);
      case FishSpecies.made:
        return AppPalette.fromHsl(35, 45, 35);
      case FishSpecies.siika:
        return AppPalette.fromHsl(195, 80, 65);
      case FishSpecies.muikku:
        return AppPalette.fromHsl(185, 90, 48);
      case FishSpecies.sarki:
        return AppPalette.fromHsl(16, 90, 50);
      case FishSpecies.kiiski:
        return AppPalette.fromHsl(40, 55, 45);
      case FishSpecies.other:
        return AppPalette.fromHsl(220, 20, 45);
    }
  }

  /// Returns a beautiful weather emoji representing the OpenWeather/SYKE icon code.
  static String getWeatherEmoji(String? iconCode) {
    if (iconCode == null) return '🌡️';
    switch (iconCode) {
      case '01d':
      case '01n':
        return '☀️';
      case '02d':
      case '02n':
        return '⛅';
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return '☁️';
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        return '🌧️';
      case '11d':
      case '11n':
        return '🌩️';
      case '13d':
      case '13n':
        return '❄️';
      case '50d':
      case '50n':
        return '🌫️';
      default:
        return '🌡️';
    }
  }
}
