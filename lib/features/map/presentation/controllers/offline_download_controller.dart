import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/data/services/map_config_service.dart';
import 'package:sakkoja/features/map/data/services/tile_download_manager.dart';
import 'package:sakkoja/features/map/presentation/providers/offline_selection_provider.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

part 'offline_download_controller.g.dart';

@riverpod
class OfflineDownloadController extends _$OfflineDownloadController {
  @override
  void build() {}

  Future<void> startDownload({
    required BuildContext context,
    required LatLngBounds bounds,
  }) async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    final name = 'Area $h:$m';

    const minZoom = 10;
    const maxZoom = 15;

    int? regionId;
    try {
      final isFishingMode =
          ref.read(fishingModeControllerProvider).value?.isEnabled ?? false;
      final sourceTemplate = isFishingMode
          ? MapUrls.traficomWmts
          : MapUrls.openStreetMap;
      final tiles = TileDownloadManager.getTilesInBounds(
        bounds,
        minZoom,
        maxZoom,
      );
      regionId = await ref
          .read(appDatabaseProvider)
          .tileDao
          .createRegion(
            OfflineRegionsCompanion.insert(
              name: name,
              minLat: bounds.south,
              maxLat: bounds.north,
              minLon: bounds.west,
              maxLon: bounds.east,
              totalTiles: tiles.length,
              downloadStatus: const Value(1), // Downloading status
            ),
          );

      // Disable selection mode
      ref.read(offlineSelectionModeProvider.notifier).disable();

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.areaSaved)));
      }

      // Start actual download
      await ref
          .read(tileDownloadManagerProvider.notifier)
          .downloadRegion(
            regionId: regionId,
            tiles: tiles,
            urlTemplate: sourceTemplate,
          );
    } catch (e) {
      if (regionId != null) {
        try {
          await ref.read(appDatabaseProvider).tileDao.deleteRegion(regionId);
        } catch (_) {}
      }
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.areaSaveFailed)));
      }
    }
  }
}
