# Template Inventory

Quick reference for all templates in this repository.

## Workflow Templates (54 total)

### CI Workflows

| File | Purpose | Language/Stack |
|------|---------|----------------|
| `ci.yml` | Generic CI workflow | Any |
| `ci-nodejs.yml` | Node.js CI with matrix testing | Node.js 18/20/22 |
| `ci-python.yml` | Python CI with ruff, mypy, pytest | Python 3.10/3.11/3.12 |
| `ci-go.yml` | Go CI with golangci-lint | Go |
| `ci-rust.yml` | Rust CI with clippy, fmt | Rust |
| `ci-java.yml` | Java/Gradle CI | Java |
| `ci-ruby.yml` | Ruby CI with RuboCop | Ruby |
| `ci-php.yml` | PHP CI with PHPStan, Pest | PHP |
| `ci-dotnet.yml` | .NET CI | .NET |
| `ci-android.yml` | Android CI | Kotlin/Java |
| `ci-ios.yml` | iOS CI with Xcode | Swift |
| `ci-flutter.yml` | Flutter CI | Dart |
| `ci-react-native.yml` | React Native CI | JS/TS |
| `ci-terraform.yml` | Terraform validate/plan | Terraform |
| `ci-cross-os.yml` | Multi-OS matrix testing | Any |

### Deploy Workflows

| File | Purpose | Target |
|------|---------|--------|
| `deploy-vercel.yml` | Vercel deployment | Vercel |
| `deploy-netlify.yml` | Netlify deployment | Netlify |
| `deploy-fly.yml` | Fly.io deployment | Fly.io |
| `deploy-railway.yml` | Railway deployment | Railway |
| `deploy-render.yml` | Render deployment | Render |
| `deploy-aws-s3.yml` | S3 static site deploy | AWS S3 |
| `deploy-aws-lambda.yml` | Lambda deployment | AWS Lambda |
| `deploy-github-pages.yml` | GitHub Pages deployment | GitHub Pages |
| `deploy-kubernetes.yml` | Kubernetes deployment | K8s |

### Publish Workflows

| File | Purpose | Registry |
|------|---------|----------|
| `publish-npm.yml` | npm package publishing | npm |
| `publish-pypi.yml` | PyPI package publishing | PyPI |
| `publish-crates.yml` | Rust crate publishing | crates.io |
| `publish-docker.yml` | Docker image publishing | GHCR/DockerHub |
| `amazon-kdp-publish.yml` | Amazon KDP publishing | Amazon KDP |

### Testing Workflows

| File | Purpose |
|------|---------|
| `e2e-playwright.yml` | Playwright E2E tests |
| `e2e-cypress.yml` | Cypress E2E tests |
| `coverage.yml` | Code coverage with Codecov |
| `lighthouse.yml` | Lighthouse performance audits |

### Security Workflows

| File | Purpose |
|------|---------|
| `codeql.yml` | CodeQL security scanning |
| `dependency-review.yml` | Dependency vulnerability review |
| `trivy.yml` | Container/filesystem vulnerability scan |
| `scorecard.yml` | OpenSSF Scorecard |
| `sbom.yml` | Software Bill of Materials |

### Quality & Linting Workflows

| File | Purpose |
|------|---------|
| `super-linter.yml` | Multi-language linting |
| `format-check.yml` | Code format checking |
| `markdown-lint.yml` | Markdown linting |
| `spell-check.yml` | Spelling check |
| `link-checker.yml` | Link validation |
| `commitlint.yml` | Commit message linting |

### Release & Versioning

| File | Purpose |
|------|---------|
| `release-please.yml` | Automated releases with Release Please |
| `release-manual.yml` | Manual release workflow |

### Documentation

| File | Purpose |
|------|---------|
| `docs-api.yml` | API documentation generation |

### Community Management

| File | Purpose |
|------|---------|
| `stale.yml` | Mark stale issues/PRs |
| `auto-labeler.yml` | Auto-label PRs by path |
| `welcome.yml` | Welcome new contributors |
| `all-contributors.yml` | Manage contributors list |

### Notifications

| File | Purpose |
|------|---------|
| `notify-slack.yml` | Slack notifications |
| `notify-discord.yml` | Discord notifications |

### Other

| File | Purpose |
|------|---------|
| `artifact-preview.yml` | Preview build artifacts |

---

## Configuration Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Claude Code configuration |
| `CODEOWNERS` | Code ownership rules |
| `CONTRIBUTING.md` | Contribution guidelines |
| `SECURITY.md` | Security policy |
| `PULL_REQUEST_TEMPLATE.md` | PR template |
| `dependabot.yml` | Basic Dependabot config |
| `dependabot-full.yml` | Full Dependabot config |
| `codecov.yml` | Codecov configuration |
| `.pre-commit-config.yaml` | Pre-commit hooks |
| `commitlint.config.js` | Commitlint rules |
| `.editorconfig` | Editor configuration |
| `.markdownlint.json` | Markdownlint rules |
| `.cspell.json` | CSpell dictionary |
| `.prettierrc` | Prettier configuration |
| `.eslintrc.json` | ESLint configuration |
| `biome.json` | Biome configuration |
| `tsconfig.json` | TypeScript config |
| `jest.config.js` | Jest configuration |
| `vitest.config.js` | Vitest configuration |
| `turbo.json` | Turborepo config |
| `deno.json` | Deno configuration |
| `pyproject.toml` | Python project config |
| `.npmrc` | npm configuration |
| `pnpm-workspace.yaml` | pnpm workspace |
| `docker-compose.yml` | Docker Compose template |
| `release-please-config.json` | Release Please config |
| `.release-please-manifest.json` | Release Please manifest |
| `CITATION.cff` | Citation file |
| `RELEASING.md` | Release guide |

## DevContainer Templates

| File | Language |
|------|----------|
| `devcontainer.json` | Generic |
| `devcontainer-nodejs.json` | Node.js |
| `devcontainer-python.json` | Python |
| `devcontainer-go.json` | Go |
| `devcontainer-rust.json` | Rust |
| `devcontainer-java.json` | Java |
| `devcontainer-ruby.json` | Ruby |
| `devcontainer-php.json` | PHP |
| `devcontainer-dotnet.json` | .NET |

## Language-Specific .gitignore Files

| File | Language |
|------|----------|
| `.gitignore-nodejs` | Node.js |
| `.gitignore-python` | Python |
| `.gitignore-go` | Go |
| `.gitignore-rust` | Rust |
| `.gitignore-global-macos` | macOS global |
| `.gitignore-global-windows` | Windows global |
| `.gitignore-global-jetbrains` | JetBrains IDEs |

---

## When to Use

| Scenario | Recommended Templates |
|----------|----------------------|
| New Node.js library | `ci-nodejs.yml`, `publish-npm.yml`, `devcontainer-nodejs.json` |
| New Python package | `ci-python.yml`, `publish-pypi.yml`, `devcontainer-python.json` |
| Static site | `deploy-github-pages.yml` or `deploy-vercel.yml` |
| Dockerized app | `publish-docker.yml`, `trivy.yml` |
| Security-conscious project | `codeql.yml`, `dependency-review.yml`, `scorecard.yml` |
| Open source project | `CONTRIBUTING.md`, `SECURITY.md`, `welcome.yml`, `all-contributors.yml` |
| Monorepo | `turbo.json`, `pnpm-workspace.yaml` |
