import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/lat_lng_converter.dart';
import 'package:xml/xml.dart';

part 'sea_level_dto.freezed.dart';
part 'sea_level_dto.g.dart';

@freezed
abstract class SeaLevelDto with _$SeaLevelDto {
  const factory SeaLevelDto({
    required DateTime timestamp,
    @LatLngConverter() required LatLng location,
    String? stationName,
    double? seaLevel, // watlev (mm)
  }) = _SeaLevelDto;

  factory SeaLevelDto.fromJson(Map<String, dynamic> json) =>
      _$SeaLevelDtoFromJson(json);

  /// Parses timevaluepair format from FMI WFS.
  /// Reuses similar logic to WaveObservationDto but optimized for single parameter.
  static List<SeaLevelDto> fromTimeValuePair(XmlElement element) {
    final aggregatedData = <String, SeaLevelDto>{};

    final members = element.descendants.whereType<XmlElement>().where(
      (e) => e.name.local == 'PointTimeSeriesObservation',
    );

    for (final observation in members) {
      // 1. Station Info
      final featureOfInterest = observation.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'SF_SpatialSamplingFeature')
          .firstOrNull;

      final stationName = featureOfInterest?.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'name')
          .firstOrNull
          ?.innerText;

      // 2. Location
      final posElement = featureOfInterest?.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'pos')
          .firstOrNull;

      var location = const LatLng(0, 0);
      if (posElement != null) {
        final coords = posElement.innerText.trim().split(RegExp(r'\s+'));
        if (coords.length >= 2) {
          final lat = double.tryParse(coords[0]) ?? 0.0;
          final lon = double.tryParse(coords[1]) ?? 0.0;
          location = LatLng(lat, lon);
        }
      }

      // 3. Observed Property check (we only expect one: watlev)
      // The href is like: https://opendata.fmi.fi/meta?observableProperty=forecast&param=watlev&language=eng
      // So simple split('/') logic fails. We check if it contains param=watlev
      final observedPropertyHref = observation.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'observedProperty')
          .firstOrNull
          ?.getAttribute('xlink:href');

      if (observedPropertyHref == null ||
          !observedPropertyHref.contains('watlev')) {
        continue;
      }

      // 4. Extract time-value pairs
      final measurementPoints = observation.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'MeasurementTVP');

      for (final point in measurementPoints) {
        final timeStr = point.descendants
            .whereType<XmlElement>()
            .where((e) => e.name.local == 'time')
            .firstOrNull
            ?.innerText;
        final valueStr = point.descendants
            .whereType<XmlElement>()
            .where((e) => e.name.local == 'value')
            .firstOrNull
            ?.innerText;

        if (timeStr == null || stationName == null) continue;

        final timestamp = DateTime.tryParse(timeStr);
        if (timestamp == null) continue;

        // Strict NaN/Null handling
        final value = (valueStr == null || valueStr == 'NaN')
            ? null
            : double.tryParse(valueStr);

        // We use a simple unique key per station+time to handle updates if needed,
        // though for single-parameter this is simpler than Waves.
        // We just add directly to list effectively, but using map prevents dupes.
        final key = '${stationName}_${timestamp.millisecondsSinceEpoch}';

        aggregatedData[key] = SeaLevelDto(
          timestamp: timestamp,
          location: location,
          stationName: stationName,
          seaLevel: value,
        );
      }
    }

    return aggregatedData.values.toList();
  }
}
