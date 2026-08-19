import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart' show Route;
import 'package:flutter/material.dart' show Route;
import 'package:flutter/widgets.dart' show Route;

@DataClassName('DbRoute')
class Routes extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// User-friendly name of the route (e.g., "Helsinki to Tallinn").
  TextColumn get name => text()();

  /// When this route was created (UTC).
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Last modification time (UTC).
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  /// Whether this is the currently active navigation route.
  /// Only one route should be active at a time (enforced by logic).
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  /// Total calculates distance in meters (cached for performance).
  RealColumn get totalDistanceMeters => real().withDefault(const Constant(0))();
}

/// Ordered waypoints defining the geometry of a [Route].
@DataClassName('Waypoint')
class Waypoints extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to the parent [Route].
  /// Cascade delete ensures waypoints are removed when route is deleted.
  IntColumn get routeId =>
      integer().references(Routes, #id, onDelete: KeyAction.cascade)();

  /// Latitude in decimal degrees (WGS84).
  RealColumn get lat => real()();

  /// Longitude in decimal degrees (WGS84).
  RealColumn get lon => real()();

  /// Zero-based index defining the sequence in the route.
  IntColumn get orderIndex => integer()();

  /// Optional label for this specific point (e.g., "Turn point", "Harbor").
  TextColumn get label => text().nullable()();
}
