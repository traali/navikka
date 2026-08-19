import 'package:dio/dio.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/harbors/data/models/lipas_harbor_dto.dart';

abstract class LipasRemoteDataSource {
  Future<List<LipasHarborDto>> fetchHarbors();
}

class LipasRemoteDataSourceImpl implements LipasRemoteDataSource {
  LipasRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  static const String _baseUrl = 'https://api.lipas.fi/v2/sports-sites';

  @override
  Future<List<LipasHarborDto>> fetchHarbors() async {
    try {
      final response = await dio.get<dynamic>(
        _baseUrl,
        queryParameters: {
          'type-codes': [5110, 5120, 5130],
        },
      );

      final rawData = response.data;
      final List<dynamic>? items;
      if (rawData is Map<String, dynamic> && rawData['items'] is List) {
        items = rawData['items'] as List<dynamic>;
      } else if (rawData is List) {
        items = rawData;
      } else {
        items = null;
      }

      if (items != null && items.isNotEmpty) {
        final harbors = <LipasHarborDto>[];
        for (final item in items) {
          if (item is Map<String, dynamic>) {
            try {
              final location = item['location'] as Map<String, dynamic>?;
              final coordinates =
                  location?['geometries']?['features']?[0]?['geometry']?['coordinates']
                      as List<dynamic>?;

              if (coordinates != null && coordinates.length >= 2) {
                final lon = (coordinates[0] as num).toDouble();
                final lat = (coordinates[1] as num).toDouble();
                final id =
                    (item['lipas-id'] as num?)?.toInt() ??
                    (item['sportsPlaceId'] as num?)?.toInt() ??
                    0;
                final typeCode =
                    (item['type']?['type-code'] as num?)?.toInt() ??
                    (item['type']?['typeCode'] as num?)?.toInt() ??
                    5110;
                harbors.add(
                  LipasHarborDto(
                    sportsPlaceId: id,
                    name: item['name'] as String? ?? 'Satama',
                    typeCode: typeCode,
                    latitude: lat,
                    longitude: lon,
                    municipalityName:
                        item['location']?['city']?['name'] as String?,
                  ),
                );
              }
            } catch (e) {
              Log.w('LipasRemoteDataSource: Error parsing item: $e');
            }
          }
        }
        if (harbors.isNotEmpty) return harbors;
      }
    } catch (e) {
      Log.w(
        'LipasRemoteDataSource: API fetch failed, falling back to curated harbors: $e',
      );
    }

    return _fallbackHarbors;
  }

