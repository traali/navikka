import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_ais_store.g.dart';

class CachedVesselMetadata {
  final int mmsi;
  final String? name;
  final int? shipType;

  const CachedVesselMetadata({
    required this.mmsi,
    this.name,
    this.shipType,
  });
}

@Riverpod(keepAlive: true)
AisMetadataStore aisMetadataStore(Ref ref) {
  return AisMetadataStore();
}

class AisMetadataStore {
  final Map<int, CachedVesselMetadata> _cache = {};

  CachedVesselMetadata? getMetadata(int mmsi) => _cache[mmsi];

  void putMetadata(CachedVesselMetadata metadata) {
    _cache[metadata.mmsi] = metadata;
  }

  void putAll(Iterable<CachedVesselMetadata> list) {
    for (final item in list) {
      _cache[item.mmsi] = item;
    }
  }

  void clear() {
    _cache.clear();
  }
}
