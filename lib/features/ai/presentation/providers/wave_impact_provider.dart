import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/features/ai/domain/services/wave_impact_ai_service.dart';

final waveImpactAiServiceProvider = Provider<WaveImpactAiService>((ref) {
  final service = WaveImpactAiService();
  service.start();
  ref.onDispose(service.dispose);
  return service;
});

final waveImpactStateProvider = StreamProvider<WaveImpactState>((ref) {
  final service = ref.watch(waveImpactAiServiceProvider);
  return service.onImpactState;
});
