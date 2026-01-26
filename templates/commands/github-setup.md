# GitHub Repository Setup Skill

Set up GitHub repositories with production-grade automation by fetching templates from the [github-repository-setup](https://github.com/domelic/github-repository-setup) repository.

## Usage

```bash
/github-setup                    # Full setup wizard (auto-detects project type)
/github-setup checklist          # Audit what's missing
/github-setup <preset>           # Apply a specific preset
```

---

## Which Preset Should I Use?

### Quick Decision Tree

```text
What's your project type?
│
├─ Web Application
│  ├─ Node.js/TypeScript → nodejs
│  ├─ Python/Django/Flask → python
│  ├─ Go → go
│  ├─ Ruby/Rails → ruby
│  ├─ PHP/Laravel → php
│  └─ .NET/C# → dotnet
│
├─ Mobile App
│  ├─ iOS (Swift) → ios + swift
│  ├─ Android (Kotlin) → android + kotlin
│  ├─ Flutter → flutter
│  └─ React Native → react-native
│
├─ Game Development
│  ├─ Godot 4.x → godot
│  └─ Unity → unity
│
├─ ML/AI Project
│  └─ Python + ML → ml
│
├─ CLI Tool (with binaries)
│  ├─ Go → go + cli-tool
│  └─ Rust → rust + cli-tool
│
├─ Systems Programming
│  ├─ Rust → rust
│  ├─ C/C++ → cpp
│  └─ Go → go
│
├─ JVM Languages
│  ├─ Java → java
│  ├─ Kotlin → kotlin
│  └─ Scala → scala
│
├─ Infrastructure
│  ├─ Terraform → terraform
│  ├─ Kubernetes → kubernetes
│  └─ Serverless → serverless
│
├─ Blockchain/Web3
│  ├─ Hardhat → web3 (Hardhat)
│  └─ Foundry → web3 (Foundry)
│
├─ Browser Extension
│  └─ Chrome/Firefox → browser-extension
│
├─ Desktop Application
│  └─ Electron → electron
│
├─ Embedded/IoT
│  └─ PlatformIO → embedded
│
├─ Documentation Only
│  └─ docs
│
├─ Mobile App (Publishing)
│  ├─ Play Store → mobile-publish
│  └─ TestFlight/App Store → mobile-publish
│
├─ Web App (Performance)
│  └─ Bundle Size Tracking → bundle-size
│
├─ API / Microservices
│  └─ Contract Testing → contract-testing
│
├─ Component Library
│  └─ Storybook Documentation → storybook
│
└─ Security (Dynamic Testing)
   └─ OWASP ZAP DAST → dast
```

### Common Preset Bundles

| Use Case | Recommended Presets |
|----------|---------------------|
| **Production Web App** | `{language}` + `quality` + `security` + `deploy` + `releases` + `a11y` |
| **Open Source Library** | `{language}` + `docs` + `issues` + `releases` + `bots` + `api-docs` |
| **Enterprise Project** | `{language}` + `security` + `sonarcloud` + `snyk` + `multienv` + `codecov` |
| **Internal Tool** | `{language}` + `quality` + `notifications` |
| **Startup MVP** | `{language}` + `deploy` + `notifications` |
| **Game Project** | `godot` or `unity` + `releases` + `notifications` |
| **ML/AI Project** | `ml` + `releases` + `observability` + `codecov` |
| **CLI Distribution** | `{language}` + `cli-tool` + `releases` |
| **API Backend** | `{language}` + `api-docs` + `codecov` + `security` + `deploy` |
| **Web3 dApp** | `nodejs` + `web3` + `security` |
| **Browser Extension** | `nodejs` + `browser-extension` + `quality` |
| **Desktop App** | `nodejs` + `electron` + `releases` |
| **IoT Project** | `embedded` + `releases` |
| **Production Mobile App** | `android` or `ios` + `mobile-publish` + `security` |
| **Web App with Perf Focus** | `nodejs` + `bundle-size` + `lighthouse` |
| **Microservices API** | `{language}` + `contract-testing` + `api-docs` |
| **Component Library** | `nodejs` + `storybook` + `visual-regression` |
| **Security-Critical App** | `{language}` + `security` + `dast` + `snyk` |

### Preset Selection FAQ

**Q: Can I use multiple presets?**
A: Yes! Presets are composable. Apply them sequentially for your needs. See the [Compatibility Matrix](https://github.com/domelic/github-repository-setup/blob/main/docs/COMPATIBILITY_MATRIX.md) for which presets work best together and potential conflicts.

**Q: What's the difference between `python` and `ml`?**
A: The `python` preset is for general Python projects. The `ml` preset adds GPU support, Jupyter validation, and ML-specific tooling (DVC, experiment tracking).

**Q: Should I use `security` or `snyk`?**
A: Use `security` for GitHub-native scanning (CodeQL, Trivy). Add `snyk` for additional dependency vulnerability detection with Snyk's database.

**Q: What about monorepos?**
A: Use your primary language preset + `monorepo` for Turborepo/pnpm workspace configuration.

**Q: How do I understand workflow dependencies?**
A: See the [Workflow Diagrams](https://github.com/domelic/github-repository-setup/blob/main/docs/WORKFLOW_DIAGRAMS.md) for visual chains showing how workflows trigger each other (e.g., release-please → publish-npm).

---

## Template Source

**Pinned Version:** `v0.1.21`

**Base URL:** `https://raw.githubusercontent.com/domelic/github-repository-setup/v0.1.21/templates/`

All templates are fetched from this pinned release. This ensures stability - templates won't change unexpectedly.

### Upgrading to a New Version

To use a newer version, update the version in the Base URL (e.g., `v0.1.14`). Check the [releases page](https://github.com/domelic/github-repository-setup/releases) for available versions.

---

## Integrity Verification

Templates include SHA-256 checksums for integrity verification.

### Checksum Manifest

Fetch the checksums file:
```bash
VERSION="v0.1.21"  # Update to match pinned version
curl -s "https://raw.githubusercontent.com/domelic/github-repository-setup/$VERSION/templates/checksums.json"
```

### Verification Process

After fetching a template, verify its integrity:

```bash
# Fetch template
curl -o .editorconfig "https://raw.githubusercontent.com/domelic/github-repository-setup/v0.1.21/templates/.editorconfig"

# Verify checksum (expected: fb56b1f408051f0a09ab65e33be8e7e21e2eeba3bd4f0c4041bc121106d61c71)
shasum -a 256 .editorconfig
```

If checksums don't match, the template may have been tampered with or corrupted during download.

---

## Fallback Templates

If network access is unavailable, use these critical templates inline.

<details>
<summary><strong>.editorconfig</strong> (universal)</summary>

```ini
# EditorConfig helps maintain consistent coding styles across editors
# https://editorconfig.org

root = true

# Default settings for all files
[*]
charset = utf-8
end_of_line = lf
indent_style = space
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true

# Markdown files - preserve trailing whitespace for line breaks
[*.md]
trim_trailing_whitespace = false

# Python - PEP 8 recommends 4 spaces
[*.py]
indent_size = 4

# Go - tabs per gofmt convention
[*.go]
indent_style = tab
indent_size = 4

# Rust - 4 spaces per rustfmt default
[*.rs]
indent_size = 4

# Makefiles require tabs
[Makefile]
indent_style = tab

[*.mk]
indent_style = tab

# Shell scripts
[*.sh]
indent_size = 2

# YAML files
[*.{yml,yaml}]
indent_size = 2

# JSON files
[*.json]
indent_size = 2

# TOML files (Rust/Python)
[*.toml]
indent_size = 2

# Docker
[Dockerfile*]
indent_size = 2

# Git config files
[.git*]
indent_size = 2
```

**Checksum:** `fb56b1f408051f0a09ab65e33be8e7e21e2eeba3bd4f0c4041bc121106d61c71`
</details>

<details>
<summary><strong>dependabot.yml</strong> (security updates)</summary>

```yaml
version: 2
updates:
  # Keep GitHub Actions up to date
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
    commit-message:
      prefix: "ci"
    labels:
      - "dependencies"
      - "github-actions"
    open-pull-requests-limit: 5
    groups:
      # Group all action updates into a single PR
      actions:
        patterns:
          - "*"

  # Uncomment for npm projects
  # - package-ecosystem: "npm"
  #   directory: "/"
  #   schedule:
  #     interval: "weekly"
  #   commit-message:
  #     prefix: "chore"
  #   labels:
  #     - "dependencies"
  #   groups:
  #     minor-and-patch:
  #       update-types:
  #         - "minor"
  #         - "patch"

  # Uncomment for Python projects
  # - package-ecosystem: "pip"
  #   directory: "/"
  #   schedule:
  #     interval: "weekly"
  #   commit-message:
  #     prefix: "chore"
```

**Checksum:** `45c682820aebaeae78eb15629d2a795883327bb53ccc682a506caff9b4a0ea2b`
</details>

<details>
<summary><strong>.gitignore-global-macos</strong></summary>

```gitignore
# macOS Global .gitignore template
# https://github.com/github/gitignore/blob/main/Global/macOS.gitignore
#
# USAGE: This is a GLOBAL gitignore template for user-level configuration.
# Add to your global gitconfig:
#   git config --global core.excludesfile ~/.gitignore_global
#
# Or combine with language-specific templates in your project .gitignore.

# General
.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon

# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

# iCloud generated files
*.icloud
```

**Checksum:** `3c27393491661db73fd7f05e84fe874c6a55cadb6a5dd5e8bfe9500cbddd91b1`
</details>

<details>
<summary><strong>.gitignore-global-windows</strong></summary>

```gitignore
# Windows Global .gitignore template
# https://github.com/github/gitignore/blob/main/Global/Windows.gitignore
#
# USAGE: This is a GLOBAL gitignore template for user-level configuration.
# Add to your global gitconfig:
#   git config --global core.excludesfile ~/.gitignore_global
#
# Or combine with language-specific templates in your project .gitignore.

# Windows thumbnail cache files
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db

# Dump file
*.stackdump

# Folder config file
[Dd]esktop.ini

# Recycle Bin used on file shares
$RECYCLE.BIN/

# Windows Installer files
*.cab
*.msi
*.msix
*.msm
*.msp

# Windows shortcuts
*.lnk

# Windows Explorer lock files
~$*

# Windows Search index files
*.search-ms

# Windows security/zone identifier
*:Zone.Identifier
```

**Checksum:** `dbafbdce20bd8814bae52a0d0141e327373f0c3d7c6d4f5ecd6c43470a35a57f`
</details>

---

## Language Presets

### `/github-setup nodejs`

| Template | Destination |
|----------|-------------|
| `workflows/ci-nodejs.yml` | `.github/workflows/ci-nodejs.yml` |
| `workflows/publish-npm.yml` | `.github/workflows/publish-npm.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-nodejs.json` | `.devcontainer/devcontainer.json` |
| `.gitignore-nodejs` | `.gitignore` (merge if exists) |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |
| `.prettierrc` | `.prettierrc` |
| `.eslintrc.json` | `.eslintrc.json` |

### `/github-setup python`

| Template | Destination |
|----------|-------------|
| `workflows/ci-python.yml` | `.github/workflows/ci-python.yml` |
| `workflows/publish-pypi.yml` | `.github/workflows/publish-pypi.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-python.json` | `.devcontainer/devcontainer.json` |
| `.gitignore-python` | `.gitignore` (merge if exists) |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |
| `pyproject.toml` | `pyproject.toml` (merge if exists) |

### `/github-setup go`

| Template | Destination |
|----------|-------------|
| `workflows/ci-go.yml` | `.github/workflows/ci-go.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-go.json` | `.devcontainer/devcontainer.json` |
| `.gitignore-go` | `.gitignore` (merge if exists) |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |

### `/github-setup rust`

| Template | Destination |
|----------|-------------|
| `workflows/ci-rust.yml` | `.github/workflows/ci-rust.yml` |
| `workflows/publish-crates.yml` | `.github/workflows/publish-crates.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-rust.json` | `.devcontainer/devcontainer.json` |
| `.gitignore-rust` | `.gitignore` (merge if exists) |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |

### `/github-setup java`

| Template | Destination |
|----------|-------------|
| `workflows/ci-java.yml` | `.github/workflows/ci-java.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-java.json` | `.devcontainer/devcontainer.json` |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |

### `/github-setup ruby`

| Template | Destination |
|----------|-------------|
| `workflows/ci-ruby.yml` | `.github/workflows/ci-ruby.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-ruby.json` | `.devcontainer/devcontainer.json` |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |

### `/github-setup php`

| Template | Destination |
|----------|-------------|
| `workflows/ci-php.yml` | `.github/workflows/ci-php.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-php.json` | `.devcontainer/devcontainer.json` |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |

### `/github-setup dotnet`

| Template | Destination |
|----------|-------------|
| `workflows/ci-dotnet.yml` | `.github/workflows/ci-dotnet.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.devcontainer/devcontainer-dotnet.json` | `.devcontainer/devcontainer.json` |
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |

---

## Mobile & Infrastructure Presets

### `/github-setup android`

| Template | Destination |
|----------|-------------|
| `workflows/ci-android.yml` | `.github/workflows/ci-android.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Gradle caching, unit tests, instrumented tests with Android Emulator, APK artifact upload.

### `/github-setup ios`

| Template | Destination |
|----------|-------------|
| `workflows/ci-ios.yml` | `.github/workflows/ci-ios.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: xcodebuild, SwiftLint, SPM/CocoaPods caching, multi-iOS version matrix.

### `/github-setup flutter`

| Template | Destination |
|----------|-------------|
| `workflows/ci-flutter.yml` | `.github/workflows/ci-flutter.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Flutter analyze, tests with coverage, multi-platform builds (Android/iOS/Web).

### `/github-setup react-native`

| Template | Destination |
|----------|-------------|
| `workflows/ci-react-native.yml` | `.github/workflows/ci-react-native.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Jest tests, Android/iOS builds, optional Expo and Detox E2E support.

### `/github-setup terraform`

| Template | Destination |
|----------|-------------|
| `workflows/ci-terraform.yml` | `.github/workflows/ci-terraform.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Terraform fmt, validate, tfsec security scanning, optional plan/apply with OIDC authentication.

---

## Category Presets

### `/github-setup docs`

| Template | Destination |
|----------|-------------|
| `CONTRIBUTING.md` | `CONTRIBUTING.md` |
| `RELEASING.md` | `RELEASING.md` |
| `CITATION.cff` | `CITATION.cff` |
| `CLAUDE.md` | `CLAUDE.md` |
| `CODEOWNERS` | `.github/CODEOWNERS` |
| `SECURITY.md` | `SECURITY.md` |

Also create: `README.md`, `LICENSE`, `CHANGELOG.md`, `CODE_OF_CONDUCT.md` (ask user for details).

### `/github-setup quality`

| Template | Destination |
|----------|-------------|
| `workflows/commitlint.yml` | `.github/workflows/commitlint.yml` |
| `workflows/spell-check.yml` | `.github/workflows/spell-check.yml` |
| `workflows/link-checker.yml` | `.github/workflows/link-checker.yml` |
| `workflows/markdown-lint.yml` | `.github/workflows/markdown-lint.yml` |
| `workflows/format-check.yml` | `.github/workflows/format-check.yml` |
| `commitlint.config.js` | `commitlint.config.js` |
| `.cspell.json` | `.cspell.json` |
| `.markdownlint.json` | `.markdownlint.json` |

### `/github-setup security`

| Template | Destination |
|----------|-------------|
| `workflows/dependency-review.yml` | `.github/workflows/dependency-review.yml` |
| `workflows/codeql.yml` | `.github/workflows/codeql.yml` |
| `workflows/trivy.yml` | `.github/workflows/trivy.yml` |
| `workflows/scorecard.yml` | `.github/workflows/scorecard.yml` |
| `workflows/sbom.yml` | `.github/workflows/sbom.yml` |

### `/github-setup releases`

| Template | Destination |
|----------|-------------|
| `workflows/release-please.yml` | `.github/workflows/release-please.yml` |
| `release-please-config.json` | `release-please-config.json` |
| `.release-please-manifest.json` | `.release-please-manifest.json` |

### `/github-setup issues`

| Template | Destination |
|----------|-------------|
| `ISSUE_TEMPLATE/bug_report.md` | `.github/ISSUE_TEMPLATE/bug_report.md` |
| `ISSUE_TEMPLATE/feature_request.md` | `.github/ISSUE_TEMPLATE/feature_request.md` |
| `ISSUE_TEMPLATE/config.yml` | `.github/ISSUE_TEMPLATE/config.yml` |
| `DISCUSSION_TEMPLATE/ideas.yml` | `.github/DISCUSSION_TEMPLATE/ideas.yml` |
| `DISCUSSION_TEMPLATE/q-a.yml` | `.github/DISCUSSION_TEMPLATE/q-a.yml` |
| `PULL_REQUEST_TEMPLATE.md` | `.github/PULL_REQUEST_TEMPLATE.md` |

Also run label creation commands (see Labels section below).

### `/github-setup testing`

| Template | Destination |
|----------|-------------|
| `workflows/e2e-playwright.yml` | `.github/workflows/e2e-playwright.yml` |
| `workflows/e2e-cypress.yml` | `.github/workflows/e2e-cypress.yml` |
| `workflows/lighthouse.yml` | `.github/workflows/lighthouse.yml` |
| `workflows/coverage.yml` | `.github/workflows/coverage.yml` |

### `/github-setup deploy`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-github-pages.yml` | `.github/workflows/deploy-github-pages.yml` |
| `workflows/deploy-vercel.yml` | `.github/workflows/deploy-vercel.yml` |
| `workflows/deploy-netlify.yml` | `.github/workflows/deploy-netlify.yml` |
| `workflows/deploy-railway.yml` | `.github/workflows/deploy-railway.yml` |
| `workflows/deploy-fly.yml` | `.github/workflows/deploy-fly.yml` |
| `workflows/deploy-render.yml` | `.github/workflows/deploy-render.yml` |

### `/github-setup aws`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-aws-s3.yml` | `.github/workflows/deploy-aws-s3.yml` |
| `workflows/deploy-aws-lambda.yml` | `.github/workflows/deploy-aws-lambda.yml` |

### `/github-setup kubernetes`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-kubernetes.yml` | `.github/workflows/deploy-kubernetes.yml` |
| `workflows/publish-docker.yml` | `.github/workflows/publish-docker.yml` |

### `/github-setup precommit`

| Template | Destination |
|----------|-------------|
| `.pre-commit-config.yaml` | `.pre-commit-config.yaml` |

After installing, run:
```bash
pip install pre-commit
pre-commit install
pre-commit install --hook-type commit-msg
```

### `/github-setup notifications`

| Template | Destination |
|----------|-------------|
| `workflows/notify-slack.yml` | `.github/workflows/notify-slack.yml` |
| `workflows/notify-discord.yml` | `.github/workflows/notify-discord.yml` |

### `/github-setup monorepo`

| Template | Destination |
|----------|-------------|
| `turbo.json` | `turbo.json` |
| `pnpm-workspace.yaml` | `pnpm-workspace.yaml` |

### `/github-setup editor`

| Template | Destination |
|----------|-------------|
| `.editorconfig` | `.editorconfig` |
| `.vscode/settings.json` | `.vscode/settings.json` |
| `.vscode/extensions.json` | `.vscode/extensions.json` |

### `/github-setup gitignore`

| Template | Destination |
|----------|-------------|
| `.gitignore-global-macos` | Append to `.gitignore` |
| `.gitignore-global-windows` | Append to `.gitignore` |
| `.gitignore-global-jetbrains` | Append to `.gitignore` |

Plus language-specific template based on detected project type.

### `/github-setup bots`

| Template | Destination |
|----------|-------------|
| `workflows/stale.yml` | `.github/workflows/stale.yml` |
| `workflows/welcome.yml` | `.github/workflows/welcome.yml` |
| `workflows/auto-labeler.yml` | `.github/workflows/auto-labeler.yml` |
| `workflows/all-contributors.yml` | `.github/workflows/all-contributors.yml` |
| `.all-contributorsrc` | `.all-contributorsrc` |

### `/github-setup super-linter`

| Template | Destination |
|----------|-------------|
| `workflows/super-linter.yml` | `.github/workflows/super-linter.yml` |

---

## Additional Language Presets

### `/github-setup cpp`

| Template | Destination |
|----------|-------------|
| `workflows/ci-cpp.yml` | `.github/workflows/ci-cpp.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: CMake, GCC/Clang matrix, sanitizer builds, code coverage.

### `/github-setup kotlin`

| Template | Destination |
|----------|-------------|
| `workflows/ci-kotlin.yml` | `.github/workflows/ci-kotlin.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Gradle, Detekt linting, Kover coverage, multiplatform support.

### `/github-setup swift`

| Template | Destination |
|----------|-------------|
| `workflows/ci-swift.yml` | `.github/workflows/ci-swift.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Swift Package Manager, SwiftLint, macOS/Linux, iOS builds.

### `/github-setup scala`

| Template | Destination |
|----------|-------------|
| `workflows/ci-scala.yml` | `.github/workflows/ci-scala.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: sbt, Scalafmt, Scalafix, scoverage, cross-building.

### `/github-setup elixir`

| Template | Destination |
|----------|-------------|
| `workflows/ci-elixir.yml` | `.github/workflows/ci-elixir.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Mix, Dialyzer, Credo, ExCoveralls, Phoenix support.

---

## Cloud Platform Presets

### `/github-setup azure`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-azure-webapp.yml` | `.github/workflows/deploy-azure-webapp.yml` |
| `workflows/deploy-azure-functions.yml` | `.github/workflows/deploy-azure-functions.yml` |
| `workflows/deploy-azure-container.yml` | `.github/workflows/deploy-azure-container.yml` |

Features: OIDC authentication, App Service, Functions, Container Apps.

### `/github-setup gcp`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-gcp-cloudrun.yml` | `.github/workflows/deploy-gcp-cloudrun.yml` |
| `workflows/deploy-gcp-functions.yml` | `.github/workflows/deploy-gcp-functions.yml` |
| `workflows/deploy-gcp-gke.yml` | `.github/workflows/deploy-gcp-gke.yml` |

Features: Workload Identity, Cloud Run, Cloud Functions, GKE.

### `/github-setup digitalocean`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-digitalocean.yml` | `.github/workflows/deploy-digitalocean.yml` |

Features: App Platform deployment, staging/production environments.

---

## Advanced Deployment Presets

### `/github-setup multienv`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-multi-env.yml` | `.github/workflows/deploy-multi-env.yml` |
| `.env.example` | `.env.example` |

Features: Staging → production promotion, manual approval gates, rollback capability, Slack/Discord notifications.

### `/github-setup database`

| Template | Destination |
|----------|-------------|
| `workflows/ci-with-services.yml` | `.github/workflows/ci-with-services.yml` |

Features: PostgreSQL, MySQL, Redis, MongoDB service containers, database migration testing, health checks.

See also: [`docs/DATABASE_TESTING.md`](https://github.com/domelic/github-repository-setup/blob/main/docs/DATABASE_TESTING.md)

### `/github-setup serverless`

| Template | Destination |
|----------|-------------|
| `workflows/deploy-serverless.yml` | `.github/workflows/deploy-serverless.yml` |
| `workflows/deploy-sam.yml` | `.github/workflows/deploy-sam.yml` |
| `workflows/deploy-pulumi.yml` | `.github/workflows/deploy-pulumi.yml` |

Features: Serverless Framework, AWS SAM, Pulumi IaC deployments with OIDC authentication.

### `/github-setup renovate`

| Template | Destination |
|----------|-------------|
| `renovate.json` | `renovate.json` |

Features: Advanced dependency management with auto-merge, grouping, and scheduling. Alternative to Dependabot.

See also: [`docs/RENOVATE_VS_DEPENDABOT.md`](https://github.com/domelic/github-repository-setup/blob/main/docs/RENOVATE_VS_DEPENDABOT.md)

### `/github-setup observability`

| Template | Destination |
|----------|-------------|
| `workflows/sentry-release.yml` | `.github/workflows/sentry-release.yml` |
| `workflows/datadog-ci.yml` | `.github/workflows/datadog-ci.yml` |
| `otel/otel-collector-config.yaml` | `otel/otel-collector-config.yaml` |
| `otel/docker-compose.otel.yaml` | `otel/docker-compose.otel.yaml` |

Features: Sentry release tracking, Datadog CI visibility, OpenTelemetry collector configuration.

### `/github-setup license`

| Template | Destination |
|----------|-------------|
| `workflows/license-check.yml` | `.github/workflows/license-check.yml` |
| `.licenseignore` | `.licenseignore` |

Features: SPDX license validation, license compatibility checking, blocklist for problematic licenses.

### `/github-setup openapi`

| Template | Destination |
|----------|-------------|
| `openapi/openapi-minimal.yaml` | `openapi/openapi.yaml` |

Or for full example:
| `openapi/openapi-full.yaml` | `openapi/openapi.yaml` |

Features: OpenAPI 3.1 starter specs with authentication, pagination, error handling patterns.

### `/github-setup docker-registry`

| Template | Destination |
|----------|-------------|
| `workflows/publish-docker-ecr.yml` | `.github/workflows/publish-docker-ecr.yml` |
| `workflows/publish-docker-gcr.yml` | `.github/workflows/publish-docker-gcr.yml` |
| `workflows/publish-docker-acr.yml` | `.github/workflows/publish-docker-acr.yml` |
| `workflows/publish-docker-hub.yml` | `.github/workflows/publish-docker-hub.yml` |

Features: AWS ECR, Google GCR/Artifact Registry, Azure ACR, Docker Hub with OIDC authentication.

---

## Git Hooks Presets

### `/github-setup hooks`

For Node.js projects using Husky + lint-staged:

| Template | Destination |
|----------|-------------|
| `.husky/pre-commit` | `.husky/pre-commit` |
| `.husky/commit-msg` | `.husky/commit-msg` |
| `.lintstagedrc` | `.lintstagedrc` |
| `commitlint.config.js` | `commitlint.config.js` |

After installing, run:
```bash
npm install -D husky lint-staged @commitlint/cli @commitlint/config-conventional
npx husky init
```

### `/github-setup lefthook`

For language-agnostic git hooks (no Node.js required):

| Template | Destination |
|----------|-------------|
| `lefthook.yml` | `lefthook.yml` |

After installing, run:
```bash
# macOS
brew install lefthook

# Or with npm
npm install -D lefthook

# Initialize hooks
lefthook install
```

---

## Game Development Presets

### `/github-setup godot`

| Template | Destination |
|----------|-------------|
| `workflows/ci-godot.yml` | `.github/workflows/ci-godot.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Godot 4.x engine exports, multi-platform builds (Windows, Linux, macOS, Web, Android), GDScript linting, asset validation.

### `/github-setup unity`

| Template | Destination |
|----------|-------------|
| `workflows/ci-unity.yml` | `.github/workflows/ci-unity.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: Unity Test Framework (Edit Mode + Play Mode), multi-platform builds, IL2CPP support, GameCI integration.

---

## ML/AI Presets

### `/github-setup ml`

| Template | Destination |
|----------|-------------|
| `workflows/ci-ml-python.yml` | `.github/workflows/ci-ml-python.yml` |
| `dependabot.yml` | `.github/dependabot.yml` |
| `.editorconfig` | `.editorconfig` |

Features: GPU runner support, Jupyter notebook validation, DVC integration, experiment tracking (MLflow/Weights & Biases).

See also: [`docs/ML_PROJECTS.md`](https://github.com/domelic/github-repository-setup/blob/main/docs/ML_PROJECTS.md)

---

## CLI Distribution Presets

### `/github-setup cli-tool`

| Template | Destination |
|----------|-------------|
| `workflows/publish-cli-binaries.yml` | `.github/workflows/publish-cli-binaries.yml` |

Features: Cross-platform compilation (Go, Rust), GitHub Release assets, SHA256 checksums, optional code signing, Homebrew/Scoop formula generation.

---

## Additional Integration Presets

### `/github-setup sonarcloud`

| Template | Destination |
|----------|-------------|
| `workflows/sonarcloud.yml` | `.github/workflows/sonarcloud.yml` |

Features: Code quality analysis, coverage integration, quality gate enforcement, PR decoration with inline comments.

### `/github-setup teams`

| Template | Destination |
|----------|-------------|
| `workflows/notify-teams.yml` | `.github/workflows/notify-teams.yml` |

Features: Microsoft Teams Adaptive Cards, build status notifications, release notifications, deployment status updates.

### `/github-setup snyk`

| Template | Destination |
|----------|-------------|
| `workflows/snyk.yml` | `.github/workflows/snyk.yml` |

Features: Dependency vulnerability scanning, container image scanning, IaC scanning, SARIF integration with GitHub Security.

### `/github-setup loadtest`

| Template | Destination |
|----------|-------------|
| `workflows/load-test-k6.yml` | `.github/workflows/load-test-k6.yml` |

Features: k6 script execution, threshold validation, results as PR comments, optional cloud execution.

### `/github-setup a11y`

| Template | Destination |
|----------|-------------|
| `workflows/a11y.yml` | `.github/workflows/a11y.yml` |

Features: Playwright + axe-core accessibility testing, pa11y-ci URL scanning, WCAG 2.1 AA compliance, PR violation reports, HTML report artifacts.

### `/github-setup api-docs`

| Template | Destination |
|----------|-------------|
| `workflows/api-docs.yml` | `.github/workflows/api-docs.yml` |

Features: Auto-detect documentation type (TypeDoc, OpenAPI/Redocly, Sphinx), GitHub Pages deployment, PR preview comments.

### `/github-setup codecov`

| Template | Destination |
|----------|-------------|
| `workflows/codecov.yml` | `.github/workflows/codecov.yml` |
| `codecov.yml` | `codecov.yml` |

Features: Codecov coverage upload, multi-language support (Node.js, Python, Go, Rust), coverage thresholds (70% project, 80% patch), PR comments with coverage diff.

**Required Secret:** `CODECOV_TOKEN` from https://app.codecov.io/

---

## Editor Presets

### `/github-setup jetbrains`

| Template | Destination |
|----------|-------------|
| `.idea/codeStyles/codeStyleConfig.xml` | `.idea/codeStyles/codeStyleConfig.xml` |
| `.idea/codeStyles/Project.xml` | `.idea/codeStyles/Project.xml` |
| `.idea/inspectionProfiles/Project_Default.xml` | `.idea/inspectionProfiles/Project_Default.xml` |
| `.idea/.gitignore` | `.idea/.gitignore` |

Features: Shared code style (120 char lines, language-specific indentation), team-wide inspection profiles, proper `.gitignore` for local-only files. Works with IntelliJ IDEA, PyCharm, WebStorm, and all JetBrains IDEs.

---

## AI Presets

### `/github-setup ai`

| Template | Destination |
|----------|-------------|
| `.github/copilot-instructions.md` | `.github/copilot-instructions.md` |

Features: Repository-specific GitHub Copilot customization including project context, coding standards, architecture patterns, naming conventions, testing requirements, security guidelines, and anti-patterns to avoid.

---

## Visual Regression Testing Presets

### `/github-setup visual-regression`

Choose based on your needs:

**Percy (Cloud-based, any test framework):**

| Template | Destination |
|----------|-------------|
| `workflows/visual-regression-percy.yml` | `.github/workflows/visual-regression-percy.yml` |

**Required Secret:** `PERCY_TOKEN`

**Chromatic (Storybook-native):**

| Template | Destination |
|----------|-------------|
| `workflows/visual-regression-chromatic.yml` | `.github/workflows/visual-regression-chromatic.yml` |

**Required Secret:** `CHROMATIC_PROJECT_TOKEN`

**BackstopJS (Self-hosted, no external service):**

| Template | Destination |
|----------|-------------|
| `workflows/visual-regression-backstop.yml` | `.github/workflows/visual-regression-backstop.yml` |

Features: PR status checks for visual changes, multi-viewport testing, HTML report artifacts, auto-accept baselines on main branch.

---

## Blockchain/Web3 Presets

### `/github-setup web3`

**Hardhat (JavaScript/TypeScript):**

| Template | Destination |
|----------|-------------|
| `workflows/ci-hardhat.yml` | `.github/workflows/ci-hardhat.yml` |
| `workflows/deploy-contract.yml` | `.github/workflows/deploy-contract.yml` |
| `.gitignore-solidity` | `.gitignore` (merge if exists) |

Features: Solidity compilation, Hardhat tests with gas reporting, Slither security analysis, coverage with Codecov, contract size checks.

**Foundry (Rust-based, faster):**

| Template | Destination |
|----------|-------------|
| `workflows/ci-foundry.yml` | `.github/workflows/ci-foundry.yml` |
| `workflows/deploy-contract.yml` | `.github/workflows/deploy-contract.yml` |
| `.gitignore-solidity` | `.gitignore` (merge if exists) |

Features: Forge build/test, fuzz testing, invariant testing, gas snapshots, Slither security analysis.

**Required Secrets for deployment:**
- `DEPLOYER_PRIVATE_KEY` - Deployment wallet private key
- `ETHERSCAN_API_KEY` - For contract verification (or `POLYGONSCAN_API_KEY`, `ARBISCAN_API_KEY`, etc.)
- `*_RPC_URL` - RPC endpoint for each network (e.g., `MAINNET_RPC_URL`, `SEPOLIA_RPC_URL`)

---

## Browser Extension Presets

### `/github-setup browser-extension`

| Template | Destination |
|----------|-------------|
| `workflows/ci-browser-extension.yml` | `.github/workflows/ci-browser-extension.yml` |
| `workflows/publish-chrome-extension.yml` | `.github/workflows/publish-chrome-extension.yml` |
| `workflows/publish-firefox-addon.yml` | `.github/workflows/publish-firefox-addon.yml` |

Features: Multi-browser builds (Chrome, Firefox), E2E testing with Playwright, automated store publishing.

**Required Secrets (Chrome Web Store):**
- `CHROME_EXTENSION_ID` - Your extension's ID
- `CHROME_CLIENT_ID` - OAuth2 client ID
- `CHROME_CLIENT_SECRET` - OAuth2 client secret
- `CHROME_REFRESH_TOKEN` - OAuth2 refresh token

**Required Secrets (Firefox Add-ons):**
- `FIREFOX_EXTENSION_ID` - Your add-on's ID (UUID or slug)
- `FIREFOX_JWT_ISSUER` - AMO API key
- `FIREFOX_JWT_SECRET` - AMO API secret

---

## Desktop Application Presets

### `/github-setup electron`

| Template | Destination |
|----------|-------------|
| `workflows/ci-electron.yml` | `.github/workflows/ci-electron.yml` |
| `workflows/publish-electron.yml` | `.github/workflows/publish-electron.yml` |

Features: Cross-platform builds (Windows, macOS, Linux), code signing, Apple notarization, auto-update support, security scanning.

**Required Secrets (macOS code signing):**
- `APPLE_ID` - Apple Developer account email
- `APPLE_APP_SPECIFIC_PASSWORD` - App-specific password for notarization
- `APPLE_TEAM_ID` - Apple Developer Team ID
- `CSC_LINK` - Base64-encoded .p12 certificate
- `CSC_KEY_PASSWORD` - Certificate password

**Required Secrets (Windows code signing):**
- `WINDOWS_CSC_LINK` - Base64-encoded .pfx certificate
- `WINDOWS_CSC_KEY_PASSWORD` - Certificate password

---

## Embedded/IoT Presets

### `/github-setup embedded`

| Template | Destination |
|----------|-------------|
| `workflows/ci-platformio.yml` | `.github/workflows/ci-platformio.yml` |
| `workflows/release-firmware.yml` | `.github/workflows/release-firmware.yml` |

Features: Multi-board firmware builds (ESP32, ESP8266, Teensy, STM32, Arduino), code quality checks (cppcheck), unit testing with native environment, memory usage analysis, OTA update support.

**Supported Boards:**
- ESP32, ESP8266 (Espressif)
- Teensy 4.x (PJRC)
- STM32 (various)
- Arduino (Uno, Mega, etc.)

---

## Mobile Publishing Presets

### `/github-setup mobile-publish`

| Template | Destination |
|----------|-------------|
| `workflows/publish-play-store.yml` | `.github/workflows/publish-play-store.yml` |
| `workflows/publish-testflight.yml` | `.github/workflows/publish-testflight.yml` |

Features: Fastlane integration, Google Play Store (internal/alpha/beta/production tracks), TestFlight beta distribution, App Store submission, AAB signing, code signing with App Store Connect API.

**Required Secrets (Play Store):**
- `PLAY_STORE_SERVICE_ACCOUNT_JSON` - Google Cloud service account (base64)
- `ANDROID_KEYSTORE_BASE64` - Signing keystore (base64)
- `ANDROID_KEYSTORE_PASSWORD` - Keystore password
- `ANDROID_KEY_ALIAS` - Key alias
- `ANDROID_KEY_PASSWORD` - Key password

**Required Secrets (TestFlight/App Store):**
- `APP_STORE_CONNECT_API_KEY_ID` - API key ID
- `APP_STORE_CONNECT_API_ISSUER_ID` - Issuer ID
- `APP_STORE_CONNECT_API_KEY_BASE64` - API key content (base64)
- `CERTIFICATE_BASE64` - Distribution certificate (base64)
- `CERTIFICATE_PASSWORD` - Certificate password
- `PROVISIONING_PROFILE_BASE64` - Provisioning profile (base64)

---

## Performance Monitoring Presets

### `/github-setup bundle-size`

| Template | Destination |
|----------|-------------|
| `workflows/bundle-size.yml` | `.github/workflows/bundle-size.yml` |

Features: Track JS/CSS bundle sizes with size-limit or bundlewatch, compare against main branch baseline, fail PR if size increases beyond threshold, PR comment with size comparison table, tree-shaking analysis.

**Configuration:**
Create `.size-limit.json` or add `"size-limit"` section to `package.json`:
```json
[
  { "path": "dist/index.js", "limit": "50 KB" },
  { "path": "dist/index.css", "limit": "10 KB" }
]
```

---

## Dynamic Security Testing Presets

### `/github-setup dast`

| Template | Destination |
|----------|-------------|
| `workflows/dast-zap.yml` | `.github/workflows/dast-zap.yml` |

Features: OWASP ZAP dynamic application security testing, baseline scan (quick, ~5 min), full scan (comprehensive, ~30+ min), API scan (OpenAPI-based), SARIF output for GitHub Security tab, HTML report artifacts.

**Scan Modes:**
- `baseline` - Quick passive scan, safe for production
- `full` - Active scanning with spider, NOT safe for production
- `api` - OpenAPI specification-based scanning

**Configuration:**
Create `.zap/rules.tsv` to ignore false positives:
```text
10015  IGNORE  (Incomplete or No Cache-control Header Set)
10037  IGNORE  (Server Leaks Information via X-Powered-By)
```

---

## Contract Testing Presets

### `/github-setup contract-testing`

| Template | Destination |
|----------|-------------|
| `workflows/contract-pact.yml` | `.github/workflows/contract-pact.yml` |

Features: Pact consumer-driven contract testing, consumer contract generation, provider verification, Pact Broker/Pactflow integration, can-i-deploy safety checks, webhook triggers for provider changes.

**Required Secrets:**
- `PACT_BROKER_URL` - Pact Broker base URL
- `PACT_BROKER_TOKEN` - API token (or use `PACT_BROKER_USERNAME`/`PACT_BROKER_PASSWORD`)

**Use Cases:**
- Verify API compatibility between microservices
- Prevent breaking changes without integration tests
- Enable independent service deployment

---

## Documentation Publishing Presets

### `/github-setup storybook`

| Template | Destination |
|----------|-------------|
| `workflows/storybook-publish.yml` | `.github/workflows/storybook-publish.yml` |

Features: Build Storybook on PR and push, deploy to GitHub Pages (default), PR comment with preview link, only rebuild on component changes, optional Chromatic integration, S3/CloudFront deployment support.

**Deployment Options:**
- GitHub Pages (free, default)
- S3 + CloudFront
- Netlify/Vercel

**Optional Secrets (for Chromatic):**
- `CHROMATIC_PROJECT_TOKEN` - Chromatic project token

---

## Full Setup (`/github-setup`)

### 1. Detect Project Type

```bash
if [ -f "package.json" ]; then PROJECT_TYPE="nodejs"
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then PROJECT_TYPE="python"
elif [ -f "go.mod" ]; then PROJECT_TYPE="go"
elif [ -f "Cargo.toml" ]; then PROJECT_TYPE="rust"
elif [ -f "pom.xml" ] || [ -f "build.gradle" ]; then PROJECT_TYPE="java"
elif [ -f "Gemfile" ]; then PROJECT_TYPE="ruby"
elif [ -f "composer.json" ]; then PROJECT_TYPE="php"
elif ls *.csproj *.sln 2>/dev/null; then PROJECT_TYPE="dotnet"
else PROJECT_TYPE="generic"
fi
```

### 2. Run Checklist

Audit what exists vs what's missing (see Checklist section).

### 3. Apply in Order

1. **docs** - README, LICENSE, CONTRIBUTING
2. **editor** - .editorconfig, .vscode/
3. **protection** - Branch protection, CODEOWNERS
4. **issues** - Templates, labels
5. **quality** - Linting workflows
6. **{language}** - Language-specific CI
7. **releases** - Release Please
8. **bots** - Stale, welcome, auto-labeler

Ask user before each category.

---

## Checklist (`/github-setup checklist`)

Check for existence of these files/settings:

### Documentation
- [ ] `README.md` with badges
- [ ] `LICENSE`
- [ ] `CONTRIBUTING.md`
- [ ] `CHANGELOG.md`
- [ ] `CLAUDE.md`
- [ ] `SECURITY.md`

### Editor
- [ ] `.editorconfig`
- [ ] `.vscode/settings.json`
- [ ] `.vscode/extensions.json`

### Branch Protection
- [ ] Protection enabled on main
- [ ] `.github/CODEOWNERS`
- [ ] Auto-delete branches enabled

### Issues & PRs
- [ ] `.github/ISSUE_TEMPLATE/`
- [ ] `.github/PULL_REQUEST_TEMPLATE.md`
- [ ] Labels configured
- [ ] Discussions enabled

### Quality
- [ ] `.github/workflows/commitlint.yml`
- [ ] `.github/workflows/spell-check.yml`
- [ ] `.github/workflows/markdown-lint.yml`
- [ ] `.pre-commit-config.yaml`

### CI/CD
- [ ] Language-specific CI workflow
- [ ] `.github/dependabot.yml`
- [ ] `.github/workflows/stale.yml`

### Releases
- [ ] `.github/workflows/release-please.yml`

### Security
- [ ] `.github/workflows/dependency-review.yml`
- [ ] `.github/workflows/license-check.yml`
- [ ] `.github/workflows/secrets-rotation.yml`

### Advanced
- [ ] `.github/workflows/deploy-multi-env.yml` (multi-environment deployment)
- [ ] `.github/workflows/ci-with-services.yml` (database testing)
- [ ] `renovate.json` (alternative to Dependabot)
- [ ] OpenAPI specification in `openapi/`
- [ ] Observability integration (Sentry/Datadog/OpenTelemetry)

### Additional Integrations
- [ ] `.github/workflows/sonarcloud.yml` (code quality)
- [ ] `.github/workflows/snyk.yml` (security scanning)
- [ ] `.github/workflows/notify-teams.yml` (Teams notifications)
- [ ] `.github/workflows/load-test-k6.yml` (load testing)
- [ ] `.github/workflows/a11y.yml` (accessibility testing)
- [ ] `.github/workflows/api-docs.yml` (API documentation)
- [ ] `.github/workflows/codecov.yml` + `codecov.yml` (coverage tracking)

### Testing & Security
- [ ] `.github/workflows/contract-pact.yml` (Pact contract testing)
- [ ] `.github/workflows/dast-zap.yml` (OWASP ZAP dynamic security)

### Performance
- [ ] `.github/workflows/bundle-size.yml` (JS/CSS bundle monitoring)

### Mobile Publishing
- [ ] `.github/workflows/publish-play-store.yml` (Android Play Store)
- [ ] `.github/workflows/publish-testflight.yml` (iOS TestFlight/App Store)

### Documentation Publishing
- [ ] `.github/workflows/storybook-publish.yml` (Storybook component docs)

### Specialized Domains
- [ ] `.github/workflows/ci-godot.yml` (Godot game development)
- [ ] `.github/workflows/ci-unity.yml` (Unity game development)
- [ ] `.github/workflows/ci-ml-python.yml` (ML/AI projects)
- [ ] `.github/workflows/publish-cli-binaries.yml` (CLI distribution)
- [ ] `.github/workflows/ci-hardhat.yml` or `ci-foundry.yml` (Web3/Blockchain)
- [ ] `.github/workflows/ci-browser-extension.yml` (Browser extensions)
- [ ] `.github/workflows/ci-electron.yml` (Desktop applications)
- [ ] `.github/workflows/ci-platformio.yml` (Embedded/IoT)

### Editor & AI Integrations
- [ ] `.github/copilot-instructions.md` (AI consistency)
- [ ] `.idea/` shareable configurations (JetBrains IDE)
- [ ] Visual regression testing workflows (Percy/Chromatic/BackstopJS)

Report missing items grouped by priority: Essential -> Recommended -> Optional.

---

## Labels

Create standard labels:

```bash
gh label create "bug" -c "d73a4a" -d "Something isn't working"
gh label create "enhancement" -c "a2eeef" -d "New feature or request"
gh label create "documentation" -c "0075ca" -d "Documentation improvements"
gh label create "good first issue" -c "7057ff" -d "Good for newcomers"
gh label create "help wanted" -c "008672" -d "Extra attention needed"
gh label create "dependencies" -c "0366d6" -d "Dependency updates"
gh label create "github-actions" -c "000000" -d "CI/CD changes"
gh label create "stale" -c "ededed" -d "Inactive issue/PR"
gh label create "pinned" -c "006b75" -d "Exempt from stale bot"
gh label create "in-progress" -c "0e8a16" -d "Work in progress"
gh label create "chore" -c "fef2c0" -d "Maintenance tasks"
gh label create "testing" -c "bfd4f2" -d "Test improvements"
gh label create "refactor" -c "d4c5f9" -d "Code refactoring"
gh label create "performance" -c "f9d0c4" -d "Performance improvements"
```

---

## Branch Protection

```bash
# Enable branch protection
gh api repos/{owner}/{repo}/branches/main/protection -X PUT --input - <<'EOF'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 0 },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF

# Enable auto-delete merged branches
gh api repos/{owner}/{repo} -X PATCH -f delete_branch_on_merge=true

# Enable discussions
gh api repos/{owner}/{repo} -X PATCH -f has_discussions=true
```

---

## Fetching Templates

### Using curl

```bash
VERSION="v0.1.21"
BASE_URL="https://raw.githubusercontent.com/domelic/github-repository-setup/$VERSION/templates"

# Example: Fetch Node.js CI workflow
mkdir -p .github/workflows
curl -o .github/workflows/ci-nodejs.yml "$BASE_URL/workflows/ci-nodejs.yml"

# Verify checksum
EXPECTED="4777f47f972857aec2a8944cca3bcd0a11c6c63231b25f94b069f85463b88b70"
ACTUAL=$(shasum -a 256 .github/workflows/ci-nodejs.yml | cut -d' ' -f1)
if [ "$EXPECTED" = "$ACTUAL" ]; then
  echo "Checksum verified"
else
  echo "WARNING: Checksum mismatch!"
fi
```

### Using WebFetch (Claude Code)

Fetch template content with WebFetch, then write to destination with the Write tool.

### Customization

After fetching, customize templates:
- Replace `OWNER/REPO` with actual repository
- Update project-specific values
- Remove unused optional sections

---

## Reference

Full documentation: https://github.com/domelic/github-repository-setup

Template directory: https://github.com/domelic/github-repository-setup/tree/main/templates

Checksums manifest: `templates/checksums.json` (available in v0.1.21+)

### Discoverability Resources

| Resource | Purpose |
|----------|---------|
| [Workflow Diagrams](https://github.com/domelic/github-repository-setup/blob/main/docs/WORKFLOW_DIAGRAMS.md) | Visual Mermaid diagrams showing workflow chains and dependencies |
| [Compatibility Matrix](https://github.com/domelic/github-repository-setup/blob/main/docs/COMPATIBILITY_MATRIX.md) | Which presets work together, conflicts, and recommended stacks |
| [Workflow Metadata](https://github.com/domelic/github-repository-setup/blob/main/templates/workflows/workflow-metadata.yaml) | Structured data index for all 113 workflows |
| [Workflow README](https://github.com/domelic/github-repository-setup/blob/main/templates/workflows/README.md) | Quick reference tables with triggers, secrets, and complexity |
