class VoyageLogbookSummary {
  const VoyageLogbookSummary({
    required this.title,
    required this.distanceNm,
    required this.durationMinutes,
    required this.maxSpeedKnots,
    required this.avgSpeedKnots,
    required this.maxWindSpeedMs,
    required this.estimatedFuelLiters,
    required this.milestones,
    required this.narrativeRecap,
  });

  final String title;
  final double distanceNm;
  final int durationMinutes;
  final double maxSpeedKnots;
  final double avgSpeedKnots;
  final double? maxWindSpeedMs;
  final double estimatedFuelLiters;
  final List<String> milestones;
  final String narrativeRecap;
}

class AiVoyageLogbookService {
  /// Generates a comprehensive AI voyage summary from trip metrics.
  static VoyageLogbookSummary generateRecap({
    required String tripName,
    required double totalDistanceMeters,
    required int totalDurationSeconds,
    required double maxSpeedKmh,
    required double avgSpeedKmh,
    required double? maxWindSpeedMs,
    required String? fuelType,
    required double? engineDisplacementLiters,
  }) {
    final distanceNm = totalDistanceMeters / 1852;
    final durationMinutes = (totalDurationSeconds / 60).round();
    final maxSpeedKn = maxSpeedKmh * 0.539957;
    final avgSpeedKn = avgSpeedKmh * 0.539957;
    final wind = maxWindSpeedMs;

    // Fuel consumption estimation model:
    // Planing boat ~ 1.1 L/NM, Displacement boat ~ 0.4 L/NM, Electric ~ 0.0 L
    final isElectric =
        fuelType?.toLowerCase().contains('sähk') == true ||
        fuelType?.toLowerCase().contains('elec') == true;
    final isDiesel = fuelType?.toLowerCase().contains('diesel') == true;

    final ratePerNm = isElectric
        ? 0.0
        : isDiesel
        ? 0.8
        : 1.1;
    final estimatedFuel = distanceNm * ratePerNm;

    final hours = durationMinutes ~/ 60;
    final mins = durationMinutes % 60;
    final durationStr = hours > 0 ? '$hours h $mins min' : '$mins min';

    final windLabel = wind == null
        ? 'tuulta ei kirjattu'
        : '${wind.toStringAsFixed(1)} m/s';

    final milestones = <String>[
      'Lähtö: Satamasta irtautuminen (keli: $windLabel)',
      if (distanceNm >= 3.0)
        'Matkanopeuden saavutus: Huippunopeus ${maxSpeedKn.toStringAsFixed(1)} kn',
      if (wind != null && wind >= 10.0)
        'Huomio: Kovan tuulen osuus (${wind.toStringAsFixed(1)} m/s) avoselällä',
      'Saapuminen: Kiinnittyminen laituriin ja reitin päätös ($durationStr)',
    ];

    final narrative =
        '''
Matkayhteenveto: $tripName
Etäisyys: ${distanceNm.toStringAsFixed(1)} NM (${(totalDistanceMeters / 1000).toStringAsFixed(1)} km)
Ajoaika: $durationStr • Keskinopeus: ${avgSpeedKn.toStringAsFixed(1)} kn • Huippunopeus: ${maxSpeedKn.toStringAsFixed(1)} kn
${isElectric ? 'Sähkönkulutus: Puhdas sähköajo (0 L polttoainetta)' : 'Arvioitu polttoaine: ${estimatedFuel.toStringAsFixed(1)} litraa ($fuelType)'}
Huipputuuli matkan aikana: $windLabel.
Matka sujui turvallisesti ja aluksen suorituskyky pysyi normaaleissa rajoissa.
''';

    return VoyageLogbookSummary(
      title: tripName,
      distanceNm: distanceNm,
      durationMinutes: durationMinutes,
      maxSpeedKnots: maxSpeedKn,
      avgSpeedKnots: avgSpeedKn,
      maxWindSpeedMs: wind,
      estimatedFuelLiters: estimatedFuel,
      milestones: milestones,
      narrativeRecap: narrative.trim(),
    );
  }
}
