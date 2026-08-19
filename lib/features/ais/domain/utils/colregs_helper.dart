/// Utility for evaluating International Regulations for Preventing Collisions at Sea (COLREGS).
class ColregsHelper {
  /// Evaluates vessel relative status (Give-Way vs Stand-On) based on relative bearing.
  ///
  /// Rule 15 (Crossing Situation):
  /// When two power-driven vessels are crossing so as to involve risk of collision,
  /// the vessel which has the other on her own starboard side (005° to 112.5°) shall keep out of the way (Give-Way).
  ///
  /// Relative bearing is in degrees (0° to 360°) relative to own vessel heading.
  static String getCrossingRole(double relativeBearingDegrees) {
    final normalized = (relativeBearingDegrees % 360 + 360) % 360;

    if (normalized >= 5.0 && normalized <= 112.5) {
      return 'GIVE-WAY VESSEL (Yield Right of Way)';
    } else if (normalized >= 247.5 && normalized <= 355.0) {
      return 'STAND-ON VESSEL (Maintain Course & Speed)';
    } else if (normalized > 112.5 && normalized < 247.5) {
      return 'OVERTAKEN / ASTERN';
    } else {
      return 'HEAD-ON SITUATION (Both Alter Course to Starboard)';
    }
  }

  /// Validates standard 9-digit MMSI (Maritime Mobile Service Identity) format.
  static bool isValidMmsi(dynamic mmsi) {
    if (mmsi == null) return false;
    final str = mmsi.toString().trim();
    if (str.length != 9) return false;
    final val = int.tryParse(str);
    return val != null && val >= 200000000 && val <= 799999999;
  }
}
