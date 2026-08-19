import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/lat_lng_converter.dart';
import 'package:xml/xml.dart';

part 'wave_observation_dto.freezed.dart';
part 'wave_observation_dto.g.dart';

@freezed
abstract class WaveObservationDto with _$WaveObservationDto {
  const factory WaveObservationDto({
    required DateTime timestamp,
    @LatLngConverter() required LatLng location,
    String? stationName,
    double? waveHeight,
    double? wavePeriod,
    double? waveDirection,
    double? waterTemperature,
  }) = _WaveObservationDto;

  factory WaveObservationDto.fromJson(Map<String, dynamic> json) =>
      _$WaveObservationDtoFromJson(json);

  /// Parses timevaluepair format from FMI WFS.
  /// Each member contains a PointTimeSeriesObservation with measurement values.
  static List<WaveObservationDto> fromTimeValuePair(XmlElement element) {
    // Map key: "stationName_timestampInMillis" -> DTO (we'll build it up)
    final aggregatedData = <String, WaveObservationDto>{};

    // Find all PointTimeSeriesObservation members
    final members = element.descendants.whereType<XmlElement>().where(
      (e) => e.name.local == 'PointTimeSeriesObservation',
    );

    for (final observation in members) {
      // Extract station info
      final featureOfInterest = observation.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'SF_SpatialSamplingFeature')
          .firstOrNull;

      final stationName = featureOfInterest?.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'name')
          .firstOrNull
          ?.innerText;

      // Extract location (Point -> pos)
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

      // Extract observed property (parameter name)
      // The href is a full URL like:
      //   https://opendata.fmi.fi/meta?observableProperty=observation&param=WaveHs&language=eng
      // We need to extract the 'param' query parameter, not split('/').last.
      final observedPropertyHref = observation.descendants
          .whereType<XmlElement>()
          .where((e) => e.name.local == 'observedProperty')
          .firstOrNull
          ?.getAttribute('xlink:href');
      final observedProperty = observedPropertyHref != null
          ? Uri.tryParse(observedPropertyHref)?.queryParameters['param']
          : null;

      // Extract time-value pairs
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
        double? safeDouble(String? v) {
          if (v == null || v == 'NaN' || v.toLowerCase() == 'nan') return null;
          final d = double.tryParse(v);
          return (d == null || d.isNaN) ? null : d;
        }

        final value = safeDouble(valueStr);

        final key = '${stationName}_${timestamp.millisecondsSinceEpoch}';

        // Get existing or create new
        final existing =
            aggregatedData[key] ??
            WaveObservationDto(
              timestamp: timestamp,
              location: location,
              stationName: stationName,
            );

        // Update with new value
        var updated = existing;
        switch (observedProperty) {
          case 'WaveHs':
            updated = existing.copyWith(
              waveHeight: value ?? existing.waveHeight,
            );
          case 'WTP': // Modal Period
            updated = existing.copyWith(
              wavePeriod: value ?? existing.wavePeriod,
            );
          case 'ModalWDi': // Modal Wave Direction
            updated = existing.copyWith(
              waveDirection: value ?? existing.waveDirection,
            );
          case 'TWATER': // Water Temperature
            updated = existing.copyWith(
              waterTemperature: value ?? existing.waterTemperature,
            );
        }
        aggregatedData[key] = updated;
      }
    }

    return aggregatedData.values.toList();
  }
}
