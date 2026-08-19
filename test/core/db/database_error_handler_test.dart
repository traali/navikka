import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/db/database_error_handler.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/utils/logger.dart';

void main() {
  late DatabaseErrorHandler errorHandler;

  setUp(() {
    errorHandler = DatabaseErrorHandler();
    Log.reset(); // Clear logs before each test
  });

  /// Helper to wait for the Logger's microtask to update the notifier
  Future<void> flushLogs() async {
    await Future.microtask(() {});
    await Future<void>.delayed(Duration.zero);
  }

  group('DatabaseErrorHandler.perform', () {
    test('returns Right(result) on success', () async {
      final result = await errorHandler.perform(() async => 'success');

      expect(result, isA<Right<Failure, String>>());
      expect(result.getOrElse((_) => ''), 'success');

      await flushLogs();
      expect(Log.recentLogsNotifier.value.any((l) => l.contains('⛔')), false);
    });

    test('returns Left(DatabaseFailure) and logs on SqliteException', () async {
      final result = await errorHandler.perform<void>(
        () => throw SqliteException(extendedResultCode: 1, message: 'DB error'),
      );

      expect(result, isA<Left<Failure, dynamic>>());
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect(failure.message, contains('DB error'));
        },
        (_) => fail('Should have been a Left'),
      );

      await flushLogs();
      expect(
        Log.recentLogsNotifier.value.any((l) => l.contains('DB error')),
        true,
      );
    });

    test('returns Left(DatabaseFailure) on generic Exception', () async {
      final result = await errorHandler.perform<void>(
        () => throw Exception('Generic error'),
      );

      expect(result, isA<Left<Failure, dynamic>>());
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect(failure.message, contains('Database error'));
          expect(failure.message, contains('Generic error'));
        },
        (_) => fail('Should have been a Left'),
      );

      await flushLogs();
      expect(
        Log.recentLogsNotifier.value.any((l) => l.contains('Generic error')),
        true,
      );
    });
  });

  group('DatabaseErrorHandler.handleStream', () {
    test('emits data normally on success', () async {
      final stream = Stream.fromIterable(['data']);
      final handled = errorHandler.handleStream(stream);

      expect(await handled.first, 'data');
    });

    test('logs and re-throws on stream error', () async {
      final stream = Stream<String>.error(Exception('Stream failure'));
      final handled = errorHandler.handleStream(stream, context: 'test');

      await expectLater(
        () => handled.first,
        throwsA(isA<Exception>()),
      );

      await flushLogs();
      expect(
        Log.recentLogsNotifier.value.any(
          (l) => l.contains('Stream test error'),
        ),
        true,
      );
      expect(
        Log.recentLogsNotifier.value.any((l) => l.contains('Stream failure')),
        true,
      );
    });
  });

  group('DatabaseErrorHandler.performVoid', () {
    test('returns Right(null) on success', () async {
      var called = false;
      final result = await errorHandler.performVoid(
        () async {
          called = true;
        },
      );

      expect(result, isA<Right<Failure, void>>());
      expect(called, true);

      await flushLogs();
      expect(Log.recentLogsNotifier.value.any((l) => l.contains('⛔')), false);
    });

    test('returns Left(DatabaseFailure) and logs on error', () async {
      final result = await errorHandler.performVoid(
        () => throw Exception('Void operation failed'),
      );

      expect(result, isA<Left<Failure, void>>());
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect(failure.message, contains('Database error'));
          expect(failure.message, contains('Void operation failed'));
        },
        (_) => fail('Should have been a Left'),
      );

      await flushLogs();
      expect(
        Log.recentLogsNotifier.value.any(
          (l) => l.contains('Void operation failed'),
        ),
        true,
      );
    });
  });

  group('DatabaseErrorHandler.handleStream - edge cases', () {
    test('emits all values then completes', () async {
      final stream = Stream.fromIterable([1, 2, 3]);
      final handled = errorHandler.handleStream(stream);

      final results = await handled.toList();
      expect(results, [1, 2, 3]);
    });

    test('logs context message on error', () async {
      final stream = Stream<String>.error(Exception('Context test error'));
      final handled = errorHandler.handleStream(stream, context: 'MyContext');

      await expectLater(
        () => handled.first,
        throwsA(isA<Exception>()),
      );

      await flushLogs();
      expect(
        Log.recentLogsNotifier.value.any(
          (l) => l.contains('Stream MyContext error'),
        ),
        true,
      );
    });
  });

  group('DatabaseErrorHandler.performTransaction', () {
    test('rethrows SqliteException after logging', () async {
      await expectLater(
        () => errorHandler.performTransaction(
          () => throw SqliteException(
            extendedResultCode: 1,
            message: 'Transaction failed',
          ),
        ),
        throwsA(isA<SqliteException>()),
      );

      await flushLogs();
      expect(
        Log.recentLogsNotifier.value.any(
          (l) => l.contains('Transaction failed'),
        ),
        true,
      );
    });

    test('rethrows generic Exception after logging', () async {
      await expectLater(
        () => errorHandler.performTransaction(
          () => throw Exception('Generic failure'),
        ),
        throwsA(isA<Exception>()),
      );

      await flushLogs();
      expect(
        Log.recentLogsNotifier.value.any((l) => l.contains('Generic failure')),
        true,
      );
    });
  });
}
