import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/map/presentation/widgets/drift_tile_provider.dart';

void main() {
  test('tile upsert queue drains writes added during a flush', () async {
    final firstBatchStarted = Completer<void>();
    final releaseFirstBatch = Completer<void>();
    final batches = <Map<String, int>>[];
    final queue = TileBatchQueue<int>(
      delay: Duration.zero,
      onFlush: (batch) async {
        batches.add(Map<String, int>.from(batch));
        if (batches.length == 1) {
          firstBatchStarted.complete();
          await releaseFirstBatch.future;
        }
      },
    );

    queue.add('first', 1);
    final flush = queue.flush();
    await firstBatchStarted.future;
    queue.add('second', 2);
    releaseFirstBatch.complete();
    await flush;

    expect(batches, [
      {'first': 1},
      {'second': 2},
    ]);
  });

  test('access update queue drains updates added during a flush', () async {
    final firstBatchStarted = Completer<void>();
    final releaseFirstBatch = Completer<void>();
    final batches = <Map<String, String>>[];
    final queue = TileBatchQueue<String>(
      delay: Duration.zero,
      onFlush: (batch) async {
        batches.add(Map<String, String>.from(batch));
        if (batches.length == 1) {
          firstBatchStarted.complete();
          await releaseFirstBatch.future;
        }
      },
    );

    queue.add('first', 'access-1');
    final flush = queue.flush();
    await firstBatchStarted.future;
    queue.add('second', 'access-2');
    releaseFirstBatch.complete();
    await flush;

    expect(batches, [
      {'first': 'access-1'},
      {'second': 'access-2'},
    ]);
  });
}
