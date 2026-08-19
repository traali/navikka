---
description: Start a new feature branch synchronized with main
---

# Workflow: Start Feature

1. Ask the user for the name of the feature (e.g., \"user-auth\").
2. Switch to the main branch:
   `ash
   git checkout main
   `
3. Pull the latest changes:
   `ash
   git pull origin main
   `
4. Create and switch to the new feature branch:
   `ash
   git checkout -b feature/{{feature_name}}
   `
5. Notify the user that the branch is ready.
