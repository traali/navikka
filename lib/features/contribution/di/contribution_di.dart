import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/contribution/data/repositories/drift_contribution_repository.dart';
import 'package:sakkoja/features/contribution/domain/repositories/contribution_repository.dart';

part 'contribution_di.g.dart';

@Riverpod(keepAlive: true)
ContributionRepository contributionRepository(Ref ref) {
  return DriftContributionRepository(ref.watch(appDatabaseProvider));
}
