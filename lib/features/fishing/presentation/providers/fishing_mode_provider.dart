import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart';

part 'fishing_mode_provider.g.dart';

// FishingRepository provider is now in fishing_di.dart
// Re-export for backward compatibility

class FishingModeState {
  const FishingModeState({
    required this.isEnabled,
    this.selectedCategory,
    this.onlyActive = true, // Default to true but can be toggled
    this.showAllCategories = false,
    this.showInactive = false,
  });

  final bool isEnabled;
  final String? selectedCategory;
  final bool onlyActive;
  final bool showAllCategories;
  final bool showInactive;

  FishingModeState copyWith({
    bool? isEnabled,
    String? selectedCategory,
    bool? onlyActive,
    bool? showAllCategories,
    bool? showInactive,
  }) {
    return FishingModeState(
      isEnabled: isEnabled ?? this.isEnabled,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      onlyActive: onlyActive ?? this.onlyActive,
      showAllCategories: showAllCategories ?? this.showAllCategories,
      showInactive: showInactive ?? this.showInactive,
    );
  }

  /// Helper to allow explicit nulling of selectedCategory
  FishingModeState withCategory(String? category) {
    return FishingModeState(
      isEnabled: isEnabled,
      selectedCategory: category,
      onlyActive: onlyActive,
      showAllCategories: showAllCategories,
      showInactive: showInactive,
    );
  }
}

@riverpod
class FishingModeController extends _$FishingModeController {
  @override
  FutureOr<FishingModeState> build() async {
    final repository = ref.read(fishingRepositoryProvider);
    final isEnabled = await repository.getFishingMode();
    return FishingModeState(isEnabled: isEnabled);
  }

  Future<void> toggle() async {
    final repository = ref.read(fishingRepositoryProvider);
    final currentState =
        state.value ?? const FishingModeState(isEnabled: false);
    final newState = currentState.copyWith(isEnabled: !currentState.isEnabled);

    state = AsyncValue.data(newState);

    try {
      await repository.saveFishingMode(newState.isEnabled);
    } catch (e, s) {
      state = AsyncValue.data(currentState);
      Log.e('Failed to save fishing mode', e, s);
    }
  }

  void setCategory(String? category) {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncValue.data(currentState.withCategory(category));
  }

  void setOnlyActive(bool onlyActive) {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncValue.data(currentState.copyWith(onlyActive: onlyActive));
  }

  void toggleShowAllCategories() {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncValue.data(
      currentState.copyWith(showAllCategories: !currentState.showAllCategories),
    );
  }

  void toggleShowInactive() {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncValue.data(
      currentState.copyWith(showInactive: !currentState.showInactive),
    );
  }
}
