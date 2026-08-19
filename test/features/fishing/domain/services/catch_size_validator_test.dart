import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/fishing/domain/entities/catch_size.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';
import 'package:sakkoja/features/fishing/domain/services/catch_size_validator.dart';

void main() {
  group('CatchSizeValidator', () {
    late CatchSizeValidator validator;

    setUp(() {
      validator = const CatchSizeValidator();
    });

    group('validate', () {
      test('returns valid when no regulations exist', () {
        final result = validator.validate(
          species: FishSpecies.kuha,
          lengthCm: 30,
          regulations: const [],
        );
        expect(result.isValid, true);
        expect(result.violations, isEmpty);
      });

      test('returns valid when species has no regulation', () {
        final result = validator.validate(
          species: FishSpecies.hauki,
          lengthCm: 50,
          regulations: [
            const CatchSize(
              species: FishSpecies.kuha,
              minimumSizeCm: 42,
            ),
          ],
        );
        expect(result.isValid, true);
        expect(result.violations, isEmpty);
      });

      group('minimum size', () {
        test('returns valid when length meets minimum size', () {
          final result = validator.validate(
            species: FishSpecies.kuha,
            lengthCm: 50,
            regulations: [
              const CatchSize(
                species: FishSpecies.kuha,
                minimumSizeCm: 42,
              ),
            ],
          );
          expect(result.isValid, true);
          expect(result.violations, isEmpty);
        });

        test('returns violation when length below minimum size', () {
          final result = validator.validate(
            species: FishSpecies.kuha,
            lengthCm: 30,
            regulations: [
              const CatchSize(
                species: FishSpecies.kuha,
                minimumSizeCm: 42,
              ),
            ],
          );
          expect(result.isValid, false);
          expect(result.violations, hasLength(1));
          expect(
            result.violations.first.severity,
            CatchViolationSeverity.violation,
          );
          expect(result.minimumSizeCm, 42);
        });

        test('returns violation when length equals minimum size', () {
          final result = validator.validate(
            species: FishSpecies.kuha,
            lengthCm: 42,
            regulations: [
              const CatchSize(
                species: FishSpecies.kuha,
                minimumSizeCm: 42,
              ),
            ],
          );
          expect(result.isValid, true);
          expect(result.violations, isEmpty);
        });
      });

      group('maximum size', () {
        test('returns valid when length within maximum size', () {
          final result = validator.validate(
            species: FishSpecies.hauki,
            lengthCm: 80,
            regulations: [
              const CatchSize(
                species: FishSpecies.hauki,
                minimumSizeCm: 0,
                maximumSizeCm: 100,
              ),
            ],
          );
          expect(result.isValid, true);
          expect(result.violations, isEmpty);
        });

        test('returns violation when length exceeds maximum size', () {
          final result = validator.validate(
            species: FishSpecies.hauki,
            lengthCm: 110,
            regulations: [
              const CatchSize(
                species: FishSpecies.hauki,
                minimumSizeCm: 0,
                maximumSizeCm: 100,
              ),
            ],
          );
          expect(result.isValid, false);
          expect(result.violations, hasLength(1));
          expect(
            result.violations.first.severity,
            CatchViolationSeverity.violation,
          );
        });
      });

      group('protected season', () {
        test('returns violation when species is protected', () {
          final result = validator.validate(
            species: FishSpecies.hauki,
            lengthCm: 60,
            regulations: [
              const CatchSize(
                species: FishSpecies.hauki,
                minimumSizeCm: 0,
                isProtected: true,
              ),
            ],
          );
          expect(result.isValid, false);
          expect(result.violations, hasLength(1));
          expect(
            result.violations.first.severity,
            CatchViolationSeverity.violation,
          );
          expect(result.minimumSizeCm, 0);
        });

        test('includes protection dates when available', () {
          final result = validator.validate(
            species: FishSpecies.hauki,
            lengthCm: 60,
            regulations: [
              CatchSize(
                species: FishSpecies.hauki,
                minimumSizeCm: 0,
                isProtected: true,
                protectionStartDate: DateTime(2025, 4, 1),
                protectionEndDate: DateTime(2025, 6, 30),
              ),
            ],
          );
          expect(result.isValid, false);
          expect(result.violations, hasLength(2));
          expect(
            result.violations[0].severity,
            CatchViolationSeverity.violation,
          );
          expect(result.violations[1].severity, CatchViolationSeverity.info);
        });

        test(
          'returns only violation when species is protected with no dates',
          () {
            final result = validator.validate(
              species: FishSpecies.hauki,
              lengthCm: 60,
              regulations: [
                const CatchSize(
                  species: FishSpecies.hauki,
                  minimumSizeCm: 0,
                  isProtected: true,
                  protectionStartDate: null,
                  protectionEndDate: null,
                ),
              ],
            );
            expect(result.isValid, false);
            expect(result.violations, hasLength(1));
          },
        );
      });

      group('missing length', () {
        test(
          'returns warning when no length provided but minimum size exists',
          () {
            final result = validator.validate(
              species: FishSpecies.kuha,
              lengthCm: null,
              regulations: [
                const CatchSize(
                  species: FishSpecies.kuha,
                  minimumSizeCm: 42,
                ),
              ],
            );
            expect(result.isValid, true);
            expect(result.violations, hasLength(1));
            expect(
              result.violations.first.severity,
              CatchViolationSeverity.warning,
            );
          },
        );

        test('returns valid when no length and no minimum size', () {
          final result = validator.validate(
            species: FishSpecies.hauki,
            lengthCm: null,
            regulations: [
              const CatchSize(
                species: FishSpecies.hauki,
                minimumSizeCm: 0,
              ),
            ],
          );
          expect(result.isValid, true);
          expect(result.violations, isEmpty);
        });
      });

      group('messages getter', () {
        test('returns messages from violations', () {
          final result = validator.validate(
            species: FishSpecies.kuha,
            lengthCm: 30,
            regulations: [
              const CatchSize(
                species: FishSpecies.kuha,
                minimumSizeCm: 42,
              ),
            ],
          );
          expect(result.messages, hasLength(1));
          expect(result.messages.first, contains('42'));
        });
      });

      group('hasViolations', () {
        test('returns true when violations exist', () {
          final result = validator.validate(
            species: FishSpecies.kuha,
            lengthCm: 30,
            regulations: [
              const CatchSize(
                species: FishSpecies.kuha,
                minimumSizeCm: 42,
              ),
            ],
          );
          expect(result.hasViolations, true);
        });

        test('returns false when no violations', () {
          final result = validator.validate(
            species: FishSpecies.kuha,
            lengthCm: 50,
            regulations: [
              const CatchSize(
                species: FishSpecies.kuha,
                minimumSizeCm: 42,
              ),
            ],
          );
          expect(result.hasViolations, false);
        });

        test('returns true when only warnings (isValid still true)', () {
          final result = validator.validate(
            species: FishSpecies.kuha,
            lengthCm: null,
            regulations: [
              const CatchSize(
                species: FishSpecies.kuha,
                minimumSizeCm: 42,
              ),
            ],
          );
          expect(result.isValid, true);
          expect(result.hasViolations, true);
        });
      });

      group('multiple violations', () {
        test('returns violation for max size breach', () {
          final result = validator.validate(
            species: FishSpecies.hauki,
            lengthCm: 200,
            regulations: [
              const CatchSize(
                species: FishSpecies.hauki,
                minimumSizeCm: 30,
                maximumSizeCm: 100,
              ),
            ],
          );
          expect(result.isValid, false);
          expect(result.violations, hasLength(1));
          expect(
            result.violations.first.severity,
            CatchViolationSeverity.violation,
          );
          expect(result.violations.first.message, contains('enimmäiskoon'));
        });
      });
    });
  });
}
