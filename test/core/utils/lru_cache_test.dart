import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/utils/lru_cache.dart';

void main() {
  test('reading an entry refreshes it before eviction', () {
    final cache = LruCache<String, int>(capacity: 2)
      ..['first'] = 1
      ..['second'] = 2;

    expect(cache['first'], 1);
    cache['third'] = 3;

    expect(cache['first'], 1);
    expect(cache['second'], isNull);
    expect(cache['third'], 3);
    expect(cache.length, 2);
  });
}
