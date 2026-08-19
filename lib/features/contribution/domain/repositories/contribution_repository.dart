import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';

abstract class ContributionRepository {
  /// Save a new contribution or update an existing one
  Future<Either<Failure, Unit>> saveContribution(UserContribution contribution);

  /// Get all contributions (drafts) sorted by createdAt descending
  Future<Either<Failure, List<UserContribution>>> getAllContributions();

  /// Delete a contribution by ID
  Future<Either<Failure, Unit>> deleteContribution(String id);
}
