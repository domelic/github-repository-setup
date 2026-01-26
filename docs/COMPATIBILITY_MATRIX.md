# Workflow Compatibility Matrix

This document details which workflow presets work together, potential conflicts, and recommended combinations for different project types.

## Table of Contents

- [Preset Compatibility](#preset-compatibility)
- [Language Presets](#language-presets)
- [Feature Presets](#feature-presets)
- [Conflicts and Resolutions](#conflicts-and-resolutions)
- [Recommended Stacks](#recommended-stacks)
- [Secrets Requirements](#secrets-requirements)

---

## Preset Compatibility

### Core Preset Matrix

This matrix shows which presets can be combined. All combinations marked with a checkmark are fully compatible.

| Preset | nodejs | python | go | rust | java | dotnet | ruby | quality | security | releases | docker |
|--------|:------:|:------:|:--:|:----:|:----:|:------:|:----:|:-------:|:--------:|:--------:|:------:|
| **nodejs** | - | - | - | - | - | - | - | ✅ | ✅ | ✅ | ✅ |
| **python** | - | - | - | - | - | - | - | ✅ | ✅ | ✅ | ✅ |
| **go** | - | - | - | - | - | - | - | ✅ | ✅ | ✅ | ✅ |
| **rust** | - | - | - | - | - | - | - | ✅ | ✅ | ✅ | ✅ |
| **java** | - | - | - | - | - | - | - | ✅ | ✅ | ✅ | ✅ |
| **dotnet** | - | - | - | - | - | - | - | ✅ | ✅ | ✅ | ✅ |
| **ruby** | - | - | - | - | - | - | - | ✅ | ✅ | ✅ | ✅ |
| **quality** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | - | ✅ | ✅ | ✅ |
| **security** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | - | ✅ | ✅ |
| **releases** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | - | ✅ |
| **docker** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | - |

### Extended Preset Matrix

| Preset | community | docs | notifications | observability | mobile | infrastructure |
|--------|:---------:|:----:|:-------------:|:-------------:|:------:|:--------------:|
| **nodejs** | ✅ | ✅ | ✅ | ✅ | ⚠️ | ✅ |
| **python** | ✅ | ✅ | ✅ | ✅ | - | ✅ |
| **go** | ✅ | ✅ | ✅ | ✅ | - | ✅ |
| **quality** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **security** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **releases** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **mobile** | ✅ | ✅ | ✅ | ✅ | - | - |

**Legend:**
- ✅ Fully compatible
- ⚠️ Compatible with considerations (see notes)
- `-` Not typically combined or not applicable

---

## Language Presets

### nodejs

**Included workflows:**
- `ci-nodejs.yml` - Build and test with Node.js
- `publish-npm.yml` - Publish to npm registry

**Commonly paired with:**
- `quality` - E2E testing, formatting
- `security` - CodeQL, dependency review
- `releases` - release-please
- `vercel` or `netlify` - Deployment

**Secrets required:**

| Secret | Required For | Setup URL |
|--------|-------------|-----------|
| `NPM_TOKEN` | npm publishing | [npm tokens](https://www.npmjs.com/settings/~/tokens) |

---

### python

**Included workflows:**
- `ci-python.yml` - Build and test with Python
- `publish-pypi.yml` - Publish to PyPI

**Commonly paired with:**
- `quality` - Coverage, formatting
- `security` - CodeQL, Snyk
- `releases` - release-please
- `docs` - API documentation

**Secrets required:**

| Secret | Required For | Setup URL |
|--------|-------------|-----------|
| `PYPI_API_TOKEN` | PyPI publishing | [PyPI tokens](https://pypi.org/manage/account/) |

---

### go

**Included workflows:**
- `ci-go.yml` - Build and test with Go
- `publish-cli-binaries.yml` - Cross-compile CLI binaries

**Commonly paired with:**
- `quality` - Format check, golangci-lint
- `security` - CodeQL, Trivy
- `releases` - release-please
- `docker` - Container builds

**Secrets required:**

| Secret | Required For |
|--------|-------------|
| None required | Basic usage |

---

### rust

**Included workflows:**
- `ci-rust.yml` - Build and test with Cargo
- `publish-crates.yml` - Publish to crates.io

**Commonly paired with:**
- `quality` - Clippy, fmt
- `security` - CodeQL
- `releases` - release-please

**Secrets required:**

| Secret | Required For | Setup URL |
|--------|-------------|-----------|
| `CRATES_TOKEN` | crates.io publishing | [crates.io tokens](https://crates.io/settings/tokens) |

---

### java

**Included workflows:**
- `ci-java.yml` - Build and test with Maven/Gradle
- `publish-maven.yml` - Publish to Maven Central

**Commonly paired with:**
- `quality` - SonarCloud
- `security` - CodeQL, Snyk
- `releases` - release-please

**Secrets required:**

| Secret | Required For |
|--------|-------------|
| `MAVEN_USERNAME` | Maven Central |
| `MAVEN_PASSWORD` | Maven Central |
| `GPG_PRIVATE_KEY` | Artifact signing |
| `GPG_PASSPHRASE` | Artifact signing |

---

### dotnet

**Included workflows:**
- `ci-dotnet.yml` - Build and test with .NET
- `publish-nuget.yml` - Publish to NuGet

**Commonly paired with:**
- `quality` - Code coverage
- `security` - CodeQL
- `releases` - release-please
- `azure` - Azure deployment

**Secrets required:**

| Secret | Required For | Setup URL |
|--------|-------------|-----------|
| `NUGET_API_KEY` | NuGet publishing | [NuGet API keys](https://www.nuget.org/account/apikeys) |

---

## Feature Presets

### quality

**Included workflows:**
- `commitlint.yml` - Commit message validation
- `format-check.yml` - Code formatting
- `e2e-playwright.yml` - End-to-end testing
- `lighthouse.yml` - Performance audits
- `codecov.yml` - Code coverage

**Compatible with:** All language presets

---

### security

**Included workflows:**
- `codeql.yml` - GitHub code scanning
- `dependency-review.yml` - PR dependency audit
- `trivy.yml` - Container scanning
- `scorecard.yml` - OpenSSF metrics
- `sbom.yml` - SBOM generation

**Compatible with:** All language presets

---

### releases

**Included workflows:**
- `release-please.yml` - Automated releases

**Triggers on release:**
- Language-specific publish workflows
- `sentry-release.yml` (if configured)

**Conflicts with:** `release-drafter` (choose one approach)

---

### docker

**Included workflows:**
- `publish-docker.yml` - Build and push images
- `trivy.yml` - Container scanning

**Registry options:**
- GitHub Container Registry (GHCR) - No secrets needed
- Docker Hub - Requires `DOCKER_USERNAME`, `DOCKER_PASSWORD`
- AWS ECR - Requires AWS credentials
- Google GCR - Requires GCP credentials
- Azure ACR - Requires Azure credentials

---

### community

**Included workflows:**
- `welcome.yml` - Greet new contributors
- `stale.yml` - Manage inactive issues
- `all-contributors.yml` - Recognize contributors
- `auto-labeler.yml` - Auto-label PRs

**Compatible with:** All presets (no conflicts)

---

### docs

**Included workflows:**
- `markdown-lint.yml` - Lint markdown
- `spell-check.yml` - Check spelling
- `link-checker.yml` - Validate URLs
- `docs-api.yml` - API documentation
- `deploy-github-pages.yml` - Publish docs

**Compatible with:** All presets

---

### notifications

**Included workflows:**
- `notify-slack.yml` - Slack alerts
- `notify-discord.yml` - Discord alerts
- `notify-teams.yml` - Teams alerts

**Secrets required:**

| Secret | Required For |
|--------|-------------|
| `SLACK_WEBHOOK_URL` | Slack notifications |
| `DISCORD_WEBHOOK_URL` | Discord notifications |
| `TEAMS_WEBHOOK_URL` | Teams notifications |

---

## Conflicts and Resolutions

### Release Management Conflict

| Workflow A | Workflow B | Conflict | Resolution |
|------------|------------|----------|------------|
| `release-please.yml` | `release-drafter.yml` | Both manage releases | Choose one approach |

**Recommendation:**
- Use `release-please` for automated releases with conventional commits
- Use `release-drafter` for manual releases with PR-based changelogs

---

### Linter Overlap

| Workflow A | Workflow B | Overlap | Resolution |
|------------|------------|---------|------------|
| `super-linter.yml` | Individual linters | Redundant checks | Choose based on need |

**Recommendation:**
- Use `super-linter` for polyglot projects (single config, many languages)
- Use individual linters for fine-grained control per language

---

### Security Scanner Overlap

| Workflow A | Workflow B | Overlap | Resolution |
|------------|------------|---------|------------|
| `snyk.yml` | `trivy.yml` | Container scanning | Both provide value |
| `snyk.yml` | `codeql.yml` | Code scanning | Both provide value |

**Recommendation:**
- `codeql.yml` - Free, GitHub-native, always recommended
- `trivy.yml` - Free, excellent for containers and IaC
- `snyk.yml` - Enterprise features, unified dashboard (paid for advanced)

Both Snyk and Trivy can run together without conflicts.

---

### Visual Regression Overlap

| Workflow A | Workflow B | Conflict |
|------------|------------|----------|
| `visual-regression-percy.yml` | `visual-regression-chromatic.yml` | Redundant |
| `visual-regression-chromatic.yml` | `visual-regression-backstop.yml` | Redundant |

**Recommendation:**
Choose ONE visual regression tool:
- **Percy** - General visual testing, integrates with Cypress/Playwright
- **Chromatic** - Storybook-specific, component-level testing
- **BackstopJS** - Self-hosted, open-source option

---

## Recommended Stacks

### Minimal Starter

For new projects with basic needs:

```bash
# Copy minimal stack
cp templates/workflows/{ci-nodejs,release-please,dependency-review}.yml .github/workflows/
```

| Workflow | Purpose |
|----------|---------|
| `ci-nodejs.yml` | Build and test |
| `release-please.yml` | Automated releases |
| `dependency-review.yml` | Security on PRs |

---

### Full Quality Stack

For projects prioritizing code quality:

```bash
# Copy quality stack
cp templates/workflows/{ci-nodejs,commitlint,format-check,e2e-playwright,codecov,lighthouse,a11y}.yml .github/workflows/
```

| Workflow | Purpose |
|----------|---------|
| `ci-nodejs.yml` | Build and test |
| `commitlint.yml` | Enforce commit standards |
| `format-check.yml` | Code formatting |
| `e2e-playwright.yml` | E2E testing |
| `codecov.yml` | Coverage reporting |
| `lighthouse.yml` | Performance audits |
| `a11y.yml` | Accessibility testing |

---

### Security-First Stack

For projects with strict security requirements:

```bash
# Copy security stack
cp templates/workflows/{ci-nodejs,codeql,dependency-review,trivy,snyk,scorecard,sbom,license-check}.yml .github/workflows/
```

| Workflow | Purpose |
|----------|---------|
| `codeql.yml` | Static analysis |
| `dependency-review.yml` | Dependency audit |
| `trivy.yml` | Container/IaC scanning |
| `snyk.yml` | Comprehensive scanning |
| `scorecard.yml` | OpenSSF metrics |
| `sbom.yml` | Software inventory |
| `license-check.yml` | License compliance |

---

### Production Deployment Stack

For projects deploying to production:

```bash
# Copy deployment stack
cp templates/workflows/{ci-nodejs,e2e-playwright,release-please,publish-docker,deploy-kubernetes,notify-slack,sentry-release,datadog-ci}.yml .github/workflows/
```

| Workflow | Purpose |
|----------|---------|
| `ci-nodejs.yml` | Build and test |
| `e2e-playwright.yml` | E2E before deploy |
| `release-please.yml` | Manage releases |
| `publish-docker.yml` | Build containers |
| `deploy-kubernetes.yml` | Deploy to K8s |
| `notify-slack.yml` | Deployment alerts |
| `sentry-release.yml` | Error tracking |
| `datadog-ci.yml` | CI observability |

---

## Secrets Requirements

### Quick Reference by Category

#### Publishing Secrets

| Secret | Workflows | Required |
|--------|-----------|----------|
| `NPM_TOKEN` | publish-npm | Yes |
| `PYPI_API_TOKEN` | publish-pypi | Yes |
| `CRATES_TOKEN` | publish-crates | Yes |
| `RUBYGEMS_API_KEY` | publish-rubygems | Yes |
| `NUGET_API_KEY` | publish-nuget | Yes |
| `DOCKER_USERNAME` | publish-docker-hub | Yes |
| `DOCKER_PASSWORD` | publish-docker-hub | Yes |

#### Cloud Provider Secrets

| Secret | Workflows | Required |
|--------|-----------|----------|
| `AWS_ACCESS_KEY_ID` | deploy-aws-*, publish-docker-ecr | Yes |
| `AWS_SECRET_ACCESS_KEY` | deploy-aws-*, publish-docker-ecr | Yes |
| `AZURE_CREDENTIALS` | deploy-azure-*, publish-docker-acr | Yes |
| `GCP_CREDENTIALS` | deploy-gcp-*, publish-docker-gcr | Yes |

#### Platform Secrets

| Secret | Workflows | Required |
|--------|-----------|----------|
| `VERCEL_TOKEN` | deploy-vercel | Yes |
| `VERCEL_ORG_ID` | deploy-vercel | Yes |
| `VERCEL_PROJECT_ID` | deploy-vercel | Yes |
| `NETLIFY_AUTH_TOKEN` | deploy-netlify | Yes |
| `NETLIFY_SITE_ID` | deploy-netlify | Yes |
| `FLY_API_TOKEN` | deploy-fly | Yes |
| `KUBE_CONFIG` | deploy-kubernetes | Yes |

#### Security Tool Secrets

| Secret | Workflows | Required |
|--------|-----------|----------|
| `SNYK_TOKEN` | snyk | Yes |
| `SONAR_TOKEN` | sonarcloud | Yes |

#### Notification Secrets

| Secret | Workflows | Required |
|--------|-----------|----------|
| `SLACK_WEBHOOK_URL` | notify-slack | Yes |
| `DISCORD_WEBHOOK_URL` | notify-discord | Yes |
| `TEAMS_WEBHOOK_URL` | notify-teams | Yes |

#### Observability Secrets

| Secret | Workflows | Required |
|--------|-----------|----------|
| `DD_API_KEY` | datadog-ci | Yes |
| `SENTRY_AUTH_TOKEN` | sentry-release | Yes |
| `SENTRY_ORG` | sentry-release | Yes |
| `SENTRY_PROJECT` | sentry-release | Yes |

---

## See Also

- [Workflow Diagrams](WORKFLOW_DIAGRAMS.md) - Visual dependency graphs
- [Workflow Metadata](../templates/workflows/workflow-metadata.yaml) - Full metadata index
- [Workflow README](../templates/workflows/README.md) - Quick reference
- [/github-setup skill](../templates/commands/github-setup.md) - Interactive setup
