import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/errors/failure.dart';

/// Tests for the Failure hierarchy used throughout Sakkoja.
///
/// SAFETY CRITICAL: Failure types carry human-readable error messages that
/// may be displayed to the user or logged to diagnostics.
void main() {
  group('Failure base class', () {
    test('stores message correctly', () {
      const failure = GeneralFailure('test error');
      expect(failure.message, 'test error');
    });

    test('toString includes runtimeType and message', () {
      const failure = GeneralFailure('test error');
      expect(failure.toString(), 'GeneralFailure: test error');
    });

    test('works with empty message', () {
      const failure = GeneralFailure('');
      expect(failure.message, '');
    });
  });

  group('ServerFailure', () {
    test('accepts custom message', () {
      const failure = ServerFailure('500 Internal Server Error');
      expect(failure.message, '500 Internal Server Error');
      expect(failure, isA<Failure>());
    });

    test('toString is correct', () {
      const failure = ServerFailure('timeout');
      expect(failure.toString(), 'ServerFailure: timeout');
    });
  });

  group('NetworkFailure', () {
    test('has default message', () {
      const failure = NetworkFailure();
      expect(failure.message, 'Network unavailable');
    });

    test('accepts custom message', () {
      const failure = NetworkFailure('WiFi turned off');
      expect(failure.message, 'WiFi turned off');
    });

    test('is a Failure', () {
      expect(const NetworkFailure(), isA<Failure>());
    });
  });

  group('CacheFailure', () {
    test('stores message', () {
      const failure = CacheFailure('stale data');
      expect(failure.message, 'stale data');
    });
  });

  group('ParsingFailure', () {
    test('has default message', () {
      const failure = ParsingFailure();
      expect(failure.message, 'Failed to parse data');
    });

    test('accepts custom message', () {
      const failure = ParsingFailure('XML malformed at line 42');
      expect(failure.message, 'XML malformed at line 42');
    });
  });

  group('ValidationFailure', () {
    test('stores message', () {
      const failure = ValidationFailure('speed exceeds limit');
      expect(failure.message, 'speed exceeds limit');
    });
  });

  group('DatabaseFailure', () {
    test('stores message', () {
      const failure = DatabaseFailure('table not found');
      expect(failure.message, 'table not found');
    });
  });

  group('GeneralFailure', () {
    test('stores message', () {
      const failure = GeneralFailure('unexpected error');
      expect(failure.message, 'unexpected error');
    });
  });

  group('Failure pattern matching with isA', () {
    test('can identify NetworkFailure from list', () {
      final failures = <Failure>[
        const ServerFailure('err'),
        const NetworkFailure(),
        const ParsingFailure(),
      ];

      final networkFailures = failures.whereType<NetworkFailure>().toList();
      expect(networkFailures.length, 1);
    });

    test('can use isA checks in test assertions', () {
      const failure = ServerFailure('bad gateway');
      expect(failure, isA<ServerFailure>());
      expect(failure, isA<Failure>());
      expect(failure, isNot(isA<NetworkFailure>()));
    });
  });

  group('Failure const constructors', () {
    test('all failure types have const constructors', () {
      expect(const ServerFailure(''), isA<ServerFailure>());
      expect(const CacheFailure(''), isA<CacheFailure>());
      expect(const NetworkFailure(), isA<NetworkFailure>());
      expect(const ParsingFailure(), isA<ParsingFailure>());
      expect(const ValidationFailure(''), isA<ValidationFailure>());
      expect(const DatabaseFailure(''), isA<DatabaseFailure>());
      expect(const GeneralFailure(''), isA<GeneralFailure>());
    });
  });
}
