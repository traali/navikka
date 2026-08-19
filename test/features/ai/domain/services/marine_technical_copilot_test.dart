import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/ai/domain/services/marine_technical_copilot_service.dart';

void main() {
  group('MarineTechnicalCopilotService - Engine Specs & Autoloader', () {
    test('resolves Volvo Penta specs correctly', () {
      final spec = MarineTechnicalCopilotService.getSpecForBrand('Volvo Penta');
      expect(spec, isNotNull);
      expect(spec?.oilType, contains('VDS-4.5'));
      expect(spec?.coolantType, contains('VCS'));
      expect(spec?.commonIssues.length, greaterThanOrEqualTo(2));
    });

    test('resolves Yamaha outboard specs correctly', () {
      final spec = MarineTechnicalCopilotService.getSpecForBrand('Yamaha');
      expect(spec, isNotNull);
      expect(spec?.oilType, contains('Yamalube'));
      expect(spec?.impellerPartHint, contains('6E5-44352'));
    });

    test('resolves Torqeedo electric propulsion specs correctly', () {
      final spec = MarineTechnicalCopilotService.getSpecForBrand('Torqeedo');
      expect(spec, isNotNull);
      expect(spec?.oilType, contains('Huoltovapaa sähkömoottori'));
    });

    test('returns null for unknown brand gracefully', () {
      final spec = MarineTechnicalCopilotService.getSpecForBrand(
        'CustomCraft 9000',
      );
      expect(spec, isNull);
    });
  });

  group('MarineTechnicalCopilotService - Symptom Diagnostic Engine', () {
    test('diagnoses overheating symptom and suggests impeller & seacock', () {
      final diagnosis = MarineTechnicalCopilotService.diagnoseSymptom(
        symptomQuery: 'Kone käy ylikuumana ja lämpö nousee',
        engineBrand: 'Volvo Penta',
        fuelType: 'Diesel',
      );
      expect(diagnosis, contains('Moottorin ylikuumeneminen'));
      expect(diagnosis, contains('seacock'));
      expect(diagnosis, contains('Impelleri'));
    });

    test('diagnoses fuel and stall issues with water separator checks', () {
      final diagnosis = MarineTechnicalCopilotService.diagnoseSymptom(
        symptomQuery: 'Moottori sammuu tyhjäkäynnillä eikä saa polttoainetta',
        engineBrand: 'Yamaha',
        fuelType: 'Bensiini',
      );
      expect(diagnosis, contains('Polttoaine'));
      expect(diagnosis, contains('Vedenerotin'));
    });

    test('provides oil specification query response', () {
      final diagnosis = MarineTechnicalCopilotService.diagnoseSymptom(
        symptomQuery: 'Mitä öljyä moottoriin pitää lisätä?',
        engineBrand: 'Volvo Penta',
        fuelType: 'Diesel',
      );
      expect(diagnosis, contains('Öljysuositus'));
      expect(diagnosis, contains('VDS-4.5'));
    });
  });
}
