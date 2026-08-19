/// Navigation Aids Constants
///
/// WFS layer names, API endpoints, and cache settings for
/// Väylävirasto maritime navigation data.
library;

/// Constants for navigation aids feature.
///
/// Per AGENTS.md Section 11: No magic numbers. All thresholds in constants.
class NavigationAidsConstants {
  NavigationAidsConstants._();

  // ---------------------------------------------------------------------------
  // API Endpoints
  // ---------------------------------------------------------------------------

  /// Väylävirasto WFS base URL for waterway data.
  static const String baseUrl =
      'https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs';

  // ---------------------------------------------------------------------------
  // WFS Layer Names (vesivaylatiedot namespace)
  // ---------------------------------------------------------------------------

  /// Fairway areas - navigable channel polygons with depth info.
  static const String layerFairwayAreas = 'vesivaylatiedot:vaylaalueet_uusi';

  /// Navigation lines - fairway centerlines and boating routes.
  static const String layerNavigationLines =
      'vesivaylatiedot:navigointilinjat_uusi';

  /// Water traffic signs - regulatory signs (speed limits, prohibitions).
  static const String layerTrafficSigns =
      'vesivaylatiedot:vesiliikennemerkit_uusi';

  /// Maritime safety equipment - beacons, buoys (floating/fixed).
  static const String layerSafetyEquipment =
      'vesivaylatiedot:turvalaitteet_uusi';

  /// Lighthouses - illuminated navigation aids with light patterns.
  static const String layerLighthouses = 'vesivaylatiedot:loistot_uusi';

  // ---------------------------------------------------------------------------
  // Cache Settings
  // ---------------------------------------------------------------------------

  /// How long cached data remains valid before refresh.
  static const Duration cacheValidity = Duration(days: 7);

  /// Sembast store names for local caching.
  static const String storeFairwayAreas = 'navigation_aids_fairway_areas';
  static const String storeNavigationLines = 'navigation_aids_navigation_lines';
  static const String storeTrafficSigns = 'navigation_aids_traffic_signs';
  static const String storeSafetyEquipment = 'navigation_aids_safety_equipment';
  static const String storeLighthouses = 'navigation_aids_lighthouses';

  // ---------------------------------------------------------------------------
  // Pagination & Performance
  // ---------------------------------------------------------------------------

  /// Maximum features per WFS request page.
  static const int pageSize = 500;

  /// Viewport buffer radius in kilometers.
  /// Features within this buffer beyond visible area are preloaded.
  static const double viewportBufferKm = 30;

  /// Minimum zoom level to display navigation aids (avoid clutter when zoomed out).
  static const double minDisplayZoom = 10;

  // ---------------------------------------------------------------------------
  // LOD Zoom Thresholds (Progressive Visibility)
  // ---------------------------------------------------------------------------

  /// Zoom level to show lighthouses (most important, visible first).
  static const double zoomShowLighthouses = 9;

  /// Zoom level to show traffic signs (speed limits, prohibitions).
  static const double zoomShowTrafficSigns = 12.5;

  /// Zoom level to show major buoys (cardinals, isolated danger, safe water).
  static const double zoomShowMajorBuoys = 10.5;

  /// Zoom level to show all safety equipment (full detail: lateral spars, beacons).
  static const double zoomShowAllEquipment = 11.5;

  /// Zoom level to switch from DOTS (circles) to detailed SVG symbols.
  static const double zoomShowDetailedSymbols = 12;

  /// Zoom level to show fairway areas.
  static const double zoomShowFairwayAreas = 12;

  /// Zoom level to show navigation lines (default fallback).
  static const double zoomShowNavigationLines = 10;

  /// Zoom levels for navigation line classes (Option 1: Hierarchy)
  /// - Class 1-2: Merchant Channels (Highways)
  /// - Class 3-4: Main Boating Routes (Roads)
  /// - Class 5-6: Local Trails (Tracks)
  static const double zoomShowLineClass1_2 = 10;
  static const double zoomShowLineClass3_4 = 12;
  static const double zoomShowLineClass5_6 = 14;

  /// Zoom level to show depth labels for lines
  /// Major routes show labels earlier than minor trails.
  /// INCREASED: Major 12.0 -> 13.5, Minor 14.0 -> 15.0 to reduce clutter.
  static const double zoomShowLineLabelsMajor = 13.5;
  static const double zoomShowLineLabelsMinor = 15;

  /// Optical range thresholds for lighthouses at low/medium zoom.
  static const double minMajorLighthouseRangeNm = 10;
  static const double minMidLighthouseRangeNm = 4;

  /// IALA codes for major buoys (shown at medium zoom).
  /// 1-2: Lateral marks (Port/Starboard)
  /// 3-6: Cardinal marks (N/S/W/E)
  /// 7: Isolated danger
  /// 8: Safe water
  static const List<String> majorBuoyCodes = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
  ];
}
