/// Small insertion-ordered cache used for immutable presentation assets.
class LruCache<K, V> {
  LruCache({required this.capacity})
    : assert(capacity > 0, 'capacity must be greater than zero');

  final int capacity;
  final Map<K, V> _values = {};

  V? operator [](K key) {
    final value = _values.remove(key);
    if (value != null) _values[key] = value;
    return value;
  }

  void operator []=(K key, V value) {
    _values.remove(key);
    _values[key] = value;
    while (_values.length > capacity) {
      _values.remove(_values.keys.first);
    }
  }

  int get length => _values.length;

  void clear() => _values.clear();
}
