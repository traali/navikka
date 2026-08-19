import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Log.reset();
  });

  group('Ulkoasu & Theme Console Logging Verification', () {
    test(
      'setTheme logs [Ulkoasu/Teema] console message when switching themes',
      () async {
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
        );
        addTearDown(container.dispose);

        final notifier = container.read(appThemeControllerProvider.notifier);
        await notifier.setTheme(AppThemeMode.solarFlare);

        // Verify theme state updated
        expect(
          container.read(appThemeControllerProvider).value,
          AppThemeMode.solarFlare,
        );

        // Verify console log recorded
        final logs = Log.recentLogsNotifier.value;
        expect(
          logs.any(
            (line) => line.contains(
              '[Ulkoasu/Teema] User changed visual theme mode to: solarFlare',
            ),
          ),
          isTrue,
        );
      },
    );

    test(
      'setLayout logs [Ulkoasu] console message when switching layouts',
      () async {
        SharedPreferences.setMockInitialValues({});
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(uiLayoutControllerProvider.notifier);
        await notifier.setLayout(UiLayout.commandBar);

        // Verify layout state updated
        expect(container.read(uiLayoutControllerProvider), UiLayout.commandBar);

        // Verify console log recorded
        final logs = Log.recentLogsNotifier.value;
        expect(
          logs.any(
            (line) => line.contains(
              '[Ulkoasu] User changed UI layout style to: commandBar',
            ),
          ),
          isTrue,
        );
      },
    );
  });
}
