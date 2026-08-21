/// User preferences for individual UI/HUD element visibility on the map.
/// Each element can be toggled on/off independently by the skipper.
class UiElementPreferences {
  const UiElementPreferences({
    this.showSpeedHud = true,
    this.showWaveImpactHud = true,
    this.showCompassHud = true,
    this.showScaleBar = true,
    this.showToolDock = true,
    this.showZoomButtons = true,
    this.showVoiceButton = true,
    this.showTopCapsule = true,
  });

  /// Speedometer & speed limit sign (Bottom Left)
  final bool showSpeedHud;

  /// IMU accelerometer wave slamming & sea roughness AI badge (Bottom Left)
  final bool showWaveImpactHud;

  /// Marine precision compass & heading (Bottom Right)
  final bool showCompassHud;

  /// Map nautical scale bar (Bottom Left)
  final bool showScaleBar;

  /// Floating tool actions dock on the right side
  final bool showToolDock;

  /// Map zoom in (+) and zoom out (-) buttons
  final bool showZoomButtons;

  /// Voice copilot microphone button ("Hei Kippari")
  final bool showVoiceButton;

  /// Top search and unified capsule bar
  final bool showTopCapsule;

  UiElementPreferences copyWith({
    bool? showSpeedHud,
    bool? showWaveImpactHud,
    bool? showCompassHud,
    bool? showScaleBar,
    bool? showToolDock,
    bool? showZoomButtons,
    bool? showVoiceButton,
    bool? showTopCapsule,
  }) {
    return UiElementPreferences(
      showSpeedHud: showSpeedHud ?? this.showSpeedHud,
      showWaveImpactHud: showWaveImpactHud ?? this.showWaveImpactHud,
      showCompassHud: showCompassHud ?? this.showCompassHud,
      showScaleBar: showScaleBar ?? this.showScaleBar,
      showToolDock: showToolDock ?? this.showToolDock,
      showZoomButtons: showZoomButtons ?? this.showZoomButtons,
      showVoiceButton: showVoiceButton ?? this.showVoiceButton,
      showTopCapsule: showTopCapsule ?? this.showTopCapsule,
    );
  }
}
