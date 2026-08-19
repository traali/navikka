import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/map/presentation/widgets/area_selection_overlay.dart';

class OfflineRegionsScreen extends ConsumerWidget {
  const OfflineRegionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    final regionsStream = db.tileDao.watchAllRegions();

    return Scaffold(
      appBar: AppBar(title: const Text('Offline Marine Areas')),
      body: StreamBuilder(
        stream: regionsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final regions = snapshot.data!;
          if (regions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  const Text('No offline areas downloaded.'),
                  const SizedBox(height: 8),
                  Text(
                    'Select an area on the map to download.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: regions.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final region = regions[index];
              return _RegionTile(region: region);
            },
          );
        },
      ),
    );
  }
}

class _RegionTile extends ConsumerWidget {
  // Drift OfflineRegion class

  const _RegionTile({required this.region});
  final OfflineRegion region;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dao = ref.watch(appDatabaseProvider).tileDao;
    final progressStream = dao.watchDownloadedTileCount(region.id);

    return Card(
      child: ListTile(
        title: Text(region.name),
        subtitle: StreamBuilder<int>(
          stream: progressStream,
          builder: (context, snapshot) {
            final downloaded = snapshot.data ?? 0;
            final total = region.totalTiles;
            final progress = total > 0 ? downloaded / total : 0.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  OfflineAreaLogic.formatSize(region.totalTiles),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                ),
              ],
            );
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Poista alue',
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Area?'),
                content: Text(
                  'Are you sure you want to delete "${region.name}"?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );

            if (confirm ?? false) {
              await dao.deleteRegion(region.id);
            }
          },
        ),
        onTap: () {
          // Jump to region on map - implemented in Phase 3 verification
        },
      ),
    );
  }
}
