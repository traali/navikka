/// Maps Väylävirasto water traffic sign codes to official SVG assets.
class OfficialSignMapper {
  static const _basePath = 'assets/icons/nautical/official/';

  /// Returns the SVG asset path for a given sign type code.
  ///
  /// [typeCode] is the 'vlmlajityyppi' code from the API.
  /// Returns null for sign types we can't render (caller should hide them).
  static String? getAssetPath(String? typeCode) {
    if (typeCode == null) return null;

    return switch (typeCode) {
      // PROHIBITIONS
      '2' || '02' => '${_basePath}prohibition_no_waves.svg',
      '3' || '03' || '5' || '05' => '${_basePath}prohibition_motorboat.svg',
      '4' || '04' => '${_basePath}prohibition_jetski.svg',
      '6' || '06' => '${_basePath}prohibition_anchoring.svg',
      '7' || '07' || '8' || '08' => '${_basePath}prohibition_docking.svg',
      '9' || '09' => '${_basePath}prohibition_overtaking.svg',
      '10' => '${_basePath}prohibition_meeting.svg',
      '12' => '${_basePath}prohibition_waterski.svg',

      // SPEED LIMITS
      '1' ||
      '01' ||
      '11' ||
      '15' ||
      '17' => '${_basePath}limit_speed_frame.svg',

      // DEPTH
      '16' => '${_basePath}limit_depth_frame.svg',

      // WARNINGS
      '13' => '${_basePath}warning_general.svg',
      '14' => '${_basePath}info_phone.svg',
      '27' || '31' || '35' => '${_basePath}warning_cable.svg',
      '32' => '${_basePath}warning_infrastructure.svg',

      // INFO
      '19' || '30' => '${_basePath}info_generic.svg',
      '22' => '${_basePath}info_parking.svg',
      '26' => '${_basePath}info_horn.svg',

      _ => null,
    };
  }

  /// Returns value to display inside the sign.
  ///
  /// For speed limits (01, 11, 15, 17): returns the speed value.
  /// For depth restrictions (16): returns the depth value with 'm' suffix.
  /// Returns null if no value should be displayed.
  static String? getDisplayValue(String? typeCode, String? restrictionValue) {
    if (restrictionValue == null) return null;

    return switch (typeCode) {
      // Speed limits: show value as-is (km/h implied)
      '01' || '11' || '15' || '17' => restrictionValue,
      // Depth restrictions: show value with 'm' suffix
      '16' => '${restrictionValue}m',
      _ => null,
    };
  }
}
