---
description: Verify changes by running code generation and tests
---

# Workflow: Verify Changes (Safety First)

## Description
Standard protocol to verify code integrity. **CRITICAL:** Agents cannot verify pixels.

---

## 1. The Build Phase
**Command:**
// turbo
```bash
dart run build_runner build --delete-conflicting-outputs
```
**Action**: Run strict. If this fails, code is syntactically broken. STOP and fix.

---

## 2. The Analysis Phase
**Command:**
// turbo
```bash
flutter analyze
```
**Goal**: Clean report. Fix "Errors" immediately. Warnings may be addressed later.

---

## 3. The Test Phase (Logic Only)
**Command:**
// turbo
```bash
flutter test --exclude-tags=golden
```
**Goal**: Verify business logic (Repositories, UseCases, Services).
**Action**: If these fail, the logic is wrong. Fix the code.

---

## 4. The Visual Phase (Human Gate)
**Command:**
```bash
flutter test --tags=golden
```
**Context**: Compares pixel-perfect screenshots against stored golden files.

| Result | Action |
| :--- | :--- |
| **SUCCESS** | Proceed to Final Report. |
| **FAILURE** | **STOP.** Do NOT fix code yet. |

> [!CAUTION]
> **DANGER**: Do **NOT** run `--update-goldens` automatically.
> **Report**: "Visual mismatch detected. User intervention required."

Only the USER can approve visual changes and run:
```bash
flutter test --update-goldens
```

---

## 5. Final Report
Report to user in this format:

```
| Phase | Result |
| :--- | :--- |
| Build | [Pass/Fail] |
| Analysis | [Pass/Fail] |
| Logic Tests | [Pass/Fail] |
| Visual Tests | [Pass/Fail/Blocked] |
```

If Visual Tests are "Blocked", explain which golden files differ and await user approval.
