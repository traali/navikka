import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';
import 'package:sakkoja/features/fishing/domain/usecases/get_catches.dart';
import 'package:sakkoja/features/fishing/domain/usecases/record_catch.dart';
import 'package:uuid/uuid.dart';

part 'catch_controller_provider.g.dart';

/// Provider for GetCatches use case
@riverpod
GetCatches getCatches(Ref ref) =>
    GetCatches(ref.watch(catchRepositoryProvider));

/// Provider for RecordCatch use case
@riverpod
RecordCatch recordCatch(Ref ref) =>
    RecordCatch(ref.watch(catchRepositoryProvider));

/// Controller for managing fish catch recording and retrieval.
@Riverpod(keepAlive: true)
class CatchController extends _$CatchController {
  @override
  FutureOr<List<FishCatch>> build() async {
    final getCatches = ref.read(getCatchesProvider);
    final result = await getCatches();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (catches) => catches,
    );
  }

  /// Record a new fish catch.
  Future<void> recordCatch({
    required FishSpecies species,
    required LatLng location,
    int? weightGrams,
    double? lengthCm,
    String? lure,
    FishingMethod? method,
    String? notes,
    double? weatherTemp,
    double? weatherWindSpeed,
    double? weatherWindDir,
    String? weatherDesc,
    String? weatherIcon,
  }) async {
    final recordCatchUseCase = ref.read(recordCatchProvider);

    final fishCatch = FishCatch(
      id: const Uuid().v4(),
      species: species,
      timestamp: DateTime.now(),
      location: location,
      weightGrams: weightGrams,
      lengthCm: lengthCm,
      lure: lure,
      method: method,
      notes: notes,
      weatherTemp: weatherTemp,
      weatherWindSpeed: weatherWindSpeed,
      weatherWindDir: weatherWindDir,
      weatherDesc: weatherDesc,
      weatherIcon: weatherIcon,
    );

    final previousCatches = state.value ?? [];
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await recordCatchUseCase(fishCatch);
      return result.fold((failure) => throw Exception(failure.message), (_) {
        return [fishCatch, ...previousCatches];
      });
    });
  }

  /// Refresh the catches list from storage.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final getCatches = ref.read(getCatchesProvider);
      final result = await getCatches();
      return result.fold(
        (failure) => throw Exception(failure.message),
        (catches) => catches,
      );
    });
  }
}
