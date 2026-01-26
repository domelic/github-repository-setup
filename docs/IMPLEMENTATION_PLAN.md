# Repository Completeness Implementation Plan

**Goal:** Make this repository the definitive resource for GitHub repository setup via Claude Code.

**Created:** 2026-01-25
**Status:** ✅ Complete

---

## Executive Summary

| Phase | Focus | Files to Add | Status |
|-------|-------|--------------|--------|
| 1 | Documentation & Discoverability | 7 items | ✅ Complete |
| 2 | Pre-commit Integration | 4 templates | ✅ Complete |
| 3 | Platform Coverage | 10 workflows | ✅ Complete |
| 4 | Language Coverage | 5 workflows | ✅ Complete |

**Estimated Total:** 25-30 new templates + documentation updates

---

## Current State Analysis

### What Exists

| Category | Count | Notes |
|----------|-------|-------|
| Workflow Templates | 54 | Good coverage for common languages |
| Config Templates | 24 | Good |
| Language CIs | 15 | Missing C/C++, Kotlin, Swift, Scala, Elixir |
| Deployment Targets | 9 | AWS only, missing Azure/GCP/DigitalOcean |
| Publishing Targets | 4 | Missing NuGet, RubyGems, Maven |
| Documentation | 7 guides | Excellent |

### Known Issues

1. **Version Mismatch:** `checksums.json` shows `v0.1.17` but README references `v0.1.19`
2. **Missing Referenced Templates:** `release-drafter.yml` workflow referenced in README but doesn't exist
3. **Undocumented Templates:** Several templates exist but aren't listed in skill presets

---

## Phase 1: Quick Wins (Documentation & Discoverability)

### 1.1 Fix Version Mismatch

- [ ] Update `templates/checksums.json` version to `0.1.19`
- [ ] Regenerate checksums after all new templates are added

### 1.2 Create Missing Templates

| Template | Purpose | Status |
|----------|---------|--------|
| `templates/FUNDING.yml` | GitHub Sponsors configuration | ⏳ |
| `templates/LICENSE-MIT` | MIT License template | ⏳ |
| `templates/LICENSE-APACHE-2.0` | Apache 2.0 License template | ⏳ |
| `templates/LICENSE-GPL-3.0` | GPL 3.0 License template | ⏳ |
| `templates/.gitattributes` | Git attributes for line endings | ⏳ |
| `templates/workflows/release-drafter.yml` | Release drafter workflow | ⏳ |
| `templates/release-drafter.yml` | Release drafter config | ⏳ |

### 1.3 Template Contents

#### FUNDING.yml

```yaml
# GitHub Sponsors configuration
# Place in .github/FUNDING.yml

github: [username]
patreon: username
open_collective: project-name
ko_fi: username
custom: ["https://example.com/sponsor"]
```

#### .gitattributes

```text
# Auto-detect text files and normalize line endings
* text=auto eol=lf

# Windows batch files need CRLF
*.{cmd,[cC][mM][dD]} text eol=crlf
*.{bat,[bB][aA][tT]} text eol=crlf

# Binary files
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.pdf binary
*.zip binary
*.gz binary
*.tar binary
```

---

## Phase 2: Pre-commit Integration

### Templates to Create

| Template | Purpose | Status |
|----------|---------|--------|
| `templates/.husky/pre-commit` | Husky pre-commit hook | ⏳ |
| `templates/.husky/commit-msg` | Husky commit-msg hook | ⏳ |
| `templates/.lintstagedrc` | Lint-staged configuration | ⏳ |
| `templates/lefthook.yml` | Lefthook (language-agnostic) | ⏳ |

### New Preset to Add

**`/github-setup hooks`** - Installs Husky + lint-staged for Node.js projects

| Template | Destination |
|----------|-------------|
| `.husky/pre-commit` | `.husky/pre-commit` |
| `.husky/commit-msg` | `.husky/commit-msg` |
| `.lintstagedrc` | `.lintstagedrc` |

---

## Phase 3: Expand Platform Coverage

### Deployment Workflows

| Template | Platform | Status |
|----------|----------|--------|
| `workflows/deploy-azure-webapp.yml` | Azure App Service | ⏳ |
| `workflows/deploy-azure-functions.yml` | Azure Functions | ⏳ |
| `workflows/deploy-azure-container.yml` | Azure Container Apps | ⏳ |
| `workflows/deploy-gcp-cloudrun.yml` | Google Cloud Run | ⏳ |
| `workflows/deploy-gcp-functions.yml` | Google Cloud Functions | ⏳ |
| `workflows/deploy-gcp-gke.yml` | Google Kubernetes Engine | ⏳ |
| `workflows/deploy-digitalocean.yml` | DigitalOcean App Platform | ⏳ |

### Publishing Workflows

