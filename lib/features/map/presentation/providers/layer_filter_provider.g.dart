// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layer_filter_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayerFilterState _$LayerFilterStateFromJson(Map<String, dynamic> json) =>
    LayerFilterState(
      visibleTypes: (json['visibleTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
      showNavigationAids: json['showNavigationAids'] as bool? ?? true,
      showBoatingLines: json['showBoatingLines'] as bool? ?? true,
      showSpeedLimits: json['showSpeedLimits'] as bool? ?? true,
      showWeatherRadar: json['showWeatherRadar'] as bool? ?? false,
      showAlgaeLayer: json['showAlgaeLayer'] as bool? ?? false,
      showAisLayer: json['showAisLayer'] as bool? ?? true,
      showHarborsLayer: json['showHarborsLayer'] as bool? ?? true,
      showMaritimeRestrictions:
          json['showMaritimeRestrictions'] as bool? ?? true,
      showOsmBasemap: json['showOsmBasemap'] as bool? ?? false,
      showWindLayer: json['showWindLayer'] as bool? ?? false,
      showWaveLayer: json['showWaveLayer'] as bool? ?? false,
    );

Map<String, dynamic> _$LayerFilterStateToJson(LayerFilterState instance) =>
    <String, dynamic>{
      'visibleTypes': instance.visibleTypes.toList(),
      'showNavigationAids': instance.showNavigationAids,
      'showBoatingLines': instance.showBoatingLines,
      'showSpeedLimits': instance.showSpeedLimits,
      'showWeatherRadar': instance.showWeatherRadar,
      'showAlgaeLayer': instance.showAlgaeLayer,
      'showAisLayer': instance.showAisLayer,
      'showHarborsLayer': instance.showHarborsLayer,
      'showMaritimeRestrictions': instance.showMaritimeRestrictions,
      'showOsmBasemap': instance.showOsmBasemap,
      'showWindLayer': instance.showWindLayer,
      'showWaveLayer': instance.showWaveLayer,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod 3.x Notifier for layer filtering

@ProviderFor(LayerFilter)
final layerFilterProvider = LayerFilterProvider._();

/// Riverpod 3.x Notifier for layer filtering
final class LayerFilterProvider
    extends $AsyncNotifierProvider<LayerFilter, LayerFilterState> {
  /// Riverpod 3.x Notifier for layer filtering
  LayerFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'layerFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$layerFilterHash();

  @$internal
  @override
  LayerFilter create() => LayerFilter();
}

String _$layerFilterHash() => r'da855b294bf6952edf465db405a46dc2babcb85b';

/// Riverpod 3.x Notifier for layer filtering

abstract class _$LayerFilter extends $AsyncNotifier<LayerFilterState> {
  FutureOr<LayerFilterState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LayerFilterState>, LayerFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LayerFilterState>, LayerFilterState>,
              AsyncValue<LayerFilterState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
