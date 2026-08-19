import 'dart:async';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'track_repository.g.dart';

class TrackRepository {
  TrackRepository(this._db);
  final AppDatabase _db;

  Timer? _flushTimer;
  Future<void> _flushQueue = Future<void>.value();
  final List<TrackPointsCompanion> _buffer = [];
  static const int _maxBufferSize = 50;
  static const Duration _flushInterval = Duration(seconds: 5);

  void _startFlushTimer() {
    _flushTimer ??= Timer.periodic(_flushInterval, (_) {
      unawaited(_flush());
    });
  }

  Future<bool> _flush() {
    final result = _flushQueue.then((_) => _flushNow());
    // A failed scheduled flush must not prevent later retries from running.
    _flushQueue = result.then<void>((_) {}, onError: (_, _) {});
    return result;
  }

  Future<bool> _flushNow() async {
    if (_buffer.isEmpty) return true;
    final batch = _buffer.toList();
    _buffer.clear();
    try {
      await _db.batch((b) {
        for (final point in batch) {
          b.insert(_db.trackPoints, point);
        }
      });
      Log.d('[TrackRepo] Flushed ${batch.length} points');
      return true;
    } catch (e, s) {
      // Re-add failed points to the buffer for retry
      _buffer.insertAll(0, batch);
      Log.e('[TrackRepo] Batch flush failed', e, s);
      return false;
    }
  }

  Future<Either<Failure, int>> startTrack({
    String? name,
    bool isFishingMode = false,
  }) async {
    try {
      final id = await _db
          .into(_db.recordedTracks)
          .insert(
            RecordedTracksCompanion.insert(
              name: Value(name),
              startTime: DateTime.now(),
              isFishingMode: Value(isFishingMode),
            ),
          );
      return Right(id);
    } catch (e, s) {
      Log.e('TrackRepo: startTrack failed', e, s);
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> addPoint(
    int trackId,
    double lat,
    double lon,
    double speed, {
    DateTime? timestamp,
  }) async {
    _buffer.add(
      TrackPointsCompanion.insert(
        trackId: trackId,
        latitude: lat,
        longitude: lon,
        speedKmh: speed,
        timestamp: timestamp ?? DateTime.now(),
      ),
    );
    _startFlushTimer();
    if (_buffer.length >= _maxBufferSize) {
      final flushed = await _flush();
      if (!flushed) {
        return const Left(DatabaseFailure('Failed to flush track points'));
      }
    }
    return const Right(null);
  }

  Future<Either<Failure, void>> endTrack(
    int trackId,
    double totalDistance,
  ) async {
    final flushed = await _flush();
    if (!flushed) {
      // Keep the timer and buffered points alive so a later attempt can retry.
      return const Left(DatabaseFailure('Failed to flush track points'));
    }
    _flushTimer?.cancel();
    _flushTimer = null;
    try {
      await (_db.update(
        _db.recordedTracks,
      )..where((t) => t.id.equals(trackId))).write(
        RecordedTracksCompanion(
          endTime: Value(DateTime.now()),
          totalDistanceMeters: Value(totalDistance),
        ),
      );
      return const Right(null);
    } catch (e, s) {
      Log.e('TrackRepo: endTrack failed', e, s);
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Stream<Either<Failure, List<TrackPoint>>> watchPoints(int trackId) {
    try {
      final stream = (_db.select(
        _db.trackPoints,
      )..where((t) => t.trackId.equals(trackId))).watch();
      return stream.map(Right.new);
    } catch (e, s) {
      Log.e('TrackRepo: watchPoints failed', e, s);
      return Stream.value(Left(DatabaseFailure(e.toString())));
    }
  }

  Future<Either<Failure, List<RecordedTrack>>> getAllTracks() async {
    try {
      final tracks = await _db.select(_db.recordedTracks).get();
      return Right(tracks);
    } catch (e, s) {
      Log.e('TrackRepo: getAllTracks failed', e, s);
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteTrack(int trackId) async {
    try {
      await (_db.delete(
        _db.recordedTracks,
      )..where((t) => t.id.equals(trackId))).go();
      return const Right(null);
    } catch (e, s) {
      Log.e('TrackRepo: deleteTrack failed', e, s);
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Explicitly flushes buffered track points to the database and awaits completion.
  Future<void> flush() async {
    _flushTimer?.cancel();
    if (_buffer.isNotEmpty) {
      await _flush();
    }
  }

  void dispose() {
    _flushTimer?.cancel();
    if (_buffer.isNotEmpty) {
      unawaited(flush());
    }
  }
}

@Riverpod(keepAlive: true)
TrackRepository trackRepository(Ref ref) {
  final repo = TrackRepository(ref.watch(appDatabaseProvider));
  ref.onDispose(repo.dispose);
  return repo;
}
