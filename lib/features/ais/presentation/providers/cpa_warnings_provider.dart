import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';
import 'package:sakkoja/features/ais/domain/entities/cpa_result.dart';
import 'package:sakkoja/features/ais/domain/usecases/calculate_cpa_warnings_usecase.dart';
import 'package:sakkoja/features/ais/presentation/providers/ais_targets_provider.dart';

part 'cpa_warnings_provider.g.dart';

@riverpod
List<CpaResult> cpaWarnings(
  Ref ref, {
  required LatLng ownPosition,
  required double ownSogKnots,
  required double ownCogDegrees,
}) {
  final targetsAsync = ref.watch(aisTargetsProvider);
  final List<AisTarget> targets = targetsAsync.value ?? <AisTarget>[];

  if (targets.isEmpty) return const <CpaResult>[];

  final useCase = CalculateCpaWarningsUseCase();
  final results = <CpaResult>[];

  for (final target in targets) {
    final result = useCase.execute(
      ownPos: ownPosition,
      ownSogKnots: ownSogKnots,
      ownCogDegrees: ownCogDegrees,
      target: target,
    );

    if (result.isDangerous) {
      results.add(result);
    }
  }

  return results;
}
