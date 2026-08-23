import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/underway_fetch.dart';
import 'package:sakkoja/features/ais/data/repositories/ais_repository_impl.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';

part 'ais_targets_provider.g.dart';

@riverpod
class AisTargetsNotifier extends _$AisTargetsNotifier {
  Timer? _pollingTimer;
  DateTime? _lastFetchAt;
  bool _inflight = false;

  @override
  Future<List<AisTarget>> build() async {
    ref.onDispose(() {
      _pollingTimer?.cancel();
    });

    // 2 km pan may check immediately, but HTTP still respects 60/180 s TTL.
    ref.listen(significantMapCameraPositionProvider, (prev, next) {
      unawaited(_maybeFetch());
    });

    _startPolling();
    try {
      _inflight = true;
      final first = await _fetchTargets();
      _lastFetchAt = DateTime.now();
      return first;
    } catch (_) {
      _lastFetchAt = DateTime.now();
      rethrow;
    } finally {
      _inflight = false;
    }
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    // Check every 15 s; HTTP fetch only when [shouldFetchAis] / TTL says so.
    _pollingTimer = Timer.periodic(UnderwayFetch.aisPollCheck, (_) {
      unawaited(_maybeFetch());
    });
  }

  Future<void> _maybeFetch() async {
    if (_inflight || !ref.mounted) return;
    final sogKn = ref.read(mapProvider).currentSpeedKmh / 1.852;
    if (!shouldFetchAis(
      now: DateTime.now(),
      lastAt: _lastFetchAt,
      sogKn: sogKn,
      inflight: _inflight,
    )) {
      return;
    }
    try {
      _inflight = true;
      final targets = await _fetchTargets();
      _lastFetchAt = DateTime.now();
      if (ref.mounted) {
        state = AsyncValue.data(targets);
      }
    } catch (err, stack) {
      _lastFetchAt = DateTime.now();
      if (ref.mounted && (state.value == null || state.value!.isEmpty)) {
        state = AsyncValue.error(err, stack);
      }
    } finally {
      _inflight = false;
    }
  }

  Future<List<AisTarget>> _fetchTargets() async {
    final camera = ref.read(significantMapCameraPositionProvider);
    final center = camera.center;
    final delta = UnderwayFetch.aisBboxDeg;

    final southWest = LatLng(
      (center.latitude - delta).clamp(55.0, 70.0),
      (center.longitude - delta).clamp(10.0, 35.0),
    );
    final northEast = LatLng(
      (center.latitude + delta).clamp(55.0, 70.0),
      (center.longitude + delta).clamp(10.0, 35.0),
    );

    final repository = ref.read(aisRepositoryProvider);
    final result = await repository.getAisTargetsInBounds(
      southWest: southWest,
      northEast: northEast,
    );

    return result.fold((failure) {
      if (state.value != null && state.value!.isNotEmpty) {
        return state.value!;
      }
      throw Exception(failure.message);
    }, (targets) => targets);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final targets = await _fetchTargets();
      _lastFetchAt = DateTime.now();
      state = AsyncValue.data(targets);
    } catch (err, stack) {
      _lastFetchAt = DateTime.now();
      state = AsyncValue.error(err, stack);
    }
  }
}
