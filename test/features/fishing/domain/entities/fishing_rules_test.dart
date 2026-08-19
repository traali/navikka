import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';

void main() {
  group('Fishing Constraint Rules', () {
    test('Weight must be positive', () {
      expect(
        () => FishCatch(
          id: '1',
          species: FishSpecies.lohi,
          weightGrams: -1,
          lengthCm: 50,
          timestamp: DateTime.now(),
          location: const LatLng(0, 0),
        ),
        throwsAssertionError,
      );
    });

    test('Length must be positive', () {
      expect(
        () => FishCatch(
          id: '1',
          species: FishSpecies.lohi,
          weightGrams: 5000,
          lengthCm: -50,
          timestamp: DateTime.now(),
          location: const LatLng(0, 0),
        ),
        throwsAssertionError,
      );
    });
  });
}
