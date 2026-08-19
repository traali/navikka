import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/weather/presentation/providers/wave_layer_provider.dart';

void main() {
  group('WaveLayerNotifier Tests', () {
    test('Initial state of Wave Layer is false (OFF)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(waveLayerProvider);
      expect(state, isFalse);
    });

    test('toggle() switches wave layer state ON and OFF', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(waveLayerProvider.notifier);
      expect(container.read(waveLayerProvider), isFalse);

      notifier.toggle();
      expect(container.read(waveLayerProvider), isTrue);

      notifier.toggle();
      expect(container.read(waveLayerProvider), isFalse);
    });

    test('setVisible() explicitly updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(waveLayerProvider.notifier);

      notifier.setVisible(true);
      expect(container.read(waveLayerProvider), isTrue);

      notifier.setVisible(false);
      expect(container.read(waveLayerProvider), isFalse);
    });
  });
}
