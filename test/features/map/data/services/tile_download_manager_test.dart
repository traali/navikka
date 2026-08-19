import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/map/data/services/tile_download_manager.dart';

void main() {
  test('rejects oversized bounds before allocating tile coordinates', () {
    final bounds = LatLngBounds(
      const LatLng(-80, -179),
      const LatLng(80, 179),
    );

    expect(
      () => TileDownloadManager.getTilesInBounds(bounds, 0, 15),
      throwsA(
        isA<TileEnumerationException>().having(
          (error) => error.message,
          'message',
          contains('more than'),
        ),
      ),
    );
  });

  test('uses the runtime template as the offline cache source id', () {
    const template = 'https://tiles.example/{z}/{x}/{y}.png';

    expect(TileDownloadManager.sourceIdForTemplate(template), template);
  });

  test('enumerates a small bounded area', () {
    final bounds = LatLngBounds(
      const LatLng(60, 25),
      const LatLng(60.01, 25.01),
    );

    final tiles = TileDownloadManager.getTilesInBounds(bounds, 10, 10);

    expect(tiles, isNotEmpty);
    expect(
      tiles.length,
      lessThanOrEqualTo(TileDownloadManager.maxOfflineTileCount),
    );
  });
}
