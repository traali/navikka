import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/ai/domain/services/voice_copilot_service.dart';

void main() {
  group('VoiceCopilotService - Bilingual Speech Command Parsing', () {
    test(
      'parses Finnish depth inquiry command with dynamic fairway depth and clearance',
      () {
        final res = VoiceCopilotService.parseSpeech(
          'Kuinka paljon vettä on kapeikossa?',
          fairwayDepthMeters: 4.5,
          vesselDraftMeters: 1.2,
        );
        expect(res.intent, VoiceCommandIntent.depthInquiry);
        expect(res.isFinnish, isTrue);
        expect(res.responseMessage, contains('4.5 m'));
        expect(res.responseMessage, contains('3.3 m'));
      },
    );

    test('warns on dangerous shallow water depth inquiry', () {
      final res = VoiceCopilotService.parseSpeech(
        'Kuinka syvää täällä on?',
        fairwayDepthMeters: 1.5,
        vesselDraftMeters: 1.3,
      );
      expect(res.intent, VoiceCommandIntent.depthInquiry);
      expect(res.isFinnish, isTrue);
      expect(res.responseMessage, contains('Varoitus!'));
      expect(res.responseMessage, contains('0.2 m'));
    });

    test('falls back safely when no depth data is available', () {
      final res = VoiceCopilotService.parseSpeech(
        'Kuinka paljon vettä on kapeikossa?',
      );
      expect(res.intent, VoiceCommandIntent.depthInquiry);
      expect(res.isFinnish, isTrue);
      expect(res.responseMessage, contains('Ei aktiivista väyläsyvyystietoa'));
    });

    test('parses English depth inquiry command with telemetry', () {
      final res = VoiceCopilotService.parseSpeech(
        'How deep is the fairway ahead?',
        fairwayDepthMeters: 7.0,
        vesselDraftMeters: 1.5,
      );
      expect(res.intent, VoiceCommandIntent.depthInquiry);
      expect(res.isFinnish, isFalse);
      expect(res.responseMessage, contains('7.0 m'));
      expect(res.responseMessage, contains('5.5 m'));
    });

    test(
      'parses sheltered harbor inquiry in Finnish with dynamic harbor telemetry',
      () {
        final res = VoiceCopilotService.parseSpeech(
          'Mikä on lähin suojaisa satama?',
          nearestHarborName: 'Utö vierassatama',
          nearestHarborDistanceNm: 4.2,
        );
        expect(res.intent, VoiceCommandIntent.shelteredHarborInquiry);
        expect(res.responseMessage, contains('Utö vierassatama'));
        expect(res.responseMessage, contains('4.2 NM'));
      },
    );

    test('falls back safely on sheltered harbor when no harbor nearby', () {
      final res = VoiceCopilotService.parseSpeech(
        'Mikä on lähin suojaisa satama?',
      );
      expect(res.intent, VoiceCommandIntent.shelteredHarborInquiry);
      expect(res.responseMessage, contains('Ei satamatietoja saatavilla'));
    });

    test('parses waypoint drop command', () {
      final res = VoiceCopilotService.parseSpeech(
        'Merkitse tämä piste hyväksi ankkuripaikaksi',
      );
      expect(res.intent, VoiceCommandIntent.dropWaypoint);
      expect(res.responseMessage, contains('Reittipiste tallennettu'));
    });

    test('parses weather forecast command with live wind telemetry', () {
      final res = VoiceCopilotService.parseSpeech(
        'Mikä on tuuliennuste seuraaville tunneille?',
        windSummary: 'Länsituulta 8.5 m/s, puuskat 12.0 m/s',
      );
      expect(res.intent, VoiceCommandIntent.weatherForecast);
      expect(res.responseMessage, contains('Länsituulta 8.5 m/s'));
    });

    test('parses emergency / Mayday trigger', () {
      final res = VoiceCopilotService.parseSpeech(
        'Mayday Mayday Mayday hätätilanne',
      );
      expect(res.intent, VoiceCommandIntent.emergencyMayday);
      expect(res.responseMessage, contains('MRCC'));
    });
  });
}
