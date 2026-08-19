import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/router/router.dart';

void main() {
  late ProviderContainer container;
  late GoRouter router;

  setUp(() {
    container = ProviderContainer();
    router = container.read(goRouterProvider);
  });

  tearDown(() {
    container.dispose();
  });

  group('GoRouter configuration', () {
    test('goRouterProvider returns a GoRouter', () {
      expect(router, isA<GoRouter>());
    });
  });
}
