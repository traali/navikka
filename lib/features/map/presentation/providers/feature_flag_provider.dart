import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flag_provider.g.dart';

/// Feature flag for experimental dynamic Wind & Wave visualization layers.
/// Default: false (off for zero impact on core navigation performance).
@riverpod
class WindWaveFeatureFlag extends _$WindWaveFeatureFlag {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }

  void setEnabled(bool value) {
    state = value;
  }
}
