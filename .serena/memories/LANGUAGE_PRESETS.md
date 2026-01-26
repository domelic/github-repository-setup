# Language Presets

Quick lookup for per-language recommendations.

## Node.js / TypeScript

| Category | Template |
|----------|----------|
| CI | `ci-nodejs.yml` |
| DevContainer | `devcontainer-nodejs.json` |
| Publishing | `publish-npm.yml` |
| .gitignore | `.gitignore-nodejs` |
| Config | `tsconfig.json`, `.eslintrc.json`, `.prettierrc`, `biome.json` |
| Testing | `jest.config.js`, `vitest.config.js` |
| Monorepo | `turbo.json`, `pnpm-workspace.yaml` |

**Quality gates:** ESLint/Biome, Prettier, TypeScript strict, Jest/Vitest coverage

---

## Python

| Category | Template |
|----------|----------|
| CI | `ci-python.yml` |
| DevContainer | `devcontainer-python.json` |
| Publishing | `publish-pypi.yml` |
| .gitignore | `.gitignore-python` |
| Config | `pyproject.toml` |

**Quality gates:** Ruff (lint + format), mypy, pytest + coverage

---

## Go

| Category | Template |
|----------|----------|
| CI | `ci-go.yml` |
| DevContainer | `devcontainer-go.json` |
| .gitignore | `.gitignore-go` |

**Quality gates:** golangci-lint, go vet, go test -race

---

## Rust

| Category | Template |
|----------|----------|
| CI | `ci-rust.yml` |
| DevContainer | `devcontainer-rust.json` |
| Publishing | `publish-crates.yml` |
| .gitignore | `.gitignore-rust` |

**Quality gates:** clippy, rustfmt, cargo test

---

## Java

| Category | Template |
|----------|----------|
| CI | `ci-java.yml` |
| DevContainer | `devcontainer-java.json` |

**Quality gates:** Spotless, Checkstyle, JUnit

---

## Ruby

| Category | Template |
|----------|----------|
| CI | `ci-ruby.yml` |
| DevContainer | `devcontainer-ruby.json` |

**Quality gates:** RuboCop, RSpec

---

## PHP

| Category | Template |
|----------|----------|
| CI | `ci-php.yml` |
| DevContainer | `devcontainer-php.json` |

**Quality gates:** PHPStan, PHP CS Fixer, Pest/PHPUnit

---

## .NET

| Category | Template |
|----------|----------|
| CI | `ci-dotnet.yml` |
| DevContainer | `devcontainer-dotnet.json` |

**Quality gates:** dotnet format, dotnet test

---

## Android

| Category | Template |
|----------|----------|
| CI | `ci-android.yml` |

**Quality gates:** ktlint, detekt, unit tests, instrumented tests

---

## iOS

| Category | Template |
|----------|----------|
| CI | `ci-ios.yml` |

**Quality gates:** SwiftLint, XCTest

---

## Flutter

| Category | Template |
|----------|----------|
| CI | `ci-flutter.yml` |

**Quality gates:** flutter analyze, flutter test

---

## React Native

| Category | Template |
|----------|----------|
| CI | `ci-react-native.yml` |

**Quality gates:** ESLint, Jest, E2E (Detox/Maestro)

---

## Terraform

| Category | Template |
|----------|----------|
| CI | `ci-terraform.yml` |

**Quality gates:** terraform fmt, terraform validate, tflint, checkov

---

## Docker / Containers

| Category | Template |
|----------|----------|
| Publishing | `publish-docker.yml` |
| Security | `trivy.yml` |
| Local | `docker-compose.yml` |

**Quality gates:** hadolint, Trivy scan, multi-stage builds

---

## Static Sites

| Scenario | Template |
|----------|----------|
| GitHub Pages | `deploy-github-pages.yml` |
| Vercel | `deploy-vercel.yml` |
| Netlify | `deploy-netlify.yml` |

---

## Common Add-ons (Any Language)

| Purpose | Template |
|---------|----------|
| Security scanning | `codeql.yml`, `dependency-review.yml` |
| Coverage | `coverage.yml` + `codecov.yml` |
| Documentation | `docs-api.yml` |
| Release automation | `release-please.yml` |
| Dependency updates | `dependabot.yml` |
| E2E testing | `e2e-playwright.yml`, `e2e-cypress.yml` |
| Pre-commit hooks | `.pre-commit-config.yaml` |
| Commit linting | `commitlint.yml`, `commitlint.config.js` |
