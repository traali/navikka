import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/di/map_di.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';

part 'layer_filter_provider.g.dart';

/// All restriction types from the Finnish Maritime API
class RestrictionType {
  const RestrictionType({
    required this.code,
    required this.finnishName,
    required this.englishName,
  });
  final String code;
  final String finnishName;
  final String englishName;
}

/// List of all restriction types
const List<RestrictionType> allRestrictionTypes = [
  RestrictionType(
    code: 'Nopeusrajoitus',
    finnishName: 'Nopeusrajoitus',
    englishName: 'Speed Limit',
  ),
  RestrictionType(
    code: 'Aallokon aiheuttamisen kielto',
    finnishName: 'Aallokon aiheuttamisen kielto',
    englishName: 'No Wake Zone',
  ),
  RestrictionType(
    code: 'Purjelautailukielto',
    finnishName: 'Purjelautailukielto',
    englishName: 'Windsurfing Prohibited',
  ),
  RestrictionType(
    code: 'Vesiskootterilla ajo kielletty',
    finnishName: 'Vesiskootterilla ajo kielletty',
    englishName: 'Jet Ski Prohibited',
  ),
  RestrictionType(
    code: 'Aluksen kulku moottorivoimaa käyttäen kielletty',
    finnishName: 'Aluksen kulku moottorivoimaa käyttäen kielletty',
    englishName: 'Motor Prohibited',
  ),
  RestrictionType(
    code: 'Ankkurin käyttökielto',
    finnishName: 'Ankkurin käyttökielto',
    englishName: 'Anchoring Prohibited',
  ),
  RestrictionType(
    code: 'Pysäköimiskielto',
    finnishName: 'Pysäköimiskielto',
    englishName: 'Mooring Prohibited',
  ),
  RestrictionType(
    code: 'Kiinnittymiskielto',
    finnishName: 'Kiinnittymiskielto',
    englishName: 'Attachment Prohibited',
  ),
  RestrictionType(
    code: 'Ohittamiskielto',
    finnishName: 'Ohittamiskielto',
    englishName: 'Overtaking Prohibited',
  ),
  RestrictionType(
    code: 'Kohtaamiskielto',
    finnishName: 'Kohtaamiskielto',
    englishName: 'Meeting Prohibited',
  ),
  RestrictionType(
    code: 'Nopeussuositus',
    finnishName: 'Nopeussuositus',
    englishName: 'Speed Recommendation',
  ),
];

/// State for layer filtering
@JsonSerializable()
class LayerFilterState {
  const LayerFilterState({
    required this.visibleTypes,
    this.showNavigationAids = true,
    this.showBoatingLines = true,
    this.showSpeedLimits = true,
    this.showWeatherRadar = false,
    this.showAlgaeLayer = false,
    this.showAisLayer = true,
    this.showHarborsLayer = true,
    this.showMaritimeRestrictions = true,
    this.showOsmBasemap =
        false, // false = Traficom Nautical Chart (Default), true = OSM (Backup)
    this.showWindLayer = false,
    this.showWaveLayer = false,
  });

  factory LayerFilterState.fromJson(Map<String, dynamic> json) =>
      _$LayerFilterStateFromJson(json);

  /// Default: All types visible
  factory LayerFilterState.initial() {
    return LayerFilterState(
      visibleTypes: allRestrictionTypes.map((t) => t.code).toSet(),
    );
  }

  final Set<String> visibleTypes;
  final bool showNavigationAids;
  final bool showBoatingLines;
  final bool showSpeedLimits;
  final bool showWeatherRadar;
  final bool showAlgaeLayer;
  final bool showAisLayer;
  final bool showHarborsLayer;
  final bool showMaritimeRestrictions;
  final bool showOsmBasemap;
  final bool showWindLayer;
  final bool showWaveLayer;

  Map<String, dynamic> toJson() => _$LayerFilterStateToJson(this);

