import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/errors/exceptions.dart';

/// Tests for the Exception classes used in the data layer.
///
/// These exceptions bridge between raw SDK errors (DioException, SqliteException)
/// and the failure model.
void main() {
  group('ServerException', () {
    test('stores message and statusCode', () {
      const exception = ServerException('Not Found', 404);
      expect(exception.message, 'Not Found');
      expect(exception.statusCode, 404);
    });

    test('works without statusCode', () {
      const exception = ServerException('timeout');
      expect(exception.message, 'timeout');
      expect(exception.statusCode, isNull);
    });

    test('toString includes message and statusCode', () {
      const exception = ServerException('Forbidden', 403);
      expect(
        exception.toString(),
        'ServerException: Forbidden (403)',
      );
    });

    test('toString without statusCode', () {
      const exception = ServerException('timeout');
      expect(exception.toString(), 'ServerException: timeout');
    });

    test('implements Exception interface', () {
      const exception = ServerException('err');
      expect(exception, isA<Exception>());
    });
  });

  group('CacheException', () {
    test('stores message', () {
      const exception = CacheException('corrupt cache');
      expect(exception.message, 'corrupt cache');
    });

    test('toString includes message', () {
      const exception = CacheException('stale entry');
      expect(exception.toString(), 'CacheException: stale entry');
    });

    test('implements Exception interface', () {
      const exception = CacheException('err');
      expect(exception, isA<Exception>());
    });
  });

  group('Exception categorization', () {
    test('ServerException and CacheException are distinct', () {
      const server = ServerException('err');
      const cache = CacheException('err');

      expect(server.runtimeType, isNot(cache.runtimeType));
      expect(server, isA<ServerException>());
      expect(cache, isA<CacheException>());
    });

    test('both are Exceptions', () {
      expect(const ServerException(''), isA<Exception>());
      expect(const CacheException(''), isA<Exception>());
    });
  });
}
