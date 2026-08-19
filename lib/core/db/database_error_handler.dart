import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/utils/logger.dart';

/// Centralized error handler for database operations.
///
/// Maps database-specific exceptions to [Failure] types and handles logging.
/// This handler is cross-platform and safe for Web (no FFI/native dependencies).
class DatabaseErrorHandler {
  /// Executes a database operation and returns [Either].
  ///
  /// - [operation]: The async database task to perform.
  /// - [context]: Optional description for better log messages.
  Future<Either<Failure, T>> perform<T>(
    Future<T> Function() operation, {
    String? context,
  }) async {
    try {
      final result = await operation();
      return Right(result);
    } on Object catch (e, stackTrace) {
      // Note: We use a generic catch here to avoid native-only dependencies
      // like SqliteException which break Web builds.
      Log.e(
        '[DB] ${context ?? 'Operation'} failed',
        e,
        stackTrace,
      );

      final errorMessage = e.toString();
      return Left(DatabaseFailure('Database error: $errorMessage'));
    }
  }

  /// Executes a database operation that returns void and returns [Either].
  ///
  /// - [operation]: The async database task to perform.
  /// - [context]: Optional description for better log messages.
  Future<Either<Failure, void>> performVoid(
    Future<void> Function() operation, {
    String? context,
  }) async {
    try {
      await operation();
      return const Right(null);
    } on Object catch (e, stackTrace) {
      Log.e(
        '[DB] ${context ?? 'Operation'} failed',
        e,
        stackTrace,
      );

      final errorMessage = e.toString();
      return Left(DatabaseFailure('Database error: $errorMessage'));
    }
  }

  /// Wraps a database stream with centralized error logging and re-propagation.
  Stream<T> handleStream<T>(Stream<T> stream, {String? context}) {
    return stream.handleError((Object e, StackTrace s) {
      Log.e('[DB] Stream ${context ?? ''} error', e, s);
      // Re-throw to ensure the error reaches consumers (e.g. AsyncValue.error)
      throw e;
    });
  }

  /// Executes a transaction with error handling and rethrows.
  ///
  /// Transactions usually need to fail completely to rollback,
  /// but we still want to log the error.
  Future<void> performTransaction(
    Future<void> Function() transaction, {
    String? context,
  }) async {
    try {
      await transaction();
    } on Object catch (e, stackTrace) {
      Log.e(
        '[DB] Transaction ${context ?? ''} failed',
        e,
        stackTrace,
      );
      rethrow;
    }
  }
}
