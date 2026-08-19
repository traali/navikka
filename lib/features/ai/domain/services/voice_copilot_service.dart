import 'dart:async';
import 'package:sakkoja/core/utils/logger.dart';

enum VoiceCommandIntent {
  depthInquiry('Syvyyskysely', 'Tarkistetaan väyläsyvyys ja kölivara'),
  shelteredHarborInquiry(
    'Suojainen satama',
    'Etsitään lähin suojaisa satama nykyisellä tuulella',
  ),
  dropWaypoint(
    'Reittipisteen tallennus',
    'Merkitään nykyinen sijainti reittipisteeksi',
  ),
  weatherForecast(
    'Sää- ja tuuliennuste',
    'Haetaan tuulen suunta, nopeus ja puuskat',
  ),
  emergencyMayday(
    'Hätätila / Mayday',
    'Avataan MRCC-hätäpuhelu ja VHF-skripti',
  ),
  unknown(
    'Tuntematon komento',
    'Komennot: "Väyläsyvyys", "Suojaisa satama", "Merkitse piste", "Sääennuste"',
  );

  const VoiceCommandIntent(this.label, this.description);
  final String label;
  final String description;
}

class VoiceCommandResult {
  const VoiceCommandResult({
    required this.rawTranscript,
    required this.intent,
    required this.responseMessage,
    required this.isFinnish,
  });

  final String rawTranscript;
  final VoiceCommandIntent intent;
  final String responseMessage;
  final bool isFinnish;
}

class VoiceCopilotService {
  final _intentStreamController =
      StreamController<VoiceCommandResult>.broadcast();
  Stream<VoiceCommandResult> get onCommandResult =>
      _intentStreamController.stream;

  bool _isListening = false;
  bool get isListening => _isListening;

  void startListening() {
    _isListening = true;
    Log.i(
      '[VoiceCopilot] Listening for speech input ("Hei Kippari" / "Hey Skipper").',
    );
  }

  void stopListening() {
    _isListening = false;
    Log.i('[VoiceCopilot] Stopped speech listening.');
  }

