import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_remote_data_source.dart';

void main() {
  group('ProviderResult', () {
    test('hasError is false when no error', () {
      const result = ProviderResult(data: [1, 2, 3], provider: 'Test');
      expect(result.hasError, false);
      expect(result.data, [1, 2, 3]);
    });

    test('hasError is true when error present', () {
      final error = Exception('Network error');
      final result = ProviderResult(
        data: [],
        error: error,
        provider: 'Test',
      );
      expect(result.hasError, true);
      expect(result.error, error);
      expect(result.data, isEmpty);
    });

    test('empty data with no error is valid', () {
      const result = ProviderResult(data: [], provider: 'Test');
      expect(result.hasError, false);
      expect(result.data, isEmpty);
    });
  });
}
