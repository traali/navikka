import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/config/env.dart';

void main() {
  setUpAll(() {
    dotenv.loadFromString(envString: 'OPENWEATHER_API_KEY=test_key');
  });

  group('Env static accessors', () {
    test('openWeatherKey returns value or fallback', () {
      final key = Env.openWeatherKey;
      expect(key, isNotEmpty);
    });

    test('isStaging returns bool', () {
      final isStaging = Env.isStaging;
      expect(isStaging, anyOf(isTrue, isFalse));
    });

    test('sykeOdataBaseUrl returns configured URL', () {
      final url = Env.sykeOdataBaseUrl;
      expect(url, isNotEmpty);
      expect(url, contains('ymparisto'));
    });

    test('sykeWmsUrl returns configured URL', () {
      final url = Env.sykeWmsUrl;
      expect(url, isNotEmpty);
      expect(url, contains('ymparisto'));
    });

    test('dbName returns database name', () {
      final name = Env.dbName;
      expect(name, isNotEmpty);
    });
  });
}
