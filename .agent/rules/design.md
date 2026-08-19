# UI/UX & Design Rules

## 1. Principles
- **Premium Aesthetics**: Rejection of default Material/Cupertino styles. Use custom glassmorphism, blur effects, and rich gradients.
- **Glassmorphism Standard**:
    - Backgrounds: High translucency with background blur.
    - Borders: Thin, semi-transparent white/white-alpha borders.
    - Shadows: Soft, diffused drop shadows for depth.
- **Micro-Animations**: Use flutter_animate for all entrances, exits, and state changes. Nothing simply "appears".

## 2. Touch & Layout
- **Touch Targets**: Minimum 48x48dp for all interactive elements (glove & marine friendly).
- **Haptics**: Feedback for every significant interaction (success, warning, error, toggle).
- **Safe Areas**: Strict adherence to device safe areas (notch, home indicator).

## 3. Typography & Color
- **Typography**: Complete removal of default font families. Use project-specific premium fonts (e.g., Google Fonts) with fluid typography scaling (`clamp()`).
- **Color Palette**: Defined in lib/core/theme (OLED "Night Captain" true-black surfaces). No hardcoded hex values in widgets.
