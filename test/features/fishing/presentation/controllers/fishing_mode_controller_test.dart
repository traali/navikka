import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart';
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';

class MockFishingRepository extends Mock implements FishingRepository {}

void main() {
  late MockFishingRepository mockRepository;
  late ProviderContainer container;

  setUp(() async {
    mockRepository = MockFishingRepository();
    // No GetIt needed

    container = ProviderContainer(
      overrides: [fishingRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('should initialize with state from repository', () async {
    // Arrange
    when(() => mockRepository.getFishingMode()).thenAnswer((_) async => true);

    // Act
    // Wait for async initialization in build()
    final initialState = await container.read(
      fishingModeControllerProvider.future,
    );

    // Assert
    expect(initialState.isEnabled, true);
    expect(
      container.read(fishingModeControllerProvider).value?.isEnabled,
      true,
    );
    verify(() => mockRepository.getFishingMode()).called(1);
  });

  test('toggle should flip state and save to repository', () async {
    // Arrange
    when(() => mockRepository.getFishingMode()).thenAnswer((_) async => false);
    when(() => mockRepository.saveFishingMode(any())).thenAnswer((_) async {});

    // Act
    await container.read(fishingModeControllerProvider.future); // Wait for init
    final controller = container.read(fishingModeControllerProvider.notifier);
    await controller.toggle();

    // Assert
    expect(
      container.read(fishingModeControllerProvider).value?.isEnabled,
      true,
    );
    verify(() => mockRepository.saveFishingMode(true)).called(1);
  });
}
