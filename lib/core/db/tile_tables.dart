import 'package:drift/drift.dart';

/// Tiles for marine map rendering
///
/// Composite index on (zoom, x, y) is mandatory for O(1) rendering performance.
class MarineMapTiles extends Table {
  IntColumn get zoom => integer()();
  IntColumn get x => integer()();
  IntColumn get y => integer()();
  BlobColumn get tileData => blob()();

  /// Number of offline regions that use this tile.
  /// Tile is deleted only when refCount reaches 0.
  IntColumn get refCount => integer().withDefault(const Constant(1))();

  /// For LRU caching if we ever implement soft-cache limits
  DateTimeColumn get lastAccessed =>
      dateTime().withDefault(currentDateAndTime)();

  /// Identifier for the map source (e.g. URL template or source name)
  TextColumn get sourceId => text()();

  /// Optional MD5 hash for integrity checks
  TextColumn get md5Hash => text().nullable()();

  @override
  Set<Column> get primaryKey => {zoom, x, y, sourceId};
}

/// Metadata for user-defined offline areas
class OfflineRegions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  // Bounding box for "What's downloaded here?" queries
  RealColumn get minLat => real()();
  RealColumn get maxLat => real()();
  RealColumn get minLon => real()();
  RealColumn get maxLon => real()();

  IntColumn get totalTiles => integer()();
  IntColumn get estimatedSizeBytes =>
      integer().withDefault(const Constant(0))();

  /// Download status: 0=Pending, 1=Downloading, 2=Success, 3=Error, 4=Paused
  IntColumn get downloadStatus => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Many-to-Many link between Regions and Tiles
///
/// Enables accurate reference counting when deleting overlapping regions.
class RegionTileRefs extends Table {
  IntColumn get regionId =>
      integer().references(OfflineRegions, #id, onDelete: KeyAction.cascade)();

  // Reference to MarineMapTiles quadruplet
  IntColumn get zoom => integer()();
  IntColumn get x => integer()();
  IntColumn get y => integer()();
  TextColumn get sourceId => text()();

  @override
  Set<Column> get primaryKey => {regionId, zoom, x, y, sourceId};
}
