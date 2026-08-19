# Release & Merge Policies

## 1. Changelog Requirements
All merges to main **MUST** update CHANGELOG.md:
- Follow [Keep a Changelog](https://keepachangelog.com/) format
- Use [Semantic Versioning](https://semver.org/) for version numbers
- Categories: Added, Changed, Fixed, Removed, Performance, Security

## 2. Pre-Merge Checklist
Before merging any branch to main:
1. ✅ All tests pass (flutter test)
2. ✅ Zero analyze issues (flutter analyze)
3. ✅ Code generation up-to-date (build_runner build)
4. ✅ CHANGELOG.md updated
5. ✅ Backup branch created (backup/main-pre-merge-YYYY-MM-DD)

## 3. Commit Message Convention
`
<type>: <short description>

<optional body>

Closes #<issue-number>
`

| Type | Use Case |
|:---|:---|
| feat | New feature |
| fix | Bug fix |
| perf | Performance improvement |
| refactor | Code restructuring |
| docs | Documentation changes |
| test | Test additions/fixes |
| chore | Maintenance tasks |

## 4. Branch Naming
| Branch Type | Pattern | Example |
|:---|:---|:---|
| Feature | feature/<name> | feature/weather-radar |
| Bug Fix | fix/<issue> | fix/api-timeout |
| Performance | performance/<area> | performance/api-optimization |
| Maintenance | maintenance/<task> | maintenance/flutter-upgrade |
| Backup | backup/main-pre-merge-<date> | backup/main-pre-merge-2026-01-03 |

## 5. Merge Workflow
Use the /merge-to-main workflow command or follow .agent/workflows/merge-to-main.md.

## 6. External API Integration
- **Verification First**: Save real call responses in test/fixtures/api_responses/.
- **Offline-First**: Never crash on API failure; fall back to local data.
- **Documentation**: Log endpoints in docs/external_apis.md.
