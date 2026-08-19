import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UX-NAV-002 offline regions is a declarative deep-linkable route', () {
    final router = File('lib/core/router/router.dart').readAsStringSync();
    final menu = File(
      'lib/features/menu/presentation/screens/menu_screen.dart',
    ).readAsStringSync();
    expect(router, contains("path: '/offline-regions'"));
    expect(menu, contains("context.push('/offline-regions')"));
    expect(menu, isNot(contains('MaterialPageRoute<void>')));
  });

  test('UX-NAV-003 menu has one responsive navigation meaning', () {
    final source = File(
      'lib/core/presentation/widgets/adaptive_nav_shell.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('openEndDrawer')));
    expect(source, contains('_onDestinationSelected(context, index)'));
  });

  test('UX-NAV-004 insight history is a declarative deep-linkable route', () {
    final router = File('lib/core/router/router.dart').readAsStringSync();
    final sheet = File(
      'lib/features/ai/presentation/widgets/insight_detail_sheet.dart',
    ).readAsStringSync();
    expect(router, contains("path: '/insight-history'"));
    expect(sheet, contains("context.push('/insight-history')"));
    expect(sheet, isNot(contains('MaterialPageRoute<void>')));
  });

  test('UX-NAV-005 every full screen has a production route entry point', () {
    final router = File('lib/core/router/router.dart').readAsStringSync();
    expect(router, contains("path: '/routes'"));
    expect(router, contains("path: '/vessel-settings'"));
  });
}
