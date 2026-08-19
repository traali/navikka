#!/bin/bash
set -e

# Hourly Review Agent — checks main for regressions every hour for 8 hours
# Usage: bash scripts/hourly_review.sh

REPO_DIR="/tmp/sakkoja-review"
REPO_URL="https://github.com/traali/sakkoja.git"
ITERATIONS=8
SLEEP_SECONDS=3600
LAST_SHA_FILE="/tmp/sakkoja_review_last_sha"
ISSUES_CREATED=0
START_TIME=$(date +%s)

echo "=== Sakkoja Hourly Review Agent ==="
echo "Started: $(date)"
echo "Repo: $REPO_URL"
echo "Iterations: $ITERATIONS"
echo ""

# Clone fresh if not exists
if [ ! -d "$REPO_DIR" ]; then
  echo "Cloning $REPO_URL into $REPO_DIR..."
  git clone --depth=1 "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"

# Ensure flutter is available
if ! command -v flutter &> /dev/null; then
  # Try common Flutter installation paths
  export PATH="$PATH:$HOME/flutter/bin:$HOME/fvm/default/bin"
fi

for i in $(seq 1 $ITERATIONS); do
  echo ""
  echo "=== Iteration $i/$ITERATIONS at $(date) ==="
  
  # Record SHA before fetch
  BEFORE_SHA=$(git rev-parse HEAD)
  
  # Fetch latest
  git fetch origin main 2>&1 || echo "Fetch failed (network?), continuing with current state"
  
  # Check for new commits
  NEW_COMMITS=$(git log --oneline HEAD..origin/main 2>/dev/null | wc -l | tr -d ' ')
  
  if [ "$NEW_COMMITS" -eq "0" ] && [ "$i" -gt "1" ]; then
    echo "No new commits. Skipping review."
    echo "Sleeping ${SLEEP_SECONDS}s..."
    sleep $SLEEP_SECONDS
    continue
  fi
  
  echo "Found $NEW_COMMITS new commit(s). Reviewing..."
  
  # Show new commits
  git log --oneline HEAD..origin/main
  echo ""
  
  # Reset to latest main
  git reset --hard origin/main 2>/dev/null || git merge origin/main 2>/dev/null || true
  
  CURRENT_SHA=$(git rev-parse HEAD)
  
  # Run flutter pub get
  flutter pub get 2>&1 | tail -1
  
  # ===== ANALYSIS =====
  ISSUE_BODY=""
  HAS_ISSUES=false
  
  # 1. flutter analyze
  echo "Running flutter analyze..."
  ANALYZE_OUTPUT=$(flutter analyze 2>&1 || true)
  ERROR_COUNT=$(echo "$ANALYZE_OUTPUT" | grep -c "error •" || true)
  WARNING_COUNT=$(echo "$ANALYZE_OUTPUT" | grep -c "warning •" || true)
  
  if [ "$ERROR_COUNT" -gt "0" ] || [ "$WARNING_COUNT" -gt "0" ]; then
    HAS_ISSUES=true
    ISSUE_BODY+="## Regression: Analyze found $ERROR_COUNT errors, $WARNING_COUNT warnings\n\n"
    ISSUE_BODY+='```\n'
    ISSUE_BODY+=$(echo "$ANALYZE_OUTPUT" | grep -E "error •|warning •" | head -20)
    ISSUE_BODY+='\n```\n\n'
  fi
  
  # 2. DateTime.now() in build methods (antipattern)
  echo "Scanning for DateTime.now() in build methods..."
  DT_RESULTS=$(grep -rn "DateTime.now()" lib/ --include="*.dart" | grep -v "test/" | grep -v ".g.dart" | grep -v ".freezed" || true)
  if [ -n "$DT_RESULTS" ]; then
    HAS_ISSUES=true
    ISSUE_BODY+="## Antipattern: DateTime.now() found in potential build paths\n\n"
    ISSUE_BODY+='```\n'
    ISSUE_BODY+="$DT_RESULTS"
    ISSUE_BODY+='\n```\n\n'
  fi
  
  # 3. Hardcoded colors (bypassing AppPalette)
  echo "Scanning for hardcoded Colors..."
  COLOR_RESULTS=$(grep -rn "Colors\.\(cyanAccent\|redAccent\|amberAccent\|amber\|orangeAccent\|white\|grey\|tealAccent\|blueAccent\)" lib/ --include="*.dart" | grep -v "test/" | grep -v ".g.dart" | grep -v ".freezed" | grep -v "app_palette.dart" || true)
  if [ -n "$COLOR_RESULTS" ]; then
    HAS_ISSUES=true
    ISSUE_BODY+="## Antipattern: Hardcoded Colors.xxx detected\n\n"
    ISSUE_BODY+='```\n'
    ISSUE_BODY+="$COLOR_RESULTS"
    ISSUE_BODY+='\n```\n\n'
  fi
  
  # 4. response.data! without null check
  echo "Scanning for response.data!..."
  RD_RESULTS=$(grep -rn "response\.data!" lib/ --include="*.dart" | grep -v "test/" | grep -v ".g.dart" | grep -v ".freezed" || true)
  if [ -n "$RD_RESULTS" ]; then
    # Check if each is guarded by null check
    UNGUARDED=""
    while IFS= read -r line; do
      file=$(echo "$line" | cut -d: -f1)
      linenum=$(echo "$line" | cut -d: -f2)
      # Check if there's a null check within 5 lines before
      if ! sed -n "$((linenum-5)),$linenum p" "$file" 2>/dev/null | grep -q "data.*!= null\|if.*data.*null"; then
        UNGUARDED+="$line"$'\n'
      fi
    done <<< "$RD_RESULTS"
    if [ -n "$UNGUARDED" ]; then
      HAS_ISSUES=true
      ISSUE_BODY+="## Regression: Unguarded response.data! found\n\n"
      ISSUE_BODY+='```\n'
      ISSUE_BODY+="$UNGUARDED"
      ISSUE_BODY+='\n```\n\n'
    fi
  fi
  
  # 5. Missing MapController.dispose()
  echo "Scanning for MapController leaks..."
  MC_RESULTS=$(grep -rn "MapController()" lib/ --include="*.dart" | grep -v "test/" | grep -v ".g.dart" || true)
  while IFS= read -r line; do
    file=$(echo "$line" | cut -d: -f1)
    if [ -f "$file" ]; then
      if ! grep -q "MapController.*dispose\|dispose.*MapController" "$file"; then
        ISSUE_BODY+="## Regression: MapController created but never disposed in $file\n\n"
        HAS_ISSUES=true
      fi
    fi
  done <<< "$MC_RESULTS"
  
  # 6. New DTO domain imports (regression on #223)
  echo "Scanning for DTO domain imports..."
  DTO_IMPORTS=$(grep -rn "import.*domain/entities" lib/features/*/data/models/*.dart 2>/dev/null | grep -v '.freezed.dart' | grep -v '.g.dart' | grep -v '_mappers.dart' || true)
  if [ -n "$DTO_IMPORTS" ]; then
    HAS_ISSUES=true
    ISSUE_BODY+="## Regression: New DTO domain imports found (violates #223)\n\n"
    ISSUE_BODY+='```\n'
    ISSUE_BODY+="$DTO_IMPORTS"
    ISSUE_BODY+='\n```\n\n'
  fi
  
  # If issues found, create GitHub issue
  if [ "$HAS_ISSUES" = true ]; then
    ISSUES_CREATED=$((ISSUES_CREATED + 1))
    TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%SZ)
    ISSUE_TITLE="[HOURLY REVIEW] Regression findings at $TIMESTAMP"
    
    gh issue create \
      --repo traali/sakkoja \
      --title "$ISSUE_TITLE" \
      --label "bug" \
      --body "## Hourly Review Findings ($(date))
      
Commit: \`$CURRENT_SHA\`
      
$ISSUE_BODY
---
*Generated automatically by hourly_review.sh*" 2>/dev/null || echo "Failed to create issue (possibly no issues found)"
    
    echo "Created issue for findings."
  else
    echo "✅ No regressions found."
  fi
  
  # Run tests
  echo "Running flutter test..."
  flutter test --exclude-tags=golden 2>&1 | tail -3 || echo "Tests had failures (may be pre-existing)"
  
  echo ""
  echo "Iteration $i complete. Sleeping ${SLEEP_SECONDS}s..."
  
  # Update last SHA
  echo "$CURRENT_SHA" > "$LAST_SHA_FILE"
  
  sleep $SLEEP_SECONDS
done

END_TIME=$(date +%s)
DURATION=$(( (END_TIME - START_TIME) / 60 ))

echo ""
echo "=== Hourly Review Complete ==="
echo "Duration: ${DURATION} minutes"
echo "Issues created: $ISSUES_CREATED"

# Cleanup
rm -rf "$REPO_DIR"
rm -f "$LAST_SHA_FILE"
echo "Temp clone cleaned up."
