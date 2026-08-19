---
description: MCP Verify-Loop workflow for self-correcting code changes
---

# MCP Verify-Loop Protocol

When modifying Dart/Flutter code, follow this self-correction workflow to ensure changes compile and pass tests before reporting results.

## Core Principle
The AI must **verify its own work** using MCP tools before presenting results to the user. This prevents broken code from being delivered.

## The Verify-Loop

### Step 1: APPLY
Make the code change to the file(s).

### Step 2: ANALYZE
// turbo
Run analysis immediately after saving:
```
Use: mcp_dart-mcp-server_analyze_files
Target: The modified file path(s)
```

### Step 3: READ
Parse the analysis output for errors and warnings.

### Step 4: FIX
If errors exist:
- **Automatic fixes**: Use `mcp_dart-mcp-server_dart_fix` for common issues
- **Manual fixes**: Edit files to resolve remaining errors
- **Re-analyze**: Return to Step 2

### Step 5: REPORT
Only after analysis passes, report results to the user.

---

## Phase-Specific Usage

### 🔐 Security & Architecture Refactors
**Use case**: Moving DI providers, extracting classes, refactoring imports.

```
Workflow:
1. Move/create the file
2. Run: mcp_dart-mcp-server_analyze_files on affected directories
3. Fix broken imports automatically
4. Re-analyze until clean
```

**Why**: Prevents circular dependency issues that surface after file moves.

---

### 🏗️ DI Migration (GetIt → Riverpod)
**Use case**: Replacing annotations, updating provider definitions.

```
Workflow:
1. Replace @lazySingleton with @Riverpod(keepAlive: true)
2. Run: mcp_dart-mcp-server_dart_fix on the feature folder
3. This auto-removes stale injectable imports
4. Analyze to verify
```

**Why**: `dart fix --apply` handles import cleanup the AI might forget.

---

### 🚀 Performance Optimization (SQL/Drift)
**Use case**: Optimizing queries, changing data access patterns.

```
Workflow:
1. Run existing tests first: mcp_dart-mcp-server_run_tests
2. Make the optimization
3. Re-run tests immediately
4. Only report if tests pass
```

**Why**: SQL changes can silently break logic; tests catch this.

---

### 🧹 Dependency Upgrades
**Use case**: Upgrading packages, resolving version conflicts.

```
Workflow:
1. Check: mcp_dart-mcp-server_pub with command "outdated"
2. Add/upgrade: mcp_dart-mcp-server_pub with command "add"
3. Analyze for breaking changes
4. Run tests to verify compatibility
```

**Why**: Prevents version conflicts from crashing the build.

---

## Quick Reference

| Action | MCP Tool |
|--------|----------|
| Check compilation | `mcp_dart-mcp-server_analyze_files` |
| Auto-fix issues | `mcp_dart-mcp-server_dart_fix` |
| Add packages | `mcp_dart-mcp-server_pub` (command: "add") |
| Check outdated | `mcp_dart-mcp-server_pub` (command: "outdated") |
| Run tests | `mcp_dart-mcp-server_run_tests` |
| Format code | `mcp_dart-mcp-server_dart_format` |

---

## Anti-Patterns to Avoid

❌ **Don't** show code to user before analyzing  
❌ **Don't** skip tests after SQL/query changes  
❌ **Don't** manually delete imports when `dart fix` can do it  
❌ **Don't** guess at version compatibility; use `pub outdated`
