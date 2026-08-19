---
description: Manage GitHub Pull Requests, CI, and deployments using CLI tools
---

# GitHub Operations Workflow

> **CRITICAL**: Use GitHub CLI (`gh`) for all GitHub operations. **DO NOT use browser automation.**

## Prerequisites

Verify GitHub CLI is installed and authenticated:
```bash
gh --version
gh auth status
```

## Common Operations

### 1. Check Pull Request Status

```bash
# View current branch PR status
gh pr status

# List all open PRs
gh pr list

# List all PRs (including merged)
gh pr list --state all
```

### 2. Review PR Details & CI Status

```bash
# View PR details with checks
gh pr view <number>

# Check only CI status
gh pr checks <number>

# View PR diff
gh pr diff <number>
```

### 3. Merge Pull Request

```bash
# Merge using squash (preferred for clean history)
gh pr merge <number> --squash --delete-branch

# Auto-merge when CI passes
gh pr merge <number> --auto --squash --delete-branch
```

### 4. Monitor CI/CD Workflows

```bash
# List recent workflow runs
gh run list --limit 10

# View specific run (with status)
gh run view <run-id>

# Watch a running workflow (live updates)
gh run watch

# View logs for failed steps
gh run view <run-id> --log-failed
```

### 5. Verify Deployment

```bash
# Check if latest merge deployed
gh run list --workflow=gh-pages.yml --limit 1
gh run list --workflow=deploy-cloudflare.yml --limit 1

# Get deployment URL
gh api repos/:owner/:repo/pages
```

### 6. Create Release

```bash
# Tag and create release
git tag v1.0.1
git push --tags

# Or create directly with CLI
gh release create v1.0.1 --generate-notes

# List releases
gh release list
```

### 7. Handle Dependabot PRs

```bash
# List Dependabot PRs
gh pr list --author app/dependabot

# Auto-merge safe dependency updates
gh pr merge <number> --auto --squash --delete-branch
```

## Troubleshooting

### Authentication Issues
```bash
# Check auth status
gh auth status

# Re-authenticate
gh auth login
```

### CI Failures
```bash
# View failed run logs
gh run list --status failure --limit 5
gh run view <run-id> --log-failed
```

## When NOT to Use Browser

❌ **Never use browser for:**
- Checking PR status
- Viewing CI results
- Merging PRs
- Creating releases
- Monitoring deployments

✅ **Only use browser for:**
- Testing the deployed web application UI
- Visual verification of app features
