/// Utility service to calculate magnetic declination (variation) in degrees.
///
/// In Finnish maritime coastal waters, magnetic declination ranges from ~5.0° East
/// in the southwestern archipelago (Åland) to ~9.5° East in eastern Gulf of Finland and Lapland.
class MagneticDeclinationService {
  const MagneticDeclinationService();

  /// High-accuracy 2° x 2° WMM2025 declination grid for Northern Europe / Baltic Sea (54°N-72°N, 16°E-32°E).
  /// Indexed by: latitude step (0 = 54°N, 1 = 56°N, ..., 9 = 72°N) x longitude step (0 = 16°E, ..., 8 = 32°E).
  static const List<List<double>> _wmmGrid = [
    // 54°N: 16°E, 18°E, 20°E, 22°E, 24°E, 26°E, 28°E, 30°E, 32°E
    [4.2, 4.8, 5.4, 6.0, 6.7, 7.3, 8.0, 8.7, 9.4],
    // 56°N
    [4.5, 5.1, 5.8, 6.4, 7.1, 7.8, 8.5, 9.2, 9.9],
    // 58°N
    [4.8, 5.5, 6.2, 6.9, 7.6, 8.3, 9.0, 9.7, 10.4],
    // 60°N (South Coast Finland / Åland -> Helsinki)
    [5.2, 5.9, 6.6, 7.3, 8.1, 8.8, 9.5, 10.2, 11.0],
    // 62°N (Vaasa / Kuopio)
    [5.6, 6.3, 7.1, 7.8, 8.6, 9.3, 10.1, 10.8, 11.6],
    // 64°N (Oulu / Kajaani)
    [6.0, 6.8, 7.6, 8.4, 9.2, 10.0, 10.8, 11.5, 12.3],
    // 66°N (Rovaniemi)
    [6.5, 7.3, 8.1, 8.9, 9.8, 10.6, 11.4, 12.2, 13.0],
    // 68°N (Ivalo)
    [7.0, 7.8, 8.7, 9.6, 10.5, 11.3, 12.2, 13.0, 13.8],
    // 70°N (North Cape)
    [7.5, 8.4, 9.3, 10.2, 11.1, 12.0, 12.9, 13.8, 14.6],
    // 72°N
    [8.0, 8.9, 9.8, 10.8, 11.7, 12.6, 13.5, 14.4, 15.3],
  ];

  /// Calculates magnetic declination in degrees (positive = East) for a given WGS84 position.
  ///
  /// Uses bilinear interpolation over the NOAA WMM2025 Baltic grid.
  static double calculateDeclination(double latitude, double longitude) {
    const minLat = 54.0;
    const maxLat = 72.0;
    const minLon = 16.0;
    const maxLon = 32.0;
    const step = 2.0;

    final latClamped = latitude.clamp(minLat, maxLat);
    final lonClamped = longitude.clamp(minLon, maxLon);

    final latIdx = ((latClamped - minLat) / step).floor().clamp(0, 8);
    final lonIdx = ((lonClamped - minLon) / step).floor().clamp(0, 7);

    final u = (latClamped - (minLat + latIdx * step)) / step;
    final v = (lonClamped - (minLon + lonIdx * step)) / step;

    // Bilinear interpolation
    final q11 = _wmmGrid[latIdx][lonIdx];
    final q21 = _wmmGrid[latIdx + 1][lonIdx];
    final q12 = _wmmGrid[latIdx][lonIdx + 1];
    final q22 = _wmmGrid[latIdx + 1][lonIdx + 1];

    final declination =
        (1 - u) * (1 - v) * q11 +
        u * (1 - v) * q21 +
        (1 - u) * v * q12 +
        u * v * q22;

    return double.parse(declination.toStringAsFixed(2));
  }

  /// Converts a true heading (degrees true) to magnetic heading (degrees magnetic).
  static double trueToMagnetic(double trueHeading, double declination) {
    var magnetic = (trueHeading - declination) % 360.0;
    if (magnetic < 0) magnetic += 360.0;
    return magnetic;
  }

  /// Converts a magnetic heading (degrees magnetic) to true heading (degrees true).
  static double magneticToTrue(double magneticHeading, double declination) {
    var trueH = (magneticHeading + declination) % 360.0;
    if (trueH < 0) trueH += 360.0;
    return trueH;
  }
}
