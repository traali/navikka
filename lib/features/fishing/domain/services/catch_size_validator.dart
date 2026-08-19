import 'package:sakkoja/features/fishing/domain/entities/catch_size.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';

enum CatchViolationSeverity {
  violation,
  warning,
  info,
}

class CatchViolation {
  const CatchViolation({
    required this.severity,
    required this.message,
  });
  final CatchViolationSeverity severity;
  final String message;
}

class CatchValidationResult {
  const CatchValidationResult({
    required this.isValid,
    required this.violations,
    this.minimumSizeCm,
  });
  final bool isValid;
  final List<CatchViolation> violations;
  final double? minimumSizeCm;

  List<String> get messages => violations.map((v) => v.message).toList();

  bool get hasViolations => violations.isNotEmpty;
}

class CatchSizeValidator {
  const CatchSizeValidator();

  CatchValidationResult validate({
    required FishSpecies species,
    required double? lengthCm,
    required List<CatchSize> regulations,
  }) {
    final violations = <CatchViolation>[];
    double? minSize;

    final regulation = regulations
        .where((r) => r.species == species)
        .firstOrNull;

    if (regulation == null) {
      return const CatchValidationResult(
        isValid: true,
        violations: [],
      );
    }

    minSize = regulation.minimumSizeCm;

    if (regulation.isProtected) {
      violations.add(
        CatchViolation(
          severity: CatchViolationSeverity.violation,
          message: '${species.displayName} on suojeluajanjakson alainen',
        ),
      );
      if (regulation.protectionStartDate != null &&
          regulation.protectionEndDate != null) {
        violations.add(
          CatchViolation(
            severity: CatchViolationSeverity.info,
            message:
                'Suoja-aika: ${_formatDate(regulation.protectionStartDate!)} - ${_formatDate(regulation.protectionEndDate!)}',
          ),
        );
      }
      return CatchValidationResult(
        isValid: false,
        violations: violations,
        minimumSizeCm: minSize,
      );
    }

    if (lengthCm != null) {
      if (minSize > 0 && lengthCm < minSize) {
        violations.add(
          CatchViolation(
            severity: CatchViolationSeverity.violation,
            message:
                '${species.displayName} pitää olla vähintään ${minSize.toInt()}cm (mitattu: ${lengthCm.toInt()}cm)',
          ),
        );
      }

      if (regulation.maximumSizeCm != null &&
          lengthCm > regulation.maximumSizeCm!) {
        violations.add(
          CatchViolation(
            severity: CatchViolationSeverity.violation,
            message:
                '${species.displayName} ylittää enimmäiskoon (${regulation.maximumSizeCm!.toInt()}cm)',
          ),
        );
      }
    } else if (minSize > 0) {
      violations.add(
        CatchViolation(
          severity: CatchViolationSeverity.warning,
          message:
              'Syötä pituus vahvistaaksesi mittavaatimuksen (min ${minSize.toInt()}cm)',
        ),
      );
    }

    final isViolated = violations.any(
      (v) => v.severity == CatchViolationSeverity.violation,
    );

    return CatchValidationResult(
      isValid: !isViolated,
      violations: violations,
      minimumSizeCm: minSize,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}';
  }
}