| Template | Registry | Status |
|----------|----------|--------|
| `workflows/publish-nuget.yml` | NuGet (.NET) | ⏳ |
| `workflows/publish-rubygems.yml` | RubyGems | ⏳ |
| `workflows/publish-maven.yml` | Maven Central | ⏳ |

### New Presets to Add

- `/github-setup azure` - Azure deployment workflows
- `/github-setup gcp` - Google Cloud deployment workflows
- `/github-setup digitalocean` - DigitalOcean deployment

---

## Phase 4: Language Coverage

### CI Workflows to Create

| Template | Language | Features | Status |
|----------|----------|----------|--------|
| `workflows/ci-cpp.yml` | C/C++ | CMake, GCC/Clang matrix, sanitizers | ⏳ |
| `workflows/ci-kotlin.yml` | Kotlin/KMP | Gradle, multiplatform | ⏳ |
| `workflows/ci-swift.yml` | Swift | SPM, Xcode, macOS runner | ⏳ |
| `workflows/ci-scala.yml` | Scala | sbt, multi-version | ⏳ |
| `workflows/ci-elixir.yml` | Elixir | Mix, OTP versions, Dialyzer | ⏳ |

### New Presets to Add

- `/github-setup cpp` - C/C++ CI
- `/github-setup kotlin` - Kotlin CI
- `/github-setup swift` - Swift CI
- `/github-setup scala` - Scala CI
- `/github-setup elixir` - Elixir CI

---

## Files to Modify

### README.md Updates

- [ ] Add sections for hidden/undocumented templates
- [ ] Document new language presets
- [ ] Document new platform presets
- [ ] Add Azure/GCP/DigitalOcean deployment sections

### github-setup.md Updates

- [ ] Add `hooks` preset
- [ ] Add `azure` preset
- [ ] Add `gcp` preset
- [ ] Add `digitalocean` preset
- [ ] Add `cpp`, `kotlin`, `swift`, `scala`, `elixir` presets
- [ ] Expand `dotnet` to include NuGet publishing
- [ ] Expand `ruby` to include RubyGems publishing
- [ ] Expand `java` to include Maven publishing

### templates/README.md Updates

- [ ] Update workflow count
- [ ] Add new categories
- [ ] Document new config files

### checksums.json Updates

- [ ] Update version to match README
- [ ] Add checksums for all new templates

---

## Verification Checklist

### Phase 1 Verification

```bash
# Verify new templates exist
ls templates/FUNDING.yml
ls templates/LICENSE-*
ls templates/.gitattributes
ls templates/release-drafter.yml
ls templates/workflows/release-drafter.yml

# Verify version consistency
grep "v0.1" templates/checksums.json
grep "v0.1" README.md
```

### Phase 2 Verification

```bash
# Verify hooks templates
ls templates/.husky/
ls templates/.lintstagedrc
ls templates/lefthook.yml

# Verify preset added
grep "hooks" templates/commands/github-setup.md
```

### Phase 3 Verification

```bash
# Verify deployment workflows
ls templates/workflows/deploy-azure-*.yml
ls templates/workflows/deploy-gcp-*.yml
ls templates/workflows/deploy-digitalocean.yml

# Verify publishing workflows
ls templates/workflows/publish-nuget.yml
ls templates/workflows/publish-rubygems.yml
ls templates/workflows/publish-maven.yml
```

### Phase 4 Verification

```bash
# Verify language CI workflows
ls templates/workflows/ci-cpp.yml
ls templates/workflows/ci-kotlin.yml
ls templates/workflows/ci-swift.yml
ls templates/workflows/ci-scala.yml
ls templates/workflows/ci-elixir.yml
```

### Final Verification

```bash
# Count total templates - should be ~65+ workflows
ls templates/workflows/*.yml | wc -l

# Verify all new presets documented
grep -E "(azure|gcp|digitalocean|cpp|kotlin|swift|scala|elixir|hooks)" \
  templates/commands/github-setup.md
```

---

## Execution Order

1. **Phase 1** - Quick wins, document existing hidden features
2. **Phase 2** - Pre-commit is commonly requested
3. **Phase 3** - Cloud platforms expand enterprise adoption
4. **Phase 4** - Additional languages complete coverage
5. **Final** - Update all documentation and regenerate checksums

Each phase should be a separate commit for clean history.

---

## Expected Results

| Metric | Before | After |
|--------|--------|-------|
| Workflow Templates | 54 | ~69 (+15) |
| Config Templates | 24 | ~32 (+8) |
| Language CIs | 15 | 20 (+5) |
| Deployment Targets | 9 | 16 (+7) |
| Publishing Targets | 4 | 7 (+3) |
| Documented Templates | ~80% | 100% |
| Cloud Platform Coverage | AWS only | AWS + Azure + GCP + DO |

---

## Notes

- All workflows follow existing patterns in the repository
- Templates use consistent naming conventions
- Each template includes inline documentation
- Checksums will be regenerated after all templates are added
