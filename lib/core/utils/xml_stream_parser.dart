import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/models/lightning_strike_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';
import 'package:xml/xml_events.dart';

/// A specialized streaming XML parser for FMI data.
/// Uses [xml_events] to avoid loading the entire DOM into memory.
/// optimized text parsing to avoid GC pressure from String.split().
class XmlStreamParser {
  /// Parses WeatherForecastDto from XML string using streaming.
  static List<WeatherForecastDto> parseForecast(String xml) {
    final sw = Stopwatch()..start();
    try {
      final events = XmlEventDecoder().convert(xml);

      List<double>? positions;
      List<double>? values;

      var inPositions = false;
      var inValues = false;
      final positionsBuffer = StringBuffer();
      final valuesBuffer = StringBuffer();

      for (final event in events) {
        if (event is XmlStartElementEvent) {
          final localName = event.name.split(':').last;
          if (localName == 'positions') {
            inPositions = true;
          } else if (localName == 'doubleOrNilReasonTupleList' ||
              localName == 'doubleList') {
            inValues = true;
          }
        } else if (event is XmlEndElementEvent) {
          final localName = event.name.split(':').last;
          if (localName == 'positions') {
            inPositions = false;
            positions = _parseNumbers(positionsBuffer.toString());
            positionsBuffer.clear();
          } else if (localName == 'doubleOrNilReasonTupleList' ||
              localName == 'doubleList') {
            inValues = false;
            values = _parseNumbers(valuesBuffer.toString());
            valuesBuffer.clear();
          }
        } else if (event is XmlTextEvent) {
          if (inPositions) {
            positionsBuffer.write(event.value);
          } else if (inValues) {
            valuesBuffer.write(event.value);
          }
        }
      }

      if (positions == null || values == null) {
        Log.w(
          'XmlStreamParser [PARSE_WARN]: Missing positions or values in Forecast XML (${xml.length} bytes)',
        );
        return [];
      }

      final result = _mapForecast(positions, values);
      Log.d(
        'XmlStreamParser [SUCCESS]: Parsed ${result.length} forecast points in ${sw.elapsedMilliseconds}ms',
      );
      return result;
    } catch (e, s) {
      Log.e(
        'XmlStreamParser [PARSE_ERROR]: Forecast parsing failed after ${sw.elapsedMilliseconds}ms (${xml.length} bytes)',
        e,
        s,
      );
      return [];
    }
  }

  /// Parses WeatherObservationDto from XML string using streaming.
  static List<WeatherObservationDto> parseObservations(String xml) {
    final sw = Stopwatch()..start();
    try {
      final events = XmlEventDecoder().convert(xml);

      List<double>? positions;
      List<double>? values;
      String? stationName;
      final fieldNames = <String>[];

      var inPositions = false;
      var inValues = false;
      var inName = false;

      final positionsBuffer = StringBuffer();
      final valuesBuffer = StringBuffer();
      final nameBuffer = StringBuffer();

      for (final event in events) {
        if (event is XmlStartElementEvent) {
          final localName = event.name.split(':').last;
          if (localName == 'positions') {
            inPositions = true;
          } else if (localName == 'doubleOrNilReasonTupleList' ||
              localName == 'doubleList') {
            inValues = true;
          } else if (localName == 'name') {
            inName = true;
          } else if (localName == 'field') {
            for (final attr in event.attributes) {
              if (attr.name == 'name') {
                fieldNames.add(attr.value);
                break;
              }
            }
          }
        } else if (event is XmlEndElementEvent) {
          final localName = event.name.split(':').last;
          if (localName == 'positions') {
            inPositions = false;
            positions = _parseNumbers(positionsBuffer.toString());
            positionsBuffer.clear();
          } else if (localName == 'doubleOrNilReasonTupleList' ||
              localName == 'doubleList') {
            inValues = false;
            values = _parseNumbers(valuesBuffer.toString());
            valuesBuffer.clear();
          } else if (localName == 'name') {
            inName = false;
            if (stationName == null && nameBuffer.isNotEmpty) {
              stationName = nameBuffer.toString().trim();
            }
            nameBuffer.clear();
          }
        } else if (event is XmlTextEvent) {
          if (inPositions) {
            positionsBuffer.write(event.value);
          } else if (inValues) {
            valuesBuffer.write(event.value);
          } else if (inName) {
            nameBuffer.write(event.value);
          }
        }
      }

      if (positions == null || values == null) {
        return [];
      }

      final result = _mapObservations(
        positions,
        values,
        stationName,
        fieldNames,
      );
      return result;
    } catch (e, s) {
      Log.e(
        'XmlStreamParser [PARSE_ERROR]: Observation parsing failed after ${sw.elapsedMilliseconds}ms (${xml.length} bytes)',
        e,
        s,
      );
      return [];
    }
  }

