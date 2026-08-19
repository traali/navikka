# Tool Selection Archive

This directory contains technical comparisons between alternative tools and libraries, as mandated by the project's **Global Antigravity Rules**.

## Rule: 3-Way Comparison
Before introducing any new dependency or tool, we perform a comparison of at least three modern alternatives. We prioritize "all-in-one" tools that offer high performance and consolidation.

## Archive
| Date | Item | Alternatives | Selected | Reasoning |
| :--- | :--- | :--- | :--- | :--- |
| 2026-02-02 | Static Analysis | flutter_lints, lints, very_good_analysis | **very_good_analysis** | Comprehensive (~150 rules), industry standard, strict. |
| 2026-02-02 | Networking Mocking | mockito, mocktail, Record & Replay | **Record & Replay** | Deterministic, offline-resilient, handles raw bytes. |

---

> [!TIP]
> Add new comparisons here using the standard template in `.agent/templates/TOOL_COMPARISON_TEMPLATE.md`.
