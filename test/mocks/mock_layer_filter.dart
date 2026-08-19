import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';

class MockLayerFilter extends LayerFilter {
  @override
  Future<LayerFilterState> build() async {
    return LayerFilterState.initial();
  }
}
