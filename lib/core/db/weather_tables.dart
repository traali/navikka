/// Weather Database Tables - Multi-Provider Architecture
///
/// Normalized SQL schema for weather data from FMI, OpenWeather, and MET Norway.
/// Design incorporates review feedback:
/// - Provider priority for conflict resolution
/// - TTL-aware queries via fetchedAt
/// - Rounded coordinates for unique constraints
/// - Proper cascade/restrict FK actions
library;

import 'package:drift/drift.dart';

// =============================================================================
// LOOKUP TABLES
// =============================================================================

/// Weather data providers (FMI, OpenWeather, MET Norway)
///
/// Priority determines which provider's data wins on conflict:
/// - FMI: 10 (most accurate for Finland/marine)
/// - MET Norway: 5 (good Nordic coverage)
/// - OpenWeather: 3 (global fallback)
class WeatherProviders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()(); // 'fmi', 'openweather', 'met_no'
  TextColumn get name => text()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get apiVersion => text().nullable()(); // e.g., "2.5", "2.0"
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

/// Weather stations and observation points
///
/// Coordinates rounded to 4 decimal places (11m precision) for uniqueness.
/// Name is nullable for coordinate-only providers (OpenWeather, MET).
class WeatherStations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  RealColumn get latitude => real()(); // Rounded to 4dp on insert
  RealColumn get longitude => real()(); // Rounded to 4dp on insert
  TextColumn get stationType => text().customConstraint(
    "NOT NULL CHECK (station_type IN ('weather', 'buoy', 'mareograph', 'water_quality', 'algae'))",
  )(); // 'weather', 'buoy', 'mareograph', 'water_quality', 'algae'

  @override
  List<Set<Column>> get uniqueKeys => [
    {latitude, longitude, stationType},
  ];
}

// =============================================================================
// OBSERVATION TABLES
// =============================================================================

/// Current weather observations
///
/// Superset schema supporting all providers:
/// - Core fields: All providers (temperature, wind, pressure, etc.)
/// - Extended: OpenWeather/MET (feelsLike, dewPoint, uvIndex)
/// - Weather condition: OpenWeather (code, icon, description)
/// - Sun times: OpenWeather (sunrise, sunset)
class WeatherObservations extends Table {
  // Identity
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stationId =>
      integer().references(WeatherStations, #id, onDelete: KeyAction.cascade)();
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();

  // Timestamps
  DateTimeColumn get timestamp => dateTime()(); // Observation time
  DateTimeColumn get fetchedAt => dateTime()(); // When we fetched it

  // Core fields (all providers)
  RealColumn get temperature => real().nullable()();
  RealColumn get windSpeed => real().nullable()();
  RealColumn get windGust => real().nullable()();
  RealColumn get windDirection => real().nullable()();
  RealColumn get pressure => real().nullable()();
  RealColumn get humidity => real().nullable()();
  RealColumn get precipitation => real().nullable()();
  RealColumn get cloudCover => real().nullable()(); // Percentage (0-100)

  // Extended fields (OpenWeather, some MET Norway)
  RealColumn get feelsLike => real().nullable()();
  RealColumn get dewPoint => real().nullable()();
  RealColumn get visibility => real().nullable()();
  RealColumn get uvIndex => real().nullable()();
  RealColumn get snowfall => real().nullable()(); // Separate from rain

  // Weather condition (OpenWeather, FMI wawa)
  IntColumn get weatherCode => integer().nullable()(); // WMO condition code
  TextColumn get weatherIcon => text().nullable()();
  TextColumn get weatherDescription => text().nullable()();

  // Sun times (OpenWeather only)
  DateTimeColumn get sunrise => dateTime().nullable()();
  DateTimeColumn get sunset => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {stationId, timestamp, providerId},
  ];
}

