import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/utils/throttle.dart';

void main() {
  test('coalesces calls and runs only the latest action', () {
    fakeAsync((async) {
      final throttle = Throttle(const Duration(milliseconds: 100));
      addTearDown(throttle.dispose);
      final calls = <int>[];

      throttle.call(() => calls.add(1));
      throttle.call(() => calls.add(2));

      expect(calls, isEmpty);
      async.elapse(const Duration(milliseconds: 99));
      expect(calls, isEmpty);

      async.elapse(const Duration(milliseconds: 1));
      expect(calls, [2]);
    });
  });
}
