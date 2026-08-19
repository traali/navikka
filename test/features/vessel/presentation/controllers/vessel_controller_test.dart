import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/vessel/data/daos/vessel_dao.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/vessel/presentation/controllers/vessel_controller.dart';

class MockVesselDao extends Mock implements VesselDao {}

void main() {
  late MockVesselDao mockDao;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(
      const VesselProfilesCompanion(),
    );
  });

  setUp(() {
    mockDao = MockVesselDao();
  });

  tearDown(() {
    container.dispose();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        vesselDaoProvider.overrideWith((ref) => mockDao),
      ],
    );
  }

  group('VesselSettingsController', () {
    test('creates default profile when none exists', () async {
      when(() => mockDao.getSelectedProfile()).thenAnswer((_) async => null);

      container = createContainer();
      final profile = await container.read(
        vesselSettingsControllerProvider.future,
      );

      expect(profile?.id, -1);
      expect(profile?.name, 'My Boat');
    });

    test('calls createProfile when saving a new profile (id == -1)', () async {
      when(() => mockDao.getSelectedProfile()).thenAnswer((_) async => null);
      when(() => mockDao.createProfile(any())).thenAnswer((_) async => 101);
      when(() => mockDao.setSelectedProfile(101)).thenAnswer((_) async {});

      container = createContainer();
      await container.read(vesselSettingsControllerProvider.future);

      final controller = container.read(
        vesselSettingsControllerProvider.notifier,
      );
      await controller.saveProfile(
        name: 'Baltic Explorer',
        type: VesselType.cabinBoat,
        maxWind: 14.0,
        maxWave: 1.5,
      );

      verify(() => mockDao.createProfile(any())).called(1);
      verify(() => mockDao.setSelectedProfile(101)).called(1);
      verifyNever(() => mockDao.updateProfile(any()));
    });

    test(
      'calls updateProfile when saving an existing profile (id > 0)',
      () async {
        const existing = VesselProfile(
          id: 42,
          name: 'Original Vessel',
          type: VesselType.sailboat,
          maxWindLimit: 12.0,
          maxWaveLimit: 1.2,
          isSelected: true,
          cruisingSpeedKmh: 10.0,
        );

        when(
          () => mockDao.getSelectedProfile(),
        ).thenAnswer((_) async => existing);
        when(() => mockDao.updateProfile(any())).thenAnswer((_) async => true);

        container = createContainer();
        await container.read(vesselSettingsControllerProvider.future);

        final controller = container.read(
          vesselSettingsControllerProvider.notifier,
        );
        await controller.saveProfile(
          name: 'Renamed Vessel',
          type: VesselType.sailboat,
          maxWind: 15.0,
          maxWave: 1.8,
        );

        verify(() => mockDao.updateProfile(any())).called(1);
        verifyNever(() => mockDao.createProfile(any()));
      },
    );
  });
}
