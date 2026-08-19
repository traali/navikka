import 'package:meta/meta.dart';

/// Available satellite imagery modes.
enum SatelliteMode {
  /// Copernicus Sentinel-2 optical imagery (True color, 10m resolution).
  sentinel2('Sentinel-2', 'Copernicus optinen 10m'),

  /// FMI / EUMETSAT Meteosat live weather satellite (updated every 15 min).
  eumetsat('EUMETSAT Sää', 'Pilvipeite & sääsatelliitti (15 min)'),

  /// High-resolution optical satellite basemap (ESRI World Imagery).
  highResBasemap('HD Satelliitti', 'Korkearesoluutioinen ortokuva');

  const SatelliteMode(this.label, this.description);
  final String label;
  final String description;
}

/// Optical presets for Copernicus Sentinel-2.
enum SentinelPreset {
  /// True Color RGB (B04, B03, B02) - Natural coastal view.
  trueColor('Luonnonväri', 'Todelliset luonnolliset värit'),

  /// Water & Algae Index (NDWI / Chlorophyll highlight).
  waterIndex('Vesi & Levät', 'Korostaa matalikot ja leväalueet'),

  /// Cloudless seasonal composite.
  cloudless('Pilvetön mosaiikki', 'Selkeä pilvetön rannikkonäkymä');

  const SentinelPreset(this.label, this.description);
  final String label;
  final String description;
}

/// Meteorological presets for EUMETSAT.
enum EumetsatPreset {
  /// Day Natural color composite (clouds, land, sea).
  dayNatural('Päiväväri (RGB)', 'Luonnollinen pilvi- ja lumikuva'),

  /// High-Resolution Visible (HRV) for cloud structure and storm tops.
  cloudStructure('Pilvirakenne (HRV)', 'Tarkat pilvilautat ja ukkosrintamat'),

  /// Fog and low stratus cloud detection.
  fogDetection('Sumu & Matalapilvi', 'Sumualueiden ja matalapilven tunnistus');

  const EumetsatPreset(this.label, this.description);
  final String label;
  final String description;
}

/// Immutable state for the Satellite Screen.
@immutable
class SatelliteState {
  const SatelliteState({
    required this.mode,
    required this.sentinelPreset,
    required this.eumetsatPreset,
    required this.showNauticalOverlay,
    required this.nauticalOverlayOpacity,
    required this.availableTimestamps,
    required this.currentTimestampIndex,
    required this.isPlaying,
  });

  factory SatelliteState.initial() {
    return const SatelliteState(
      mode: SatelliteMode.sentinel2,
      sentinelPreset: SentinelPreset.trueColor,
      eumetsatPreset: EumetsatPreset.dayNatural,
      showNauticalOverlay: true,
      nauticalOverlayOpacity: 0.85,
      availableTimestamps: [],
      currentTimestampIndex: 0,
      isPlaying: false,
    );
  }

  final SatelliteMode mode;
  final SentinelPreset sentinelPreset;
  final EumetsatPreset eumetsatPreset;
  final bool showNauticalOverlay;
  final double nauticalOverlayOpacity;
  final List<DateTime> availableTimestamps;
  final int currentTimestampIndex;
  final bool isPlaying;

  DateTime? get currentTimestamp {
    if (availableTimestamps.isEmpty) return null;
    if (currentTimestampIndex < 0 ||
        currentTimestampIndex >= availableTimestamps.length) {
      return availableTimestamps.last;
    }
    return availableTimestamps[currentTimestampIndex];
  }

  SatelliteState copyWith({
    SatelliteMode? mode,
    SentinelPreset? sentinelPreset,
    EumetsatPreset? eumetsatPreset,
    bool? showNauticalOverlay,
    double? nauticalOverlayOpacity,
    List<DateTime>? availableTimestamps,
    int? currentTimestampIndex,
    bool? isPlaying,
  }) {
    return SatelliteState(
      mode: mode ?? this.mode,
      sentinelPreset: sentinelPreset ?? this.sentinelPreset,
      eumetsatPreset: eumetsatPreset ?? this.eumetsatPreset,
      showNauticalOverlay: showNauticalOverlay ?? this.showNauticalOverlay,
      nauticalOverlayOpacity:
          nauticalOverlayOpacity ?? this.nauticalOverlayOpacity,
      availableTimestamps: availableTimestamps ?? this.availableTimestamps,
      currentTimestampIndex:
          currentTimestampIndex ?? this.currentTimestampIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
