import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/map_constants.dart';

part 'map_config_service.g.dart';

class MapUrls {
  static const String traficomWmts =
      'https://julkinen.traficom.fi/rasteripalvelu/wmts?service=WMTS&request=GetTile&version=1.0.0&layer=Traficom%3AMerikarttasarjat+public&style=default&format=image%2Fpng&TileMatrixSet=WGS84_Pseudo-Mercator&TileMatrix=WGS84_Pseudo-Mercator:{z}&TileRow={y}&TileCol={x}';

  static const String openStreetMap = MapConstants.baseMapUrl;

  static const String vaylaWmts =
      'https://avoinapi.vaylapilvi.fi/rasterit/wmts/1.0.0/merikartta/default/ETRS-TM35FIN/{z}/{x}/{y}.png';
}

@riverpod
class MapConfigService extends _$MapConfigService {
  @override
  void build() {}

  String getTraficomUrl() => MapUrls.traficomWmts;
  String getOsmUrl() => MapUrls.openStreetMap;
  String getVaylaUrl() => MapUrls.vaylaWmts;
}
