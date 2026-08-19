import 'package:drift/drift.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/vessel/data/daos/vessel_dao.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/vessel/domain/entities/vessel_entity.dart';

class VesselService {
  VesselService(this._vesselDao);
  final VesselDao _vesselDao;

  Future<List<VesselEntity>> getAllProfiles() async {
    final dtos = await _vesselDao.getAllProfiles();
    return dtos.map(_mapToEntity).toList();
  }

  Future<VesselEntity?> getSelectedProfile() async {
    final dto = await _vesselDao.getSelectedProfile();
    return dto == null ? null : _mapToEntity(dto);
  }

  Future<int> createProfile({
    required String name,
    required VesselType type,
    double? maxWind,
    double? maxWave,
    double? draft,
    double? cruisingSpeed,
    String? hinCode,
    String? engineManufacturer,
    String? engineModel,
    String? fuelType,
  }) {
    // defaults based on type if not provided
    final defaults = _getDefaultsForType(type);

    return _vesselDao.createProfile(
      VesselProfilesCompanion(
        name: Value(name),
        type: Value(type),
        maxWindLimit: Value(maxWind ?? defaults.maxWindLimit),
        maxWaveLimit: Value(maxWave ?? defaults.maxWaveLimit),
        draftDepth: Value(draft),
        cruisingSpeedKmh: Value(cruisingSpeed ?? 15.0),
        isSelected: const Value(false),
        hinCode: Value(hinCode),
        engineManufacturer: Value(engineManufacturer),
        engineModel: Value(engineModel),
        fuelType: Value(fuelType),
      ),
    );
  }

  Future<bool> updateProfile({
    required int id,
    required String name,
    required VesselType type,
    double? maxWind,
    double? maxWave,
    double? draft,
    double? cruisingSpeed,
    String? hinCode,
    String? engineManufacturer,
    String? engineModel,
    String? fuelType,
  }) {
    final defaults = _getDefaultsForType(type);

    return _vesselDao.updateProfile(
      VesselProfilesCompanion(
        id: Value(id),
        name: Value(name),
        type: Value(type),
        maxWindLimit: Value(maxWind ?? defaults.maxWindLimit),
        maxWaveLimit: Value(maxWave ?? defaults.maxWaveLimit),
        draftDepth: Value(draft),
        cruisingSpeedKmh: Value(cruisingSpeed ?? 15.0),
        isSelected: const Value(true),
        hinCode: Value(hinCode),
        engineManufacturer: Value(engineManufacturer),
        engineModel: Value(engineModel),
        fuelType: Value(fuelType),
      ),
    );
  }

  Future<void> selectProfile(int id) {
    return _vesselDao.setSelectedProfile(id);
  }

  // Helper
  VesselEntity _mapToEntity(VesselProfile dto) {
    return VesselEntity(
      id: dto.id,
      name: dto.name,
      type: dto.type,
      maxWindLimit: dto.maxWindLimit,
      maxWaveLimit: dto.maxWaveLimit,
      isSelected: dto.isSelected,
      draftDepth: dto.draftDepth,
      cruisingSpeedKmh: dto.cruisingSpeedKmh,
      hinCode: dto.hinCode,
      engineManufacturer: dto.engineManufacturer,
      engineModel: dto.engineModel,
      fuelType: dto.fuelType,
    );
  }

  // Default safety limits (The "Night Captain" Standards)
  ({double maxWindLimit, double maxWaveLimit}) _getDefaultsForType(
    VesselType type,
  ) {
    switch (type) {
      case VesselType.openBoat:
        return (maxWindLimit: 10.0, maxWaveLimit: 1.0);
      case VesselType.cabinBoat:
        return (maxWindLimit: 14.0, maxWaveLimit: 2.0);
      case VesselType.sailboat:
        return (maxWindLimit: 16.0, maxWaveLimit: 3.0);
      case VesselType.ship:
        return (maxWindLimit: 20.0, maxWaveLimit: 5.0);
    }
  }
}
