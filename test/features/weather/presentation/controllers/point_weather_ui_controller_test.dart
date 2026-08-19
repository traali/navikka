import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_ui_controller.dart';

void main() {
  test('animation refreshes radar timestamps on each frame', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(
      pointWeatherUiControllerProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    final controller = container.read(
      pointWeatherUiControllerProvider.notifier,
    );
    final initial = container.read(pointWeatherUiControllerProvider);

    controller.toggleAnimation();
    await Future<void>.delayed(const Duration(milliseconds: 1700));

    final updated = container.read(pointWeatherUiControllerProvider);
    expect(updated.radarTimestamps, hasLength(12));
    expect(updated.currentTimestampIndex, isNot(initial.currentTimestampIndex));
    expect(updated.radarTimestamps, isNot(same(initial.radarTimestamps)));
  });
}
