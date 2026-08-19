import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/contribution/di/contribution_di.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';
import 'package:sakkoja/features/contribution/domain/repositories/contribution_repository.dart';
import 'package:sakkoja/features/contribution/presentation/providers/contribution_provider.dart';

class MockContributionRepository extends Mock
    implements ContributionRepository {}

void main() {
  late MockContributionRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(
      UserContribution(
        id: 'temp',
        type: ContributionType.speedLimit,
        location: const LatLng(0, 0),
        value: '0',
        createdAt: DateTime.now(),
      ),
    );
  });

  setUp(() {
    mockRepository = MockContributionRepository();
  });

  final testContribution = UserContribution(
    id: 'id-1',
    type: ContributionType.speedLimit,
    location: const LatLng(60.1, 24.1),
    value: '30',
    createdAt: DateTime(2023),
  );

  group('Contribution Notifier', () {
    test('build fetches initial contributions', () async {
      when(
        () => mockRepository.getAllContributions(),
      ).thenAnswer((_) async => Right([testContribution]));

      final container = ProviderContainer(
        overrides: [
          contributionRepositoryProvider.overrideWith((ref) => mockRepository),
        ],
      );

      final state = await container.read(contributionProvider.future);
      expect(state, [testContribution]);
      verify(() => mockRepository.getAllContributions()).called(1);
    });

    test('addContribution updates state optimistically and saves', () async {
      when(
        () => mockRepository.getAllContributions(),
      ).thenAnswer((_) async => const Right([]));
      when(
        () => mockRepository.saveContribution(any()),
      ).thenAnswer((_) async => const Right(unit));

      final container = ProviderContainer(
        overrides: [
          contributionRepositoryProvider.overrideWith((ref) => mockRepository),
        ],
      );

      await container.read(contributionProvider.future);

      final notifier = container.read(contributionProvider.notifier);
      await notifier.addContribution(
        type: ContributionType.trafficSign,
        location: const LatLng(60.2, 24.2),
        value: 'No entry',
      );

      final state = container.read(contributionProvider).value;
      expect(state?.length, 1);
      expect(state?.first.type, ContributionType.trafficSign);
      expect(state?.first.value, 'No entry');
      verify(() => mockRepository.saveContribution(any())).called(1);
    });

    test(
      'deleteContribution updates state and removes from repository',
      () async {
        when(
          () => mockRepository.getAllContributions(),
        ).thenAnswer((_) async => Right([testContribution]));
        when(
          () => mockRepository.deleteContribution(any()),
        ).thenAnswer((_) async => const Right(unit));

        final container = ProviderContainer(
          overrides: [
            contributionRepositoryProvider.overrideWith(
              (ref) => mockRepository,
            ),
          ],
        );

        await container.read(contributionProvider.future);

        final notifier = container.read(contributionProvider.notifier);
        await notifier.deleteContribution(testContribution.id);

        final state = container.read(contributionProvider).value;
        expect(state, isEmpty);
        verify(
          () => mockRepository.deleteContribution(testContribution.id),
        ).called(1);
      },
    );
  });
}
