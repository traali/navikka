import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart';
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';

class MockFishingRepository extends Mock implements FishingRepository {}

void main() {
  late MockFishingRepository mockRepository;

  setUp(() {
    mockRepository = MockFishingRepository();
  });

  group('FishingModeController', () {
    test('build fetches initial fishing mode state', () async {
      when(() => mockRepository.getFishingMode()).thenAnswer((_) async => true);

      final container = ProviderContainer(
        overrides: [
          fishingRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      final state = await container.read(fishingModeControllerProvider.future);

      expect(state.isEnabled, true);
      verify(() => mockRepository.getFishingMode()).called(1);
    });

    test('toggle changes state and saves to repository', () async {
      when(
        () => mockRepository.getFishingMode(),
      ).thenAnswer((_) async => false);
      when(
        () => mockRepository.saveFishingMode(any()),
      ).thenAnswer((_) async => {});

      final container = ProviderContainer(
        overrides: [
          fishingRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      // Initialize
      await container.read(fishingModeControllerProvider.future);

      final controller = container.read(fishingModeControllerProvider.notifier);
      await controller.toggle();

      expect(
        container.read(fishingModeControllerProvider).value?.isEnabled,
        true,
      );
      verify(() => mockRepository.saveFishingMode(true)).called(1);

      await controller.toggle();
      expect(
        container.read(fishingModeControllerProvider).value?.isEnabled,
        false,
      );
      verify(() => mockRepository.saveFishingMode(false)).called(1);
    });
  });
}