  static const List<LipasHarborDto> _fallbackHarbors = [
    // UUVI & Uusimaa Excursion Harbors
    LipasHarborDto(
      sportsPlaceId: 9001,
      name: 'Elisaari (UUVI)',
      typeCode: 5120,
      latitude: 59.9880,
      longitude: 23.9050,
      municipalityName: 'Inkoo',
      hasSauna: true,
      hasCampfire: true,
      hasWater: true,
      hasSeptic: true,
      berths: 40,
      depthMeters: 2.4,
    ),
    LipasHarborDto(
      sportsPlaceId: 9002,
      name: 'Linlo (UUVI)',
      typeCode: 5120,
      latitude: 60.0320,
      longitude: 24.4210,
      municipalityName: 'Kirkkonummi',
      hasCampfire: true,
      hasSeptic: true,
      berths: 25,
      depthMeters: 1.8,
    ),
    LipasHarborDto(
      sportsPlaceId: 9003,
      name: 'Kopparnäs (UUVI)',
      typeCode: 5120,
      latitude: 60.0150,
      longitude: 24.2530,
      municipalityName: 'Inkoo',
      hasCampfire: true,
      hasSeptic: true,
      berths: 20,
      depthMeters: 1.5,
    ),
    LipasHarborDto(
      sportsPlaceId: 9004,
      name: 'Stora Krokö (UUVI)',
      typeCode: 5120,
      latitude: 60.2110,
      longitude: 25.8450,
      municipalityName: 'Porvoo',
      hasSauna: true,
      hasCampfire: true,
      hasSeptic: true,
      berths: 15,
      depthMeters: 2,
    ),
    // Capital & Coast Guest Harbors
    LipasHarborDto(
      sportsPlaceId: 9005,
      name: 'Suomenlinna Vierasvenesatama',
      typeCode: 5110,
      latitude: 60.1460,
      longitude: 24.9860,
      municipalityName: 'Helsinki',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 45,
      depthMeters: 3,
    ),
    LipasHarborDto(
      sportsPlaceId: 9006,
      name: 'Vallisaari Retkisatama',
      typeCode: 5120,
      latitude: 60.1380,
      longitude: 25.0040,
      municipalityName: 'Helsinki',
      hasCampfire: true,
      hasSeptic: true,
      berths: 30,
      depthMeters: 2.5,
    ),
    LipasHarborDto(
      sportsPlaceId: 9007,
      name: 'Kaunissaari (Pyhtää)',
      typeCode: 5120,
      latitude: 60.3440,
      longitude: 26.7720,
      municipalityName: 'Pyhtää',
      hasSauna: true,
      hasCampfire: true,
      hasSeptic: true,
      berths: 60,
      depthMeters: 2.2,
    ),
    LipasHarborDto(
      sportsPlaceId: 9008,
      name: 'Hanko Itäsatama',
      typeCode: 5110,
      latitude: 59.8240,
      longitude: 22.9730,
      municipalityName: 'Hanko',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 220,
      depthMeters: 3.5,
    ),
    LipasHarborDto(
      sportsPlaceId: 9009,
      name: 'Tammisaari Pohjoissatama',
      typeCode: 5110,
      latitude: 59.9770,
      longitude: 23.4310,
      municipalityName: 'Raasepori',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 100,
      depthMeters: 2.8,
    ),
    LipasHarborDto(
      sportsPlaceId: 9010,
      name: 'Porkkala Vierasvenesatama',
      typeCode: 5110,
      latitude: 59.9880,
      longitude: 24.4280,
      municipalityName: 'Kirkkonummi',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 70,
      depthMeters: 2.5,
    ),
    LipasHarborDto(
      sportsPlaceId: 9011,
      name: 'Jurmo Retkisatama',
      typeCode: 5120,
      latitude: 59.8270,
      longitude: 21.6020,
      municipalityName: 'Parainen',
      hasSauna: true,
      hasCampfire: true,
      hasSeptic: true,
      berths: 35,
      depthMeters: 2,
    ),
    LipasHarborDto(
      sportsPlaceId: 9012,
      name: 'Utö Vierasvenesatama',
      typeCode: 5110,
      latitude: 59.7820,
      longitude: 21.3690,
      municipalityName: 'Parainen',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 50,
      depthMeters: 3,
    ),
    LipasHarborDto(
      sportsPlaceId: 9013,
      name: 'Högsåra Kejsarhamn',
      typeCode: 5120,
      latitude: 59.9570,
      longitude: 22.3640,
      municipalityName: 'Kemiösaari',
      hasSauna: true,
      hasCampfire: true,
      hasSeptic: true,
      berths: 40,
      depthMeters: 2.4,
    ),
    LipasHarborDto(
      sportsPlaceId: 9014,
      name: 'Kasnäs Vierasvenesatama',
      typeCode: 5110,
      latitude: 59.9210,
      longitude: 22.4080,
      municipalityName: 'Kemiösaari',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 100,
      depthMeters: 3.2,
    ),
    LipasHarborDto(
      sportsPlaceId: 9015,
      name: 'Kotka Sapokka Vierasvenesatama',
      typeCode: 5110,
      latitude: 60.4570,
      longitude: 26.9530,
      municipalityName: 'Kotka',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 80,
      depthMeters: 3,
    ),
    LipasHarborDto(
      sportsPlaceId: 9016,
      name: 'Porvoo Vierasvenesatama',
      typeCode: 5110,
      latitude: 60.3920,
      longitude: 25.6580,
      municipalityName: 'Porvoo',
      hasSauna: true,
      hasWater: true,
      hasElectricity: true,
      hasSeptic: true,
      berths: 50,
      depthMeters: 2.2,
    ),
  ];
}
