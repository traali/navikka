import 'package:drift/drift.dart';

/// Enum defining the vessel class constraints.
/// Stored as string in DB for readability/migration safety.
enum VesselType {
  openBoat, // <5m, strictly limits (Wind 10m/s, Waves 1.0m)
  cabinBoat, // 6-10m, moderate limits (Wind 14m/s, Waves 2.0m)
  sailboat, // Seaworthy, higher wind tolerance (Wind 16m/s, Waves 3.0m)
  ship, // Professional/Large craft context
}

/// Profiles for the user's vessel(s).
/// Used by the AI Guard to calibrate safety alerts.
@DataClassName('VesselProfile')
class VesselProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// User's name for the boat (e.g., "My Buster").
  TextColumn get name => text()();

  /// The hull type which dictates default physical limitations.
  TextColumn get type => textEnum<VesselType>()();

  /// Maximum safe wind speed in m/s.
  /// Anything above this triggers critical "Seek Shelter" alerts.
  RealColumn get maxWindLimit => real()();

  /// Maximum safe significant wave height in meters.
  RealColumn get maxWaveLimit => real()();

  /// Vertical clearance in meters (for under-bridge routing).
  RealColumn get draftDepth => real().nullable()();

  /// Recommended cruising speed in KM/h.
  /// Used for ETA calculations in routing.
  RealColumn get cruisingSpeedKmh => real().withDefault(const Constant(15))();

  /// Is this the currently selected profile?
  BoolColumn get isSelected => boolean().withDefault(const Constant(false))();

  /// Hull Identification Number (HIN / CIN / VIN code).
  TextColumn get hinCode => text().nullable()();

  /// Engine manufacturer (e.g. Volvo Penta, Yanmar, Yamaha, Mercury, Torqeedo).
  TextColumn get engineManufacturer => text().nullable()();

  /// Engine model (e.g. D4-300, F150, 3YM30).
  TextColumn get engineModel => text().nullable()();

  /// Fuel type (e.g. Bensiini, Diesel, Sähkö).
  TextColumn get fuelType => text().nullable()();
}
