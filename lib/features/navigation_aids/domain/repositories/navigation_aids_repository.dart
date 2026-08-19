import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';

import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/fairway_area.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_line.dart';

/// Repository interface for navigation aids data.
///
/// Per AGENTS.md Section 10: Abstract repositories in domain layer.
abstract class NavigationAidsRepository {
  /// Gets fairway areas, either from cache or remote.
  ///
  /// Returns cached data if valid, otherwise fetches from API.
  /// Falls back to bundled assets if offline.
  Future<Either<Failure, List<FairwayArea>>> getFairwayAreas({BBox? bbox});

  /// Gets navigation aids (traffic signs, safety equipment, lighthouses).
  ///
  /// Returns cached data if valid, otherwise fetches from API.
  /// Falls back to bundled assets if offline.
  Future<Either<Failure, List<NavigationAid>>> getNavigationAids({BBox? bbox});

  /// Gets navigation lines (centerlines and boating routes).
  Future<Either<Failure, List<NavigationLine>>> getNavigationLines({
    BBox? bbox,
  });

  /// Forces a refresh of all navigation aids data from remote API.
  ///
  /// Updates local cache with fresh data.
  Future<Either<Failure, void>> refreshData();
}
