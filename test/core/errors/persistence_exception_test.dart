import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/errors/persistence_exception.dart';

void main() {
  group('PersistenceException subclasses', () {
    test('RecordNotFoundException stores key in message', () {
      const exception = RecordNotFoundException('test_key');
      expect(exception.message, contains('test_key'));
      expect(exception.originalError, isNull);
    });

    test('CorruptedDataException stores key and error', () {
      const exception = CorruptedDataException('test_key', 'corruption');
      expect(exception.message, contains('test_key'));
      expect(exception.originalError, 'corruption');
    });

    test('StoreVersionMismatchException stores versions', () {
      const exception = StoreVersionMismatchException(1, 2);
      expect(exception.message, contains('1'));
      expect(exception.message, contains('2'));
      expect(exception.storedVersion, 1);
      expect(exception.currentVersion, 2);
    });

    test('exceptions implement Exception', () {
      expect(const RecordNotFoundException('k'), isA<Exception>());
      expect(const CorruptedDataException('k', null), isA<Exception>());
      expect(const StoreVersionMismatchException(1, 2), isA<Exception>());
    });

    test('toString includes message', () {
      const ex1 = RecordNotFoundException('key1');
      expect(ex1.toString(), contains('key1'));

      const ex2 = CorruptedDataException('key2', 'err');
      expect(ex2.toString(), contains('key2'));
      expect(ex2.toString(), contains('err'));
    });
  });
}
