import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/utils/xml_stream_parser.dart';

void main() {
  group('XmlStreamParser', () {
    test('parseForecast should parse Harmonie XML correctly', () {
      final xmlString = File(
        'test/fixtures/fmi_forecast_harmonie.xml',
      ).readAsStringSync();

      final result = XmlStreamParser.parseForecast(xmlString);

      expect(result, isNotEmpty);
      expect(
        result.length,
        2,
      ); // 2 time steps in the fixture: 1716199200 and 1716202800

      final first = result.first;
      expect(first.location.latitude, 60.1);
      expect(first.location.longitude, 25.0);
      expect(first.timestamp.isUtc, true);
      expect(first.timestamp.year, 2024);
      expect(first.temperature, 15.5);
      expect(first.windSpeed, 3.2);
      expect(first.windGust, 5.1);
      expect(first.windDirection, 180.0);
      expect(first.precipitation, 0.0);

      final second = result.last;
      expect(second.temperature, 16.0);
    });

    test('parseForecast should handle NaN values', () {
      // Mock XML with NaN
      const xml = '''
      <wfs:FeatureCollection>
         <gmlcov:MultiPointCoverage>
            <gmlcov:positions>60.0 25.0 1716199200</gmlcov:positions>
            <gml:doubleOrNilReasonTupleList>NaN 3.2 5.1 NaN 0.0</gml:doubleOrNilReasonTupleList>
         </gmlcov:MultiPointCoverage>
      </wfs:FeatureCollection>
      ''';

      final result = XmlStreamParser.parseForecast(xml);

      expect(result.length, 1);
      expect(result.first.temperature, isNull); // NaN -> null
      expect(result.first.windDirection, isNull);
      expect(result.first.windSpeed, 3.2);
    });
  });
}
