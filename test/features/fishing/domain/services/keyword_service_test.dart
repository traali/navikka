import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/fishing/domain/entities/keyword_config.dart';
import 'package:sakkoja/features/fishing/domain/services/keyword_service.dart';

void main() {
  group('KeywordService', () {
    late KeywordService service;

    setUp(() {
      service = KeywordService(KeywordConfig.fallback);
    });

    group('categorize', () {
      test('returns Verkkorajoitukset for specific mesh size text', () {
        expect(
          service.categorize('Verkkojen solmuväli 50mm', null, null),
          'Verkkorajoitukset',
        );
      });

      test('returns Verkkokalastus for general net restrictions', () {
        expect(
          service.categorize('Verkkokalastus kielletty', null, null),
          'Verkkokalastus',
        );
      });

      test('returns Pyydyskalastus for trap restrictions', () {
        expect(
          service.categorize('Rysäkalastus alueella', null, null),
          'Pyydyskalastus',
        );
      });

      test('returns Kalastuskielto for spawning areas', () {
        expect(
          service.categorize('Kutualue - kalastus kielletty', null, null),
          'Kalastuskielto',
        );
      });

      test('returns Veneilyrajoitus for motor restrictions', () {
        expect(
          service.categorize('Moottorikalastus kielletty', null, null),
          'Veneilyrajoitus',
        );
      });

      test('returns Muu for unknown categories', () {
        expect(service.categorize('Tuntematon rajoitus', null, null), 'Muu');
      });

      test('searches description field', () {
        expect(
          service.categorize('Alue X', 'Verkkokalastus kielletty', null),
          'Verkkokalastus',
        );
      });

      test('searches type field', () {
        expect(
          service.categorize('Alue Y', null, 'kutualue'),
          'Kalastuskielto',
        );
      });
    });

    group('getColorForCategory', () {
      test('returns correct color for Verkkokalastus', () {
        expect(service.getColorForCategory('Verkkokalastus'), 0xFFEF4444);
      });

      test('returns default color for unknown category', () {
        expect(service.getColorForCategory('Unknown'), 0xFF06B6D4);
      });
    });

    group('getIconForCategory', () {
      test('returns grid icon for Verkkokalastus', () {
        expect(service.getIconForCategory('Verkkokalastus'), 'grid_on');
      });

      test('returns default icon for unknown category', () {
        expect(service.getIconForCategory('Unknown'), 'warning_amber_rounded');
      });
    });

    group('getColorForText', () {
      test('returns correct color for net text', () {
        expect(service.getColorForText('verkko'), 0xFFEF4444);
      });

      test('returns default color for null', () {
        expect(service.getColorForText(null), 0xFF06B6D4);
      });
    });
  });

  group('KeywordConfig.fallback', () {
    test('has correct number of categories', () {
      expect(KeywordConfig.fallback.categories.length, 5);
    });

    test('has all expected category IDs', () {
      final ids = KeywordConfig.fallback.categories.map((c) => c.id).toList();
      expect(
        ids,
        containsAll([
          'verkkorajoitukset',
          'verkkokalastus',
          'pyydyskalastus',
          'kalastuskielto',
          'veneilyrajoitus',
        ]),
      );
    });
  });
}
