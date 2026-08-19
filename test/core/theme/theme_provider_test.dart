import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('AppThemeController Tests', () {
    late MockSharedPreferences mockPrefs;

    setUp(() {
      mockPrefs = MockSharedPreferences();
    });

    test(
      'should default to nightCaptain when SharedPreferences is empty',
      () async {
        when(
          () => mockPrefs.getString('sakkoja_app_theme_mode'),
        ).thenReturn(null);

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(mockPrefs),
          ],
        );
        addTearDown(container.dispose);

        final themeState = await container.read(
          appThemeControllerProvider.future,
        );
        expect(themeState, equals(AppThemeMode.nightCaptain));
      },
    );

    test('should resolve theme stored in SharedPreferences', () async {
      when(
        () => mockPrefs.getString('sakkoja_app_theme_mode'),
      ).thenReturn(AppThemeMode.solarFlare.name);

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockPrefs),
        ],
      );
      addTearDown(container.dispose);

      final themeState = await container.read(
        appThemeControllerProvider.future,
      );
      expect(themeState, equals(AppThemeMode.solarFlare));
    });

    test(
      'setTheme should update state and save to SharedPreferences',
      () async {
        when(
          () => mockPrefs.getString('sakkoja_app_theme_mode'),
        ).thenReturn(null);
        when(
          () => mockPrefs.setString(
            'sakkoja_app_theme_mode',
            AppThemeMode.deepSea.name,
          ),
        ).thenAnswer((_) async => true);

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(mockPrefs),
          ],
        );
        addTearDown(container.dispose);

        // Wait for initial load
        await container.read(appThemeControllerProvider.future);

        final controller = container.read(appThemeControllerProvider.notifier);
        await controller.setTheme(AppThemeMode.deepSea);

        final themeState = container.read(appThemeControllerProvider).value;
        expect(themeState, equals(AppThemeMode.deepSea));

        verify(
          () => mockPrefs.setString(
            'sakkoja_app_theme_mode',
            AppThemeMode.deepSea.name,
          ),
        ).called(1);
      },
    );
  });

  group('AppThemeColors Tests', () {
    test('lerp should interpolate colors correctly', () {
      const colorsA = AppThemeColors(
        canvas: Color(0xFF000000),
        surface: Color(0xFF0F172A),
        surfaceHighlight: Color(0xFF1E293B),
        primaryAction: Color(0xFF22D3EE),
        textPrimary: Color(0xFFF1F5F9),
        textSecondary: Color(0xFF94A3B8),
        border: Color(0x1EFFFFFF),
        danger: Color(0xFFEF4444),
        success: Color(0xFF10B981),
        warning: Color(0xFFFBBF24),
        glassBorder: Color(0x1EFFFFFF),
        glassBackground: Color(0xE60F172A),
        ialaRed: Color(0xFFE63946),
        ialaGreen: Color(0xFF2A9D8F),
        ialaYellow: Color(0xFFFFD700),
        routeSpeedLow: Color(0xFFDC2626),
        routeSpeedMedium: Color(0xFFF59E0B),
        routeSpeedHigh: Color(0xFF22C55E),
        cardBackground: Color(0xFF0F172A),
        cardBorder: Color(0x1EFFFFFF),
      );

      const colorsB = AppThemeColors(
        canvas: Color(0xFFFFFFFF),
        surface: Color(0xFFF8FAFC),
        surfaceHighlight: Color(0xFFF1F5F9),
        primaryAction: Color(0xFF0284C7),
        textPrimary: Color(0xFF0F172A),
        textSecondary: Color(0xFF475569),
        border: Color(0xFFE2E8F0),
        danger: Color(0xFFDC2626),
        success: Color(0xFF16A34A),
        warning: Color(0xFFD97706),
        glassBorder: Color(0xFFCBD5E1),
        glassBackground: Color(0xF2FFFFFF),
        ialaRed: Color(0xFFDC2626),
        ialaGreen: Color(0xFF059669),
        ialaYellow: Color(0xFFD97706),
        routeSpeedLow: Color(0xFFB91C1C),
        routeSpeedMedium: Color(0xFFD97706),
        routeSpeedHigh: Color(0xFF15803D),
        cardBackground: Color(0xFFF8FAFC),
        cardBorder: Color(0xFFE2E8F0),
      );

      final lerped = colorsA.lerp(colorsB, 0.5);

      expect(
        lerped.canvas,
        equals(Color.lerp(colorsA.canvas, colorsB.canvas, 0.5)),
      );
      expect(
        lerped.primaryAction,
        equals(Color.lerp(colorsA.primaryAction, colorsB.primaryAction, 0.5)),
      );
      expect(
        lerped.ialaRed,
        equals(Color.lerp(colorsA.ialaRed, colorsB.ialaRed, 0.5)),
      );
    });
  });
}
