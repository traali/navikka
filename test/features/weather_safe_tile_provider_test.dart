import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/weather/presentation/widgets/safe_tile_provider.dart';

void main() {
  test('uses the injected shared Dio client', () {
    final sharedDio = Dio();
    final provider = SafeTileProvider(dio: sharedDio);

    expect(provider.dio, same(sharedDio));
  });
}
