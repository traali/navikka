---
description: Fetch and update local data assets from Väylävirasto
---

# Workflow: Data Sync Protocol

## Description
Routine to fetch fresh data from Väylävirasto and bundle it into `assets/`.

---

## 1. Environment Check
**Command:**
```bash
pip install -r scripts/requirements.txt
```
Ensure Python dependencies are installed.

---

## 2. Fetch Vector Data
**Script**: `scripts/fetch_speed_limits.py`
**Input**: Väylävirasto WFS API.
**Output**: `assets/data/speed_limits.geojson`

**Command:**
// turbo
```bash
python scripts/fetch_speed_limits.py
```

---

## 3. Verification
**Script**: `scripts/check_bundled_assets.py`

**Command:**
// turbo
```bash
python scripts/check_bundled_assets.py
```

**Checks:**
- Verify file exists.
- Verify file size > 0 bytes.
- Verify valid GeoJSON structure.

---

## 4. Flutter Asset Check
Ensure `assets/data/` is listed in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/data/
```

If not present, add it. Then run:
// turbo
```bash
flutter pub get
```

---

## 5. Final Report
Report to user:

| Step | Result |
| :--- | :--- |
| Environment | [Ready/Missing deps] |
| Fetch | [Success/Failed] |
| Verification | [Pass/Fail] |
| Flutter Assets | [Configured/Missing] |