  /// Parses LightningStrikeDto from XML string using streaming.
  static List<LightningStrikeDto> parseLightning(String xml) {
    try {
      final events = XmlEventDecoder().convert(xml);

      List<double>? positions;
      List<double>? values;

      var inPositions = false;
      var inValues = false;

      final positionsBuffer = StringBuffer();
      final valuesBuffer = StringBuffer();

      for (final event in events) {
        if (event is XmlStartElementEvent) {
          final localName = event.name.split(':').last;
          if (localName == 'positions') {
            inPositions = true;
          } else if (localName == 'doubleOrNilReasonTupleList' ||
              localName == 'doubleList') {
            inValues = true;
          }
        } else if (event is XmlEndElementEvent) {
          final localName = event.name.split(':').last;
          if (localName == 'positions') {
            inPositions = false;
            positions = _parseNumbers(positionsBuffer.toString());
            positionsBuffer.clear();
          } else if (localName == 'doubleOrNilReasonTupleList' ||
              localName == 'doubleList') {
            inValues = false;
            values = _parseNumbers(valuesBuffer.toString());
            valuesBuffer.clear();
          }
        } else if (event is XmlTextEvent) {
          if (inPositions) {
            positionsBuffer.write(event.value);
          } else if (inValues) {
            valuesBuffer.write(event.value);
          }
        }
      }

      if (positions == null || values == null) {
        return [];
      }

      final list = <LightningStrikeDto>[];
      final numItems = positions.length ~/ 3;
      if (numItems == 0) return [];
      final valueArity = values.length ~/ numItems;

      for (var i = 0; i < numItems; i++) {
        final posOffset = i * 3;
        final valOffset = i * valueArity;

        final lat = positions[posOffset];
        final lon = positions[posOffset + 1];
        final epoch = positions[posOffset + 2];

        final multiplicity = valOffset < values.length
            ? values[valOffset].toInt()
            : 0;
        final peakCurrent = valOffset + 1 < values.length
            ? values[valOffset + 1]
            : 0.0;

        list.add(
          LightningStrikeDto(
            time: DateTime.fromMillisecondsSinceEpoch(
              epoch.toInt() * 1000,
              isUtc: true,
            ),
            location: LatLng(lat, lon),
            peakCurrent: peakCurrent,
            multiplicity: multiplicity,
          ),
        );
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  /// Optimized number parser that avoids splitting strings.
  static List<double> _parseNumbers(String text) {
    final result = <double>[];
    int? start;

    for (var i = 0; i < text.length; i++) {
      final code = text.codeUnitAt(i);
      final isWhitespace = code == 32 || code == 9 || code == 10 || code == 13;

      if (!isWhitespace) {
        start ??= i;
      } else {
        if (start != null) {
          final substring = text.substring(start, i);
          if (substring == 'NaN' || substring == 'nil') {
            result.add(double.nan);
          } else {
            final val = double.tryParse(substring);
            if (val != null) result.add(val);
          }
          start = null;
        }
      }
    }
    if (start != null) {
      final substring = text.substring(start);
      if (substring == 'NaN' || substring == 'nil') {
        result.add(double.nan);
      } else {
        final val = double.tryParse(substring);
        if (val != null) result.add(val);
      }
    }

    return result;
  }

  static List<WeatherForecastDto> _mapForecast(
    List<double> positions,
    List<double> values,
  ) {
    final dtos = <WeatherForecastDto>[];

    if (positions.length % 3 != 0) return [];

    final numItems = positions.length ~/ 3;
    if (numItems == 0) return [];

    final valueArity = values.length ~/ numItems;

    for (var i = 0; i < numItems; i++) {
      final posOffset = i * 3;
      final valOffset = i * valueArity;

      final lat = positions[posOffset];
      final lon = positions[posOffset + 1];
      final epoch = positions[posOffset + 2];
      final timestamp = DateTime.fromMillisecondsSinceEpoch(
        epoch.toInt() * 1000,
        isUtc: true,
      );

      double? getVal(int offset) {
        if (offset >= valueArity) return null;
        final v = values[valOffset + offset];
        return v.isNaN ? null : v;
      }

      dtos.add(
        WeatherForecastDto(
          location: LatLng(lat, lon),
          timestamp: timestamp,
          temperature: getVal(0),
          windSpeed: getVal(1),
          windGust: getVal(2),
          windDirection: getVal(3),
          precipitation: getVal(4),
          pressure: getVal(5),
          humidity: getVal(6),
          dewPoint: getVal(7),
          cloudCover: getVal(8),
        ),
      );
    }

    return dtos;
  }

  static List<WeatherObservationDto> _mapObservations(
    List<double> positions,
    List<double> values,
    String? stationName,
    List<String> fieldNames,
  ) {
    final dtos = <WeatherObservationDto>[];

    if (positions.length % 3 != 0) return [];

    final numItems = positions.length ~/ 3;
    if (numItems == 0) return [];
    final valueArity = values.length ~/ numItems;

    // Default order
    var idxTemp = 0;
    var idxWind = 1;
    var idxGust = 2;
    var idxDir = 3;
    var idxPress = 4;
    var idxVis = 5;
    var idxHum = 6;
    var idxPrecip = 7;
    var idxCloud = 8;

    if (fieldNames.isNotEmpty) {
      idxTemp = fieldNames.indexOf('t2m');
      idxWind = fieldNames.indexOf('ws_10min');
      idxGust = fieldNames.indexOf('wg_10min');
      idxDir = fieldNames.indexOf('wd_10min');
      idxPress = fieldNames.indexOf('p_sea');
      idxVis = fieldNames.indexOf('vis');
      idxHum = fieldNames.indexOf('rh');
      idxPrecip = fieldNames.indexOf('r_1h');
      idxCloud = fieldNames.indexOf('n_man');
    }

    for (var i = 0; i < numItems; i++) {
      final posOffset = i * 3;
      final valOffset = i * valueArity;

      final lat = positions[posOffset];
      final lon = positions[posOffset + 1];
      final epoch = positions[posOffset + 2];
      final timestamp = DateTime.fromMillisecondsSinceEpoch(
        epoch.toInt() * 1000,
        isUtc: true,
      );

      double? getVal(int index) {
        if (index < 0 || index >= valueArity) return null;
        final v = values[valOffset + index];
        return v.isNaN ? null : v;
      }

      dtos.add(
        WeatherObservationDto(
          location: LatLng(lat, lon),
          timestamp: timestamp,
          stationName: stationName,
          temperature: getVal(idxTemp),
          windSpeed: getVal(idxWind),
          windGust: getVal(idxGust),
          windDirection: getVal(idxDir),
          pressure: getVal(idxPress),
          visibility: getVal(idxVis),
          humidity: getVal(idxHum),
          precipitation: getVal(idxPrecip),
          cloudCover: getVal(idxCloud),
        ),
      );
    }
    return dtos;
  }
}
