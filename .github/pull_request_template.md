## Description
<!-- Brief summary of changes. What does this PR do? -->


## Type of Change
<!-- Check all that apply -->
- [ ] 🚀 `feat`: New feature
- [ ] 🐛 `fix`: Bug fix
- [ ] ⚡ `perf`: Performance improvement
- [ ] 🔧 `refactor`: Code restructuring
- [ ] 📚 `docs`: Documentation
- [ ] 🧪 `test`: Test changes
- [ ] 🔨 `chore`: Maintenance

## Changes Made
<!-- List the key changes -->
- 
- 
- 

## Testing
<!-- How was this tested? -->
- [ ] Flutter tests pass (`flutter test`)
- [ ] Architecture check (`dart run scripts/architecture_check.dart`)
- [ ] Companion tests pass (`cd apps/web-pwa && npm test && npm run typecheck`) — required if you touched `apps/web-pwa`, `web/_redirects`, or Pages deploy
- [ ] Zero analyze issues (`flutter analyze`)
- [ ] Code generation up-to-date (`build_runner build`)
- [ ] Tested manually on: <!-- Chrome / iOS / Android / /cockpit -->

## Screenshots/Recordings
<!-- If UI changes, add before/after screenshots -->


## Checklist
- [ ] CHANGELOG.md updated
- [ ] No breaking changes (or documented in description)
- [ ] Self-reviewed the code
- [ ] Added tests for new functionality
- [ ] Did **not** set `--base=./` or copy a second companion tree under `/pwa`
- [ ] `web/_redirects` still lists `/cockpit` and `/pwa` **above** `/* /index.html 200`
- [ ] Marine-safety numbers still live in `apps/web-pwa/src/lib/navikka/fetch-policy.ts` (AGENTS.md §13)

## Related Issues
<!-- Link related issues: Closes #123 -->
