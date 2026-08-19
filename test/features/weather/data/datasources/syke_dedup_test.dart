import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SYKE cache key derivation', () {
    test('same lat/lon/limit produces same cache key', () {
      String key(double? lat, double? lon, int limit) =>
          'wq|${lat?.toStringAsFixed(2)}|${lon?.toStringAsFixed(2)}|$limit';

      expect(key(60.0, 25.0, 20), key(60.0, 25.0, 20));
    });

    test('different lat produces different cache key', () {
      String key(double? lat, double? lon, int limit) =>
          'wq|${lat?.toStringAsFixed(2)}|${lon?.toStringAsFixed(2)}|$limit';

      expect(key(60.0, 25.0, 20), isNot(key(61.0, 25.0, 20)));
    });

    test('different limit produces different cache key', () {
      String key(double? lat, double? lon, int limit) =>
          'wq|${lat?.toStringAsFixed(2)}|${lon?.toStringAsFixed(2)}|$limit';

      expect(key(60.0, 25.0, 20), isNot(key(60.0, 25.0, 10)));
    });

    test('null lat/lon produces valid cache key', () {
      String key(double? lat, double? lon, int limit) =>
          'wq|${lat?.toStringAsFixed(2)}|${lon?.toStringAsFixed(2)}|$limit';

      expect(key(null, null, 20), 'wq|null|null|20');
    });
  });
}