  /// Parses speech transcript in Finnish or English into nautical intent and response.
  /// Uses live navigation and weather telemetry when provided, or falls back to
  /// safe un-hallucinated responses requiring the skipper to check nautical charts.
  static VoiceCommandResult parseSpeech(
    String transcript, {
    double? fairwayDepthMeters,
    double? vesselDraftMeters,
    String? nearestHarborName,
    double? nearestHarborDistanceNm,
    String? windSummary,
  }) {
    final lower = transcript.toLowerCase().trim();
    final isEn =
        lower.contains('how deep') ||
        lower.contains('shelter') ||
        lower.contains('waypoint') ||
        lower.contains('weather') ||
        lower.contains('wind') ||
        lower.contains('pin');

    // 1. Emergency
    if (lower.contains('hätä') ||
        lower.contains('mayday') ||
        lower.contains('pan-pan') ||
        lower.contains('emergency')) {
      return VoiceCommandResult(
        rawTranscript: transcript,
        intent: VoiceCommandIntent.emergencyMayday,
        responseMessage: isEn
            ? 'Emergency initiated: Opening MRCC VHF distress script and coordinates.'
            : 'Hätätila aktivoitu: Avataan MRCC Turku -hätäyhteys ja VHF-radiopuheteksti.',
        isFinnish: !isEn,
      );
    }

    // 2. Depth Inquiry
    if (lower.contains('syvyys') ||
        lower.contains('syvä') ||
        lower.contains('vettä') ||
        lower.contains('matala') ||
        lower.contains('köli') ||
        lower.contains('depth') ||
        lower.contains('how deep')) {
      String response;
      if (fairwayDepthMeters != null) {
        final draft = vesselDraftMeters ?? 0.0;
        final clearance = fairwayDepthMeters - draft;
        if (clearance < 0.5) {
          response = isEn
              ? 'Warning! Fairway depth is ${fairwayDepthMeters.toStringAsFixed(1)} m and under-keel clearance is only ${clearance.toStringAsFixed(1)} m. Shallow water!'
              : 'Varoitus! Väyläsyvyys on ${fairwayDepthMeters.toStringAsFixed(1)} m ja kölivara vain ${clearance.toStringAsFixed(1)} m. Matala vesi!';
        } else {
          response = isEn
              ? 'Depth check: Planned fairway minimum depth is ${fairwayDepthMeters.toStringAsFixed(1)} m. Under-keel clearance is ${clearance.toStringAsFixed(1)} m.'
              : 'Syvyystarkistus: Seuraavan väyläosuuden nimellissyvyys on ${fairwayDepthMeters.toStringAsFixed(1)} m. Kölivara: ${clearance.toStringAsFixed(1)} m.';
        }
      } else {
        response = isEn
            ? 'Depth check: No active fairway depth data at current GPS position. Check nautical chart.'
            : 'Syvyystarkistus: Ei aktiivista väyläsyvyystietoa nykyisessä GPS-sijainnissa. Tarkista merikartta.';
      }

      return VoiceCommandResult(
        rawTranscript: transcript,
        intent: VoiceCommandIntent.depthInquiry,
        responseMessage: response,
        isFinnish: !isEn,
      );
    }

    // 3. Drop Waypoint
    if (lower.contains('merk') ||
        lower.contains('piste') ||
        lower.contains('tallenna') ||
        lower.contains('waypoint') ||
        lower.contains('pin') ||
        lower.contains('mark') ||
        lower.contains('drop')) {
      return VoiceCommandResult(
        rawTranscript: transcript,
        intent: VoiceCommandIntent.dropWaypoint,
        responseMessage: isEn
            ? 'Waypoint created at current GPS position.'
            : 'Reittipiste tallennettu nykyiseen GPS-sijaintiin.',
        isFinnish: !isEn,
      );
    }

    // 4. Sheltered Harbor Inquiry
    if (lower.contains('satama') ||
        lower.contains('ankkuri') ||
        lower.contains('suoja') ||
        lower.contains('harbor') ||
        lower.contains('shelter') ||
        lower.contains('anchorage')) {
      String response;
      if (nearestHarborName != null) {
        final distStr = nearestHarborDistanceNm != null
            ? ' ${nearestHarborDistanceNm.toStringAsFixed(1)} NM'
            : '';
        response = isEn
            ? 'Sheltered harbor found: $nearestHarborName$distStr.'
            : 'Lähin suojaisa satama: $nearestHarborName$distStr.';
      } else {
        response = isEn
            ? 'Harbor check: No harbor data available for current location. Check nautical chart.'
            : 'Satamakysely: Ei satamatietoja saatavilla nykyiselle sijainnille. Tarkista merikartta.';
      }

      return VoiceCommandResult(
        rawTranscript: transcript,
        intent: VoiceCommandIntent.shelteredHarborInquiry,
        responseMessage: response,
        isFinnish: !isEn,
      );
    }

    // 5. Weather Forecast
    if (lower.contains('sää') ||
        lower.contains('tuuli') ||
        lower.contains('puuska') ||
        lower.contains('weather') ||
        lower.contains('forecast') ||
        lower.contains('wind')) {
      String response;
      if (windSummary != null) {
        response = isEn
            ? 'Weather forecast: $windSummary'
            : 'Sääennuste: $windSummary';
      } else {
        response = isEn
            ? 'Weather check: Real-time weather data unavailable. Check weather panel.'
            : 'Sääkysely: Reaaliaikaista säätietoa ei ole saatavilla. Tarkista sääpaneeli.';
      }

      return VoiceCommandResult(
        rawTranscript: transcript,
        intent: VoiceCommandIntent.weatherForecast,
        responseMessage: response,
        isFinnish: !isEn,
      );
    }

    return VoiceCommandResult(
      rawTranscript: transcript,
      intent: VoiceCommandIntent.unknown,
      responseMessage: isEn
          ? 'Command not recognized. Try saying: "Fairway depth", "Sheltered harbor", "Drop waypoint", or "Weather".'
          : 'Komentoa ei tunnistettu. Kokeile sanoa: "Väyläsyvyys", "Suojaisa satama", "Tallenna piste" tai "Sääennuste".',
      isFinnish: !isEn,
    );
  }

  void emitResult(VoiceCommandResult result) {
    _intentStreamController.add(result);
  }

  void dispose() {
    _intentStreamController.close();
  }
}
