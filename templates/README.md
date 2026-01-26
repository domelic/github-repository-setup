# Templates Directory

This directory contains production-ready templates for GitHub repository automation. All templates are designed to work together and follow consistent patterns.

## Quick Start

### Using the Skill (Recommended)

The `/github-setup` skill automates template installation:

```bash
/github-setup              # Full setup wizard
/github-setup checklist    # Audit what's missing
/github-setup nodejs       # Node.js preset
```

### Manual Installation

Copy templates to your repository:

```bash
# Single file
cp templates/workflows/commitlint.yml .github/workflows/

# Entire category
cp -r templates/ISSUE_TEMPLATE/ .github/ISSUE_TEMPLATE/
```

## Directory Structure

| Directory | Contents | Target Location |
|-----------|----------|-----------------|
| `workflows/` | GitHub Actions workflows (70 files) | `.github/workflows/` |
| `ISSUE_TEMPLATE/` | Issue templates + config | `.github/ISSUE_TEMPLATE/` |
| `DISCUSSION_TEMPLATE/` | Discussion category templates | `.github/DISCUSSION_TEMPLATE/` |
| `.devcontainer/` | Dev container configs (9 languages) | `.devcontainer/` |
| `.husky/` | Git hooks for Node.js projects | `.husky/` |
| `.vscode/` | VS Code settings + extensions | `.vscode/` |
| `commands/` | Claude Code skills | `.claude/commands/` |
| `scripts/` | Helper scripts | `scripts/` or project root |
| `serena/` | Serena MCP configuration | `.serena/` |

Root-level files (configs, docs) go in your repository root.

## Template Categories

### Workflows (70 files)

| Category | Templates |
|----------|-----------|
| **CI** | `ci-nodejs.yml`, `ci-python.yml`, `ci-go.yml`, `ci-rust.yml`, `ci-java.yml`, `ci-ruby.yml`, `ci-php.yml`, `ci-dotnet.yml`, `ci-android.yml`, `ci-ios.yml`, `ci-flutter.yml`, `ci-react-native.yml`, `ci-terraform.yml`, `ci-cross-os.yml`, `ci.yml`, `ci-cpp.yml`, `ci-kotlin.yml`, `ci-swift.yml`, `ci-scala.yml`, `ci-elixir.yml` |
| **Quality** | `commitlint.yml`, `spell-check.yml`, `link-checker.yml`, `markdown-lint.yml`, `format-check.yml`, `super-linter.yml` |
| **Security** | `codeql.yml`, `trivy.yml`, `scorecard.yml`, `sbom.yml`, `dependency-review.yml` |
| **Testing** | `e2e-playwright.yml`, `e2e-cypress.yml`, `lighthouse.yml`, `coverage.yml` |
| **Release** | `release-please.yml`, `release-manual.yml`, `release-drafter.yml` |
| **Publishing** | `publish-npm.yml`, `publish-pypi.yml`, `publish-docker.yml`, `publish-crates.yml`, `publish-nuget.yml`, `publish-rubygems.yml`, `publish-maven.yml` |
| **Deployment (AWS)** | `deploy-aws-s3.yml`, `deploy-aws-lambda.yml` |
| **Deployment (Azure)** | `deploy-azure-webapp.yml`, `deploy-azure-functions.yml`, `deploy-azure-container.yml` |
| **Deployment (GCP)** | `deploy-gcp-cloudrun.yml`, `deploy-gcp-functions.yml`, `deploy-gcp-gke.yml` |
| **Deployment (PaaS)** | `deploy-github-pages.yml`, `deploy-vercel.yml`, `deploy-netlify.yml`, `deploy-fly.yml`, `deploy-railway.yml`, `deploy-render.yml`, `deploy-digitalocean.yml`, `deploy-kubernetes.yml` |
| **Management** | `stale.yml`, `welcome.yml`, `auto-labeler.yml`, `all-contributors.yml`, `artifact-preview.yml`, `docs-api.yml` |
| **Notifications** | `notify-slack.yml`, `notify-discord.yml` |
| **Specialty** | `amazon-kdp-publish.yml` |

