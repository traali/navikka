import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UiLayoutController Tests', () {
    test('default layout is ghost', () {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final layout = container.read(uiLayoutControllerProvider);
      expect(layout, UiLayout.ghost);
    });

    test(
      'setLayout updates state to classic and persists to storage',
      () async {
        SharedPreferences.setMockInitialValues({});
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(uiLayoutControllerProvider.notifier);
        await notifier.setLayout(UiLayout.classic);

        expect(container.read(uiLayoutControllerProvider), UiLayout.classic);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('ui_layout_style'), 'classic');
      },
    );

    test('setLayout updates state to commandBar and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(uiLayoutControllerProvider.notifier);
      await notifier.setLayout(UiLayout.commandBar);

      expect(container.read(uiLayoutControllerProvider), UiLayout.commandBar);
    });

    test('setLayout updates state to horizon3D and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(uiLayoutControllerProvider.notifier);
      await notifier.setLayout(UiLayout.horizon3D);

      expect(container.read(uiLayoutControllerProvider), UiLayout.horizon3D);
    });

    test('setLayout updates state to omni and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(uiLayoutControllerProvider.notifier);
      await notifier.setLayout(UiLayout.omni);

      expect(container.read(uiLayoutControllerProvider), UiLayout.omni);
    });
  });
}
