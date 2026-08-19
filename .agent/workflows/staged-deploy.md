---
description: Deploy to Cloudflare Pages with staging (preview first, then promote to production)
---

# Staged Deployment Workflow

This workflow deploys to a preview URL first, then promotes to production after confirmation.

## Step 1: Build for Web
```powershell
flutter build web --release
```

## Step 2: Deploy to Preview (Staging)
Deploy to a preview branch (not main) to get a unique preview URL:
```powershell
npx wrangler pages deploy build/web --project-name=sakkoja --branch=staging
```
This creates a URL like `https://<commit-hash>.sakkoja.pages.dev`

## Step 3: Verify Preview
- Open the preview URL in browser
- Test critical functionality
- Check browser console for errors

## Step 4: Promote to Production
Once verified, deploy to production branch:
// turbo
```powershell
npx wrangler pages deploy build/web --project-name=sakkoja --branch=main
```
This updates `https://sakkoja.pages.dev`

## Step 5: Push Git Changes
// turbo
```powershell
git push origin main
```

## Notes
- Preview URLs are immutable and can be shared for testing
- Production URL always reflects the latest `main` branch deployment
- CORS proxy now accepts `*.sakkoja.pages.dev` origins for preview testing
