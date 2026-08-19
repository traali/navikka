import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/vessel/data/daos/vessel_dao.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/vessel/domain/entities/vessel_entity.dart';
import 'package:sakkoja/features/vessel/domain/services/vessel_service.dart';

part 'vessel_controller.g.dart';

@Riverpod(keepAlive: true)
VesselDao vesselDao(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.vesselDao;
}

@Riverpod(keepAlive: true)
VesselService vesselService(Ref ref) {
  final dao = ref.watch(vesselDaoProvider);
  return VesselService(dao);
}

@riverpod
class VesselSettingsController extends _$VesselSettingsController {
  late VesselService _service;

  @override
  Future<VesselEntity?> build() async {
    _service = ref.watch(vesselServiceProvider);
    return _loadProfile();
  }

  Future<VesselEntity?> _loadProfile() async {
    try {
      final profile = await _service.getSelectedProfile();
      if (profile != null) {
        return profile;
      } else {
        return const VesselEntity(
          id: -1,
          name: 'My Boat',
          type: VesselType.openBoat,
          maxWindLimit: 10,
          maxWaveLimit: 1,
          isSelected: true,
        );
      }
    } catch (e, s) {
      Log.w('[Vessel] Failed to load profile', e, s);
      rethrow;
    }
  }

  Future<void> saveProfile({
    required String name,
    required VesselType type,
    required double maxWind,
    required double maxWave,
    double? draft,
    double? cruisingSpeed,
    String? hinCode,
    String? engineManufacturer,
    String? engineModel,
    String? fuelType,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final current = state.value;
      final existingId = (current != null && current.id > 0)
          ? current.id
          : null;

      if (existingId != null) {
        await _service.updateProfile(
          id: existingId,
          name: name,
          type: type,
          maxWind: maxWind,
          maxWave: maxWave,
          draft: draft,
          cruisingSpeed: cruisingSpeed,
          hinCode: hinCode,
          engineManufacturer: engineManufacturer,
          engineModel: engineModel,
          fuelType: fuelType,
        );
      } else {
        final id = await _service.createProfile(
          name: name,
          type: type,
          maxWind: maxWind,
          maxWave: maxWave,
          draft: draft,
          cruisingSpeed: cruisingSpeed,
          hinCode: hinCode,
          engineManufacturer: engineManufacturer,
          engineModel: engineModel,
          fuelType: fuelType,
        );
        await _service.selectProfile(id);
      }
      return _loadProfile();
    });
  }
}
