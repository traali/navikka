/**
 * Chrome on iPhone is WebKit (CriOS), not Chromium.
 * Friday field test (2026-08-21): app loaded on iPhone 11 or 12 + Chrome.
 *
 * CSS pixels / device-pixel-ratio:
 *   iPhone 11  — 375×812 @2x, LCD, notch, home indicator
 *   iPhone 12  — 390×844 @3x, OLED, notch, home indicator
 */
export const IPHONE_11 = {
  id: "iphone-11",
  cssWidth: 375,
  cssHeight: 812,
  dpr: 2,
  safeTop: 44,
  safeBottom: 34,
} as const;

export const IPHONE_12 = {
  id: "iphone-12",
  cssWidth: 390,
  cssHeight: 844,
  dpr: 3,
  safeTop: 47,
  safeBottom: 34,
} as const;

export const CHROME_IOS_UA =
  "Mozilla/5.0 (iPhone; CPU iPhone OS 17_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/128.0.6613.98 Mobile/15E148 Safari/604.1";

export const SAFARI_IOS_UA =
  "Mozilla/5.0 (iPhone; CPU iPhone OS 17_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Mobile/15E148 Safari/604.1";

export function isIosWebKit(ua: string) {
  return /iPhone|iPad|iPod/i.test(ua) && /WebKit/i.test(ua) && !/Windows Phone/i.test(ua);
}

export function isChromeOniOS(ua: string) {
  return isIosWebKit(ua) && /CriOS/i.test(ua);
}

export function classifyIphoneViewport(width: number, height: number, dpr: number) {
  if (width === IPHONE_11.cssWidth && height === IPHONE_11.cssHeight && dpr === IPHONE_11.dpr) {
    return "iphone-11";
  }
  if (width === IPHONE_12.cssWidth && height === IPHONE_12.cssHeight && dpr === IPHONE_12.dpr) {
    return "iphone-12";
  }
  if (width === 390 && height === 844) return "iphone-12-class";
  if (width === 375 && height === 812) return "iphone-11-class";
  return "other";
}

/** Min CSS font-size that prevents iOS Safari/Chrome from zooming on focus. */
export const IOS_NO_ZOOM_INPUT_PX = 16;

/** Apple HIG minimum touch target. */
export const MIN_TOUCH_PX = 44;
