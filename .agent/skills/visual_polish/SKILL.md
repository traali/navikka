---
name: Visual Polish
description: Design system enforcement for the "Night Captain" (OLED) aesthetic. Use this skill when creating or modifying UI components.
---

# Visual Polish

This skill defines the "Night Captain" design language for Sakkoja. It demands a high-contrast, OLED-optimized aesthetic suitable for maritime use at night.

## 1. Design System Core

### 1.1 The "Night Captain" Aesthetic
-   **Philosophy:** Deep blacks, crisp technical typography, and vibrant neon accents. No blurry shadows; use borders and glows.
-   **Canvas:** `AppPalette.canvas` (Pure Black or near black) is the foundation.
-   **Surface:** `AppPalette.surface` (Dark Grey) for cards/sheets.
-   **Glass:** Do NOT use blur for the sake of blur. Use "Hard Glass" – semitransparent backgrounds with sharp 1px borders.

### 1.2 strict Rules
1.  **NO Random Colors:** Never use `Colors.red` or `Colors.blue`.
    -   Use `AppPalette.danger` (for errors/warnings).
    -   Use `AppPalette.primaryAction` (for buttons/interactions).
    -   Use `AppPalette.textPrimary` (for main text).
2.  **Typography:** Always use `AppTheme.kHeading`, `AppTheme.kBody`, etc. containing `GoogleFonts.inter`.
3.  **Borders:** Use `AppTheme.kBorderColor` with `width: 1.0`.

## 2. Component Presets

### 2.1 Buttons & Actions
-   **Primary Button:**
    -   Background: `AppPalette.primaryAction` (Cyan/Teal).
    -   Text: Black (High contrast).
    -   Shape: `RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))`.
-   **Icon Button:**
    -   Avoid solid backgrounds unless active. Use `AppPalette.textPrimary` for the icon.

### 2.2 Cards & Sheets
-   **Container:** `AppPalette.surface`.
-   **Border:** `Border.all(color: AppTheme.kBorderColor)`.
-   **Radius:** `AppTheme.kBorderRadius` (16px).

### 2.3 Maps
-   **Overlays:** Must be semi-transparent black (`Colors.black54`) with white text to ensure readability over map tiles.

## 3. Implementation Checklist

When creating a new widget:
-   [ ] Does it use `AppTheme` text styles?
-   [ ] Are all colors mapped to `AppPalette`?
-   [ ] Is the background OLED-friendly (dark/black)?
-   [ ] are border radii consistent (16px)?

## 4. Resource Locations

-   **Theme Def:** `lib/core/theme/app_theme.dart`
-   **Palette:** `lib/core/theme/app_palette.dart`