  LayerFilterState copyWith({
    Set<String>? visibleTypes,
    bool? showNavigationAids,
    bool? showBoatingLines,
    bool? showSpeedLimits,
    bool? showWeatherRadar,
    bool? showAlgaeLayer,
    bool? showAisLayer,
    bool? showHarborsLayer,
    bool? showMaritimeRestrictions,
    bool? showOsmBasemap,
    bool? showWindLayer,
    bool? showWaveLayer,
  }) {
    return LayerFilterState(
      visibleTypes: visibleTypes ?? this.visibleTypes,
      showNavigationAids: showNavigationAids ?? this.showNavigationAids,
      showBoatingLines: showBoatingLines ?? this.showBoatingLines,
      showSpeedLimits: showSpeedLimits ?? this.showSpeedLimits,
      showWeatherRadar: showWeatherRadar ?? this.showWeatherRadar,
      showAlgaeLayer: showAlgaeLayer ?? this.showAlgaeLayer,
      showAisLayer: showAisLayer ?? this.showAisLayer,
      showHarborsLayer: showHarborsLayer ?? this.showHarborsLayer,
      showMaritimeRestrictions:
          showMaritimeRestrictions ?? this.showMaritimeRestrictions,
      showOsmBasemap: showOsmBasemap ?? this.showOsmBasemap,
      showWindLayer: showWindLayer ?? this.showWindLayer,
      showWaveLayer: showWaveLayer ?? this.showWaveLayer,
    );
  }

  bool isVisible(String? typeCode) {
    if (!showMaritimeRestrictions) return false;
    if (typeCode == null) return true;
    return visibleTypes.contains(typeCode);
  }
}

/// Riverpod 3.x Notifier for layer filtering
@riverpod
class LayerFilter extends _$LayerFilter {
  late MapRepository _repository;

  @override
  FutureOr<LayerFilterState> build() async {
    _repository = ref.watch(mapRepositoryProvider);
    final result = await _repository.getLayerFilterSettings();

    return result.fold(
      (failure) => LayerFilterState.initial(),
      (json) => json != null
          ? LayerFilterState.fromJson(json)
          : LayerFilterState.initial(),
    );
  }

  Future<void> _saveSettings(LayerFilterState newState) async {
    await _repository.saveLayerFilterSettings(newState.toJson());
  }

  Future<void> toggleType(String typeCode) async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newSet = Set<String>.from(currentState.visibleTypes);
    if (newSet.contains(typeCode)) {
      newSet.remove(typeCode);
    } else {
      newSet.add(typeCode);
    }
    final newState = currentState.copyWith(visibleTypes: newSet);
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleNavigationAids() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showNavigationAids: !currentState.showNavigationAids,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleBoatingLines() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showBoatingLines: !currentState.showBoatingLines,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleSpeedLimits() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showSpeedLimits: !currentState.showSpeedLimits,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleWeatherRadar() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showWeatherRadar: !currentState.showWeatherRadar,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleAlgaeLayer() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showAlgaeLayer: !currentState.showAlgaeLayer,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleAisLayer() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showAisLayer: !currentState.showAisLayer,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleHarborsLayer() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showHarborsLayer: !currentState.showHarborsLayer,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleMaritimeRestrictions() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showMaritimeRestrictions: !currentState.showMaritimeRestrictions,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleOsmBasemap() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showOsmBasemap: !currentState.showOsmBasemap,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleWindLayer() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showWindLayer: !currentState.showWindLayer,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> toggleWaveLayer() async {
    final currentState = state.value ?? LayerFilterState.initial();
    final newState = currentState.copyWith(
      showWaveLayer: !currentState.showWaveLayer,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> showAll() async {
    final newState = LayerFilterState(
      visibleTypes: allRestrictionTypes.map((t) => t.code).toSet(),
      showWeatherRadar: true,
      showAlgaeLayer: true,
    );
    state = AsyncValue.data(newState);
    await _saveSettings(newState);
  }

  Future<void> hideAll() async {
    const newState = LayerFilterState(
      visibleTypes: {},
      showNavigationAids: false,
      showBoatingLines: false,
      showSpeedLimits: false,
      showMaritimeRestrictions: false,
    );
    state = const AsyncValue.data(newState);
    await _saveSettings(newState);
  }
}
