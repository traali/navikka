import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/contribution/di/contribution_di.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';
import 'package:sakkoja/features/contribution/domain/repositories/contribution_repository.dart';
import 'package:sakkoja/features/contribution/presentation/providers/contribution_provider.dart';

class MockContributionRepository extends Mock
    implements ContributionRepository {}

void main() {
  late MockContributionRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(
      UserContribution(
        id: 'fallback',
        type: ContributionType.speedLimit,
        location: const LatLng(0, 0),
        value: '0',
        createdAt: DateTime.now(),
      ),
    );
  });

  setUp(() {
    mockRepo = MockContributionRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        contributionRepositoryProvider.overrideWith((ref) => mockRepo),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('Contribution Notifier', () {
    test('loads contributions on init', () async {
      final contributions = [
        UserContribution(
          id: '1',
          type: ContributionType.speedLimit,
          location: const LatLng(60, 24),
          value: '10',
          createdAt: DateTime.now(),
        ),
      ];

      when(
        () => mockRepo.getAllContributions(),
      ).thenAnswer((_) async => Right(contributions));

      final container = createContainer();

      // Read the future to trigger build
      final state = await container.read(contributionProvider.future);

      expect(state, contributions);
      verify(() => mockRepo.getAllContributions()).called(1);
    });

    test('adds contribution optimistically', () async {
      when(
        () => mockRepo.getAllContributions(),
      ).thenAnswer((_) async => const Right([]));
      when(
        () => mockRepo.saveContribution(any()),
      ).thenAnswer((_) async => const Right(unit));

      final container = createContainer();
      // Keep provider alive
      container.listen(contributionProvider, (previous, next) {});
      await container.read(contributionProvider.future); // Wait for init

      await container
          .read(contributionProvider.notifier)
          .addContribution(
            type: ContributionType.trafficSign,
            location: const LatLng(60.1, 24.1),
            value: '5.2',
          );

      final state = container.read(contributionProvider).value!;
      expect(state.length, 1);
      expect(state.first.type, ContributionType.trafficSign);
      verify(() => mockRepo.saveContribution(any())).called(1);
    });

    test('reverts on save failure', () async {
      when(
        () => mockRepo.getAllContributions(),
      ).thenAnswer((_) async => const Right([]));
      when(
        () => mockRepo.saveContribution(any()),
      ).thenAnswer((_) async => const Left(GeneralFailure('Save failed')));

      final container = createContainer();
      // Keep provider alive
      container.listen(contributionProvider, (previous, next) {});
      await container.read(contributionProvider.future);

      await container
          .read(contributionProvider.notifier)
          .addContribution(
            type: ContributionType.speedLimit,
            location: const LatLng(60, 24),
            value: '10',
          );

      // Should revert to empty after failure
      final state = container.read(contributionProvider).value ?? [];
      expect(state, isEmpty);
    });

    test('deletes contribution optimistically', () async {
      final contribution = UserContribution(
        id: 'to-delete',
        type: ContributionType.speedLimit,
        location: const LatLng(60, 24),
        value: 'Rock',
        createdAt: DateTime.now(),
      );

      when(
        () => mockRepo.getAllContributions(),
      ).thenAnswer((_) async => Right([contribution]));
      when(
        () => mockRepo.deleteContribution('to-delete'),
      ).thenAnswer((_) async => const Right(unit));

      final container = createContainer();
      await container.read(contributionProvider.future);

      await container
          .read(contributionProvider.notifier)
          .deleteContribution('to-delete');

      final state = container.read(contributionProvider).value!;
      expect(state, isEmpty);
      verify(() => mockRepo.deleteContribution('to-delete')).called(1);
    });
  });
}