/// Weather forecasts
///
/// Includes issued_at for forecast versioning - same forecast_time can have
/// multiple versions from different model runs.
class WeatherForecasts extends Table {
  // Identity
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stationId =>
      integer().references(WeatherStations, #id, onDelete: KeyAction.cascade)();
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();

  // Timestamps
  DateTimeColumn get forecastTime => dateTime()(); // Valid for this time
  DateTimeColumn get issuedAt => dateTime()(); // When forecast was generated
  DateTimeColumn get fetchedAt => dateTime()(); // When we fetched it

  // Temperature fields
  RealColumn get temperature => real().nullable()();
  RealColumn get temperatureMin => real().nullable()();
  RealColumn get temperatureMax => real().nullable()();
  RealColumn get feelsLike => real().nullable()();

  // Wind fields
  RealColumn get windSpeed => real().nullable()();
  RealColumn get windGust => real().nullable()();
  RealColumn get windDirection => real().nullable()();

  // Other meteorological
  RealColumn get pressure => real().nullable()();
  RealColumn get humidity => real().nullable()();
  RealColumn get dewPoint => real().nullable()();
  RealColumn get precipitation => real().nullable()();
  RealColumn get precipitationProbability => real().nullable()();
  RealColumn get cloudCover => real().nullable()();
  RealColumn get uvIndex => real().nullable()();

  // Weather condition
  TextColumn get weatherIcon => text().nullable()();
  TextColumn get weatherDescription => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {stationId, forecastTime, providerId, issuedAt},
  ];
}

// =============================================================================
// MARINE DATA TABLES (FMI-specific)
// =============================================================================

/// Wave observations from buoys
class WaveObservations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stationId =>
      integer().references(WeatherStations, #id, onDelete: KeyAction.cascade)();
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get timestamp => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  RealColumn get waveHeight => real().nullable()();
  RealColumn get wavePeriod => real().nullable()();
  RealColumn get waveDirection => real().nullable()();
  RealColumn get waterTemperature => real().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {stationId, timestamp, providerId},
  ];
}

/// Sea level readings from mareographs
class SeaLevelReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stationId =>
      integer().references(WeatherStations, #id, onDelete: KeyAction.cascade)();
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get timestamp => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  RealColumn get seaLevelMm => real().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {stationId, timestamp, providerId},
  ];
}

// =============================================================================
// ALERT & EVENT TABLES
// =============================================================================

/// Weather alerts/warnings
///
/// Polygon stored as JSON for simplicity. For spatial queries, filter
/// client-side using GeometryUtils.isPointInPolygon().
class WeatherAlerts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get externalId => text().unique()(); // Provider's unique ID
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get event => text()();
  TextColumn get description => text()();
  TextColumn get severity => text().customConstraint(
    "NOT NULL CHECK (severity IN ('minor', 'moderate', 'severe', 'extreme'))",
  )(); // 'minor', 'moderate', 'severe', 'extreme'
  DateTimeColumn get onset => dateTime()();
  DateTimeColumn get expires => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  TextColumn get polygonJson => text()(); // JSON array of [lat, lon] pairs
  TextColumn get areaDescription => text()();
  TextColumn get source => text().nullable()(); // Alert issuer name
}

/// Lightning strikes (FMI-specific, high volume)
///
/// Retention: 24 hours. Cleanup runs periodically.
/// No station reference - strikes are transient point events.
class LightningStrikes extends Table {
  /// Retention policy: delete strikes older than this
  static const Duration retention = Duration(hours: 24);

  IntColumn get id => integer().autoIncrement()();
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get strikeTime => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get peakCurrentKa => real()();
  IntColumn get multiplicity => integer()();
  BoolColumn get cloudToGround => boolean().nullable()(); // vs cloud-to-cloud

  @override
  List<Set<Column>> get uniqueKeys => [
    {strikeTime, latitude, longitude, providerId},
  ];
}

// =============================================================================
// WATER QUALITY TABLES (SYKE)
// =============================================================================

/// SYKE Water Quality observations from VESLA API
class WaterQualityReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stationId => integer().references(WeatherStations, #id)();
  DateTimeColumn get sampleTime => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();
  RealColumn get dissolvedOxygen => real().nullable()();
  RealColumn get pH => real().nullable()();
  RealColumn get chlorophyllA => real().nullable()();
  RealColumn get turbidity => real().nullable()();
  RealColumn get sampleDepth => real().nullable()();
  TextColumn get lab => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {stationId, sampleTime, providerId},
  ];
}

/// SYKE Algae/Cyanobacteria observations
class AlgaeReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stationId => integer().references(WeatherStations, #id)();
  IntColumn get providerId => integer().references(
    WeatherProviders,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get observationTime => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
  TextColumn get speciesName => text().nullable()();
  RealColumn get biomass => real().nullable()();
  IntColumn get cellCount => integer().nullable()();
  TextColumn get dominantSpecies => text().nullable()();
  IntColumn get riskLevel =>
      integer().nullable()(); // 0=low, 1=moderate, 2=high, 3=veryHigh

  @override
  List<Set<Column>> get uniqueKeys => [
    {stationId, observationTime, providerId},
  ];
}
