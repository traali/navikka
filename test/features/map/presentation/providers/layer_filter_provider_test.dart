import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/map/di/map_di.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';

class MockMapRepository extends Mock implements MapRepository {}

void main() {
  late MockMapRepository mockRepo;

  setUp(() {
    mockRepo = MockMapRepository();
    when(
      () => mockRepo.getLayerFilterSettings(),
    ).thenAnswer((_) async => right(null));
    when(
      () => mockRepo.saveLayerFilterSettings(any()),
    ).thenAnswer((_) async => right(unit));
  });

  group('LayerFilter', () {
    test('initial state has all restriction types visible', () async {
      final container = ProviderContainer(
        overrides: [mapRepositoryProvider.overrideWithValue(mockRepo)],
      );
      final state = await container.read(layerFilterProvider.future);

      expect(state.visibleTypes.length, allRestrictionTypes.length);
      for (final type in allRestrictionTypes) {
        expect(state.isVisible(type.code), true);
      }
    });

    test('toggleType removes and adds back a type', () async {
      final container = ProviderContainer(
        overrides: [mapRepositoryProvider.overrideWithValue(mockRepo)],
      );
      final typeCode = allRestrictionTypes.first.code;

      final notifier = container.read(layerFilterProvider.notifier);
      await container.read(layerFilterProvider.future); // Wait for init

      // Toggle off
      await notifier.toggleType(typeCode);
      expect(
        container.read(layerFilterProvider).value?.isVisible(typeCode),
        false,
      );

      // Toggle on
      await notifier.toggleType(typeCode);
      expect(
        container.read(layerFilterProvider).value?.isVisible(typeCode),
        true,
      );
    });

    test('hideAll and showAll works correctly', () async {
      final container = ProviderContainer(
        overrides: [mapRepositoryProvider.overrideWithValue(mockRepo)],
      );
      final notifier = container.read(layerFilterProvider.notifier);
      await container.read(layerFilterProvider.future); // Wait for init

      await notifier.hideAll();
      expect(container.read(layerFilterProvider).value?.visibleTypes, isEmpty);

      await notifier.showAll();
      expect(
        container.read(layerFilterProvider).value?.visibleTypes.length,
        allRestrictionTypes.length,
      );
    });

    test('isVisible returns true for null typeCode (fallback)', () async {
      final container = ProviderContainer(
        overrides: [mapRepositoryProvider.overrideWithValue(mockRepo)],
      );
      final state = await container.read(layerFilterProvider.future);
      expect(state.isVisible(null), true);
    });
  });
}
