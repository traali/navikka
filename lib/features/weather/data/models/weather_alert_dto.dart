import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/lat_lng_converter.dart';
import 'package:xml/xml.dart';

part 'weather_alert_dto.freezed.dart';
part 'weather_alert_dto.g.dart';

@freezed
abstract class WeatherAlertDto with _$WeatherAlertDto {
  const factory WeatherAlertDto({
    required String id,
    required String event,
    required String description,
    required String severity,
    required DateTime onset,
    required DateTime expires,
    @LatLngListConverter() required List<LatLng> polygon,
    required String areaDescription,
    DateTime? issued,
  }) = _WeatherAlertDto;

  factory WeatherAlertDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherAlertDtoFromJson(json);

  factory WeatherAlertDto.fromXml(XmlElement element) {
    // CAP XML structure: info element contains most details
    // SEARCH BY LOCAL NAME to avoid namespace/prefix issues
    final infoElements = element.descendants
        .whereType<XmlElement>()
        .where((e) => e.name.local == 'info')
        .toList();

    // Prioritize Finnish info block if multiple exist
    var info = infoElements.firstOrNull ?? element;
    if (infoElements.length > 1) {
      info = infoElements.firstWhere(
        (e) =>
            e.descendants
                .whereType<XmlElement>()
                .where((child) => child.name.local == 'language')
                .firstOrNull
                ?.innerText ==
            'fi-FI',
        orElse: () => infoElements.first,
      );
    }

    String getVal(String name) =>
        info.descendants
            .whereType<XmlElement>()
            .where((e) => e.name.local == name)
            .firstOrNull
            ?.innerText ??
        '';

    final sentStr =
        element.descendants
            .whereType<XmlElement>()
            .where((e) => e.name.local == 'sent')
            .firstOrNull
            ?.innerText ??
        '';

    final event = getVal('event').isEmpty ? 'Unknown Alert' : getVal('event');
    final description = getVal('description');
    final severityRaw = getVal('severity').toLowerCase();
    final severity =
        const {
          'minor',
          'moderate',
          'severe',
          'extreme',
        }.contains(severityRaw)
        ? severityRaw
        : 'minor';
    final onsetStr = getVal('onset');
    final expiresStr = getVal('expires');

    // Boundary parsing: looking for polygon in area element
    final areaNode = info.descendants
        .whereType<XmlElement>()
        .where((e) => e.name.local == 'area')
        .firstOrNull;

    final areaDesc =
        areaNode?.descendants
            .whereType<XmlElement>()
            .where((e) => e.name.local == 'areaDesc')
            .firstOrNull
            ?.innerText ??
        '';

    final polygonStr =
        areaNode?.descendants
            .whereType<XmlElement>()
            .where((e) => e.name.local == 'polygon')
            .firstOrNull
            ?.innerText ??
        '';

    final boundary = _parsePolygon(polygonStr);

    return WeatherAlertDto(
      id:
          element.descendants
              .whereType<XmlElement>()
              .where((e) => e.name.local == 'identifier')
              .firstOrNull
              ?.innerText ??
          DateTime.now().toIso8601String(),
      event: event,
      description: description,
      severity: severity,
      onset: onsetStr.isNotEmpty
          ? DateTime.tryParse(onsetStr) ?? DateTime.now()
          : DateTime.now(),
      expires: expiresStr.isNotEmpty
          ? DateTime.tryParse(expiresStr) ?? DateTime.now()
          : DateTime.now(),
      issued: sentStr.isNotEmpty ? DateTime.tryParse(sentStr) : null,
      polygon: boundary,
      areaDescription: areaDesc,
    );
  }

  static List<LatLng> _parsePolygon(String polygonStr) {
    if (polygonStr.isEmpty) return [];
    try {
      // CAP polygons are space-separated: "lat1 lon1 lat2 lon2 ..."
      final values = polygonStr.trim().split(RegExp(r'\s+'));
      final result = <LatLng>[];
      for (var i = 0; i < values.length - 1; i += 2) {
        final lat = double.tryParse(values[i]);
        final lon = double.tryParse(values[i + 1]);
        if (lat == null || lon == null) continue;
        result.add(LatLng(lat, lon));
      }
      return result;
    } catch (_) {
      return [];
    }
  }
}
