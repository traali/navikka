/// Types of navigation aids in Finnish waterways.
///
/// Based on Väylävirasto classification system.
enum NavigationAidType {
  /// Water traffic sign - regulatory signs (speed limits, prohibitions).
  /// Source: vesivaylatiedot:vesiliikennemerkit_uusi
  trafficSign,

  /// Maritime safety equipment - beacons, buoys, markers.
  /// Source: vesivaylatiedot:turvalaitteet_uusi
  safetyEquipment,

  /// Lighthouse - illuminated navigation aid with light patterns.
  /// Source: vesivaylatiedot:loistot_uusi
  lighthouse,
}

/// Physical mounting type for navigation aids.
enum NavigationAidMounting {
  /// Floating device (buoy, floating beacon).
  floating,

  /// Fixed device mounted on structure or ground.
  fixed,
}
