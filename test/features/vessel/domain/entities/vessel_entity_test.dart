import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/vessel/domain/entities/vessel_entity.dart';

/// Tests for VesselEntity freezed value object.
///
/// SAFETY CRITICAL: VesselEntity carries safety limits (maxWind, maxWave)
/// used by the AI Guard for weather alerts.
void main() {
  group('VesselEntity', () {
    test('constructor assigns all fields', () {
      const entity = VesselEntity(
        id: 1,
        name: 'My Boat',
        type: VesselType.openBoat,
        maxWindLimit: 10,
        maxWaveLimit: 1,
        isSelected: true,
        draftDepth: 0.5,
        cruisingSpeedKmh: 20,
      );

      expect(entity.id, 1);
      expect(entity.name, 'My Boat');
      expect(entity.type, VesselType.openBoat);
      expect(entity.maxWindLimit, 10.0);
      expect(entity.maxWaveLimit, 1.0);
      expect(entity.isSelected, isTrue);
      expect(entity.draftDepth, 0.5);
      expect(entity.cruisingSpeedKmh, 20.0);
    });

    test('draftDepth is null when not provided', () {
      const entity = VesselEntity(
        id: 2,
        name: 'No Draft',
        type: VesselType.cabinBoat,
        maxWindLimit: 14,
        maxWaveLimit: 2,
        isSelected: false,
      );

      expect(entity.draftDepth, isNull);
    });

    test('cruisingSpeed has default of 15.0', () {
      const entity = VesselEntity(
        id: 3,
        name: 'Cruiser',
        type: VesselType.sailboat,
        maxWindLimit: 16,
        maxWaveLimit: 3,
        isSelected: false,
      );

      expect(entity.cruisingSpeedKmh, 15.0);
    });

    test('supports == equality', () {
      const a = VesselEntity(
        id: 1,
        name: 'A',
        type: VesselType.ship,
        maxWindLimit: 20,
        maxWaveLimit: 5,
        isSelected: true,
      );
      const b = VesselEntity(
        id: 1,
        name: 'A',
        type: VesselType.ship,
        maxWindLimit: 20,
        maxWaveLimit: 5,
        isSelected: true,
      );

      expect(a, equals(b));
    });

    test('inequality on field change', () {
      const a = VesselEntity(
        id: 1,
        name: 'A',
        type: VesselType.ship,
        maxWindLimit: 20,
        maxWaveLimit: 5,
        isSelected: true,
      );
      const b = VesselEntity(
        id: 1,
        name: 'B', // Different name
        type: VesselType.ship,
        maxWindLimit: 20,
        maxWaveLimit: 5,
        isSelected: true,
      );

      expect(a, isNot(equals(b)));
    });

    test('VesselType enum has 4 values', () {
      expect(VesselType.values.length, 4);
      expect(VesselType.values, [
        VesselType.openBoat,
        VesselType.cabinBoat,
        VesselType.sailboat,
        VesselType.ship,
      ]);
    });

    test('implements value equality via freezed', () {
      const entity = VesselEntity(
        id: 1,
        name: 'Test',
        type: VesselType.openBoat,
        maxWindLimit: 10,
        maxWaveLimit: 1,
        isSelected: false,
      );

      // freezed generates ==, hashCode, toString, copyWith
      expect(entity.hashCode, isA<int>());
      expect(entity.toString(), contains('VesselEntity'));
      expect(
        entity.copyWith(name: 'Renamed').name,
        'Renamed',
      );
    });

    test('copyWith preserves unchanged fields', () {
      const entity = VesselEntity(
        id: 5,
        name: 'Original',
        type: VesselType.sailboat,
        maxWindLimit: 16,
        maxWaveLimit: 3,
        isSelected: true,
        draftDepth: 2,
      );

      final modified = entity.copyWith(name: 'Modified');
      expect(modified.id, 5);
      expect(modified.type, VesselType.sailboat);
      expect(modified.maxWindLimit, 16.0);
      expect(modified.maxWaveLimit, 3.0);
      expect(modified.isSelected, isTrue);
      expect(modified.draftDepth, 2.0);
    });
  });
}