### Configuration Files

| File | Purpose |
|------|---------|
| `commitlint.config.js` | Conventional commit rules |
| `.cspell.json` | Spell check dictionary |
| `.markdownlint.json` | Markdown lint rules |
| `.pre-commit-config.yaml` | Pre-commit hooks (Python) |
| `.editorconfig` | Editor formatting |
| `.gitattributes` | Git line endings and binary detection |
| `.prettierrc` | Prettier config |
| `.eslintrc.json` | ESLint config |
| `tsconfig.json` | TypeScript config |
| `biome.json` | Biome (ESLint+Prettier alternative) |
| `vitest.config.js` | Vitest test runner |
| `jest.config.js` | Jest test runner |
| `pyproject.toml` | Python project config |
| `turbo.json` | Turborepo monorepo config |
| `pnpm-workspace.yaml` | pnpm workspace config |
| `deno.json` | Deno runtime config |
| `docker-compose.yml` | Local development services |
| `codecov.yml` | Code coverage config |
| `dependabot.yml` | Dependabot basic config |
| `dependabot-full.yml` | Dependabot full config |
| `release-please-config.json` | Release Please config |
| `.release-please-manifest.json` | Release Please manifest |
| `release-drafter.yml` | Release Drafter config |
| `lefthook.yml` | Git hooks (language-agnostic) |
| `.lintstagedrc` | Lint-staged config |
| `.husky/pre-commit` | Husky pre-commit hook |
| `.husky/commit-msg` | Husky commit-msg hook |
| `FUNDING.yml` | GitHub Sponsors config |

### Documentation Templates

| File | Purpose |
|------|---------|
| `CONTRIBUTING.md` | Contribution guidelines |
| `SECURITY.md` | Security policy |
| `RELEASING.md` | Release process docs |
| `CITATION.cff` | Machine-readable citation |
| `CLAUDE.md` | Claude Code instructions |
| `CODEOWNERS` | Code ownership |
| `PULL_REQUEST_TEMPLATE.md` | PR template |

### License Templates

| File | License Type |
|------|--------------|
| `LICENSE-MIT` | MIT License |
| `LICENSE-APACHE-2.0` | Apache License 2.0 |
| `LICENSE-GPL-3.0` | GNU GPL v3 |

Replace `[YEAR]` and `[AUTHOR/ORGANIZATION]` placeholders with your details.

### Gitignore Templates

| File | Use Case |
|------|----------|
| `.gitignore-nodejs` | Node.js projects |
| `.gitignore-python` | Python projects |
| `.gitignore-go` | Go projects |
| `.gitignore-rust` | Rust projects |
| `.gitignore-global-macos` | macOS system files |
| `.gitignore-global-windows` | Windows system files |
| `.gitignore-global-jetbrains` | JetBrains IDE files |

Combine language + global templates for comprehensive coverage.

## Verification

All templates have SHA-256 checksums in `checksums.json`. Verify after download:

```bash
# Verify a single file
shasum -a 256 .github/workflows/commitlint.yml

# Compare with checksums.json entry
```

The `/github-setup` skill can verify checksums automatically.

## Customization

Templates are starting points. Common customizations:

1. **Workflow triggers** - Adjust `on:` section for your branching strategy
2. **Matrix versions** - Update language/runtime versions in CI workflows
3. **Secrets** - Add your own secret names for publishing/deployment
4. **Paths** - Adjust file paths for your project structure
5. **Thresholds** - Tune quality/security thresholds

## Documentation

For detailed documentation on each template, see the [main README](../README.md):

- Section 3: Quality Gates
- Section 4: Release Automation
- Section 5: CI Workflows
- Section 6: Security Workflows
- Section 7: Publishing & Deployment
- Section 8: Configuration Files

Additional guides in `docs/`:

- [Secrets Management](../docs/guides/SECRETS_MANAGEMENT.md)
- [Monorepo Patterns](../docs/architecture/MONOREPO_PATTERNS.md)
- [Release Drafter](../docs/guides/RELEASE_DRAFTER.md)
- [Markdown Lint](../docs/guides/MARKDOWN_LINT.md)
