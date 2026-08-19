// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_config_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapConfigService)
final mapConfigServiceProvider = MapConfigServiceProvider._();

final class MapConfigServiceProvider
    extends $NotifierProvider<MapConfigService, void> {
  MapConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapConfigServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapConfigServiceHash();

  @$internal
  @override
  MapConfigService create() => MapConfigService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$mapConfigServiceHash() => r'86b8d36d89782fc881aeb2557d3752d8004f0a9d';

abstract class _$MapConfigService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
