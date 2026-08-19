import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wave_layer_provider.g.dart';

@riverpod
class WaveLayerNotifier extends _$WaveLayerNotifier {
  @override
  bool build() {
    return false; // OFF by default
  }

  void toggle() {
    state = !state;
  }

  void setVisible(bool visible) {
    if (state != visible) {
      state = visible;
    }
  }
}
