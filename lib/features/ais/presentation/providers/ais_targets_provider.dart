import 'dart:async';
import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/ais/data/repositories/ais_repository_impl.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';

part 'ais_targets_provider.g.dart';

@riverpod
class AisTargetsNotifier extends _$AisTargetsNotifier {
  Timer? _pollingTimer;

  @override
  Future<List<AisTarget>> build() async {
    ref.onDispose(() {
      _pollingTimer?.cancel();
    });

    // Re-fetch AIS targets when camera moves significantly
    ref.watch(significantMapCameraPositionProvider);

    _startPolling();
    return _fetchTargets();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 15), (_) async {
      try {
        final targets = await _fetchTargets();
        if (ref.mounted) {
          state = AsyncValue.data(targets);
        }
      } catch (err, stack) {
        if (ref.mounted && (state.value == null || state.value!.isEmpty)) {
          state = AsyncValue.error(err, stack);
        }
      }
    });
  }

  Future<List<AisTarget>> _fetchTargets() async {
    final camera = ref.read(significantMapCameraPositionProvider);
    final center = camera.center;

    final latRad = center.latitude * (math.pi / 180.0);
    final lngDelta = (2.5 / math.cos(latRad)).clamp(0.5, 5.0);

    final southWest = LatLng(
      (center.latitude - 1.5).clamp(55.0, 70.0),
      (center.longitude - lngDelta).clamp(10.0, 35.0),
    );
    final northEast = LatLng(
      (center.latitude + 1.5).clamp(55.0, 70.0),
      (center.longitude + lngDelta).clamp(10.0, 35.0),
    );

    final repository = ref.read(aisRepositoryProvider);
    final result = await repository.getAisTargetsInBounds(
      southWest: southWest,
      northEast: northEast,
    );

    return result.fold(
      (failure) {
        // If we have previous valid target data, retain it as soft fallback but log error;
        // if no data exists, throw an exception so Riverpod surfaces AsyncValue.error to UI.
        if (state.value != null && state.value!.isNotEmpty) {
          return state.value!;
        }
        throw Exception(failure.message);
      },
      (targets) => targets,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final targets = await _fetchTargets();
      state = AsyncValue.data(targets);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}
