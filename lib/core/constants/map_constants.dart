import 'dart:typed_data';

/// Map and data fetching configuration constants
///
/// Centralizes all spatial filtering thresholds to avoid magic numbers
/// scattered across the codebase.
class MapConstants {
  MapConstants._();

  /// A 1x1 transparent PNG image data byte array used as a fallback tile.
  static final Uint8List transparentTile = Uint8List.fromList([
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);

  // === Grid Tile Configuration ===
  // At ~60° latitude (Finland):
  // - 0.1° latitude ≈ 11.1km
  // - 0.2° longitude ≈ 11.1km

  /// Latitude step for grid tiles (degrees)
  static const double gridTileSizeLat = 0.1;

  /// Longitude step for grid tiles (degrees)
  static const double gridTileSizeLng = 0.2;

  // === Map Source URLs ===

  /// Base Map: OpenStreetMap (Standard)
  static const String baseMapUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // === Attributions ===

  static const String osmAttribution = '© OpenStreetMap contributors';

  // === API Fetch Configuration ===

  /// Radius for API bbox queries (km)
  ///
  /// Must cover tile diagonal with buffer:
  /// - Tile diagonal = sqrt(11.1² + 11.1²) / 2 ≈ 7.8km
  /// - Add 1.2km buffer for edge cases
  static const double apiFetchRadiusKm = 9;

  // === Rendering Configuration ===

  /// Distance threshold for rendering zones on map (km)
  ///
  /// Zones beyond this distance from user are not rendered.
  /// Set to 10km to show upcoming zones while navigating.
  static const double renderDistanceKm = 10;

  // === Collision Detection ===

  /// Distance threshold for HUD collision checks (km)
  ///
  /// Only zones within this radius are checked for point-in-polygon.
  /// Kept small (2km) for performance since these checks are expensive.
  static const double collisionCheckRadiusKm = 2;

  // === Fishing Mode ===

  /// Radius for fetching fishing restrictions (km)
  static const double fishingRestrictionFetchRadiusKm = 10;

  /// Radius for fetching waterway features like beacons/buoys (km)
  static const double waterwayFeatureFetchRadiusKm = 5;

  /// Traficom Nautical Chart URL
  static const String marineChartUrl =
      'https://julkinen.traficom.fi/rasteripalvelu/wmts?service=WMTS&request=GetTile&version=1.0.0&layer=Traficom%3AMerikarttasarjat+public&style=default&format=image%2Fpng&TileMatrixSet=WGS84_Pseudo-Mercator&TileMatrix=WGS84_Pseudo-Mercator:{z}&TileRow={y}&TileCol={x}';
}
