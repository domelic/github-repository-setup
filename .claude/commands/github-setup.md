# GitHub Repository Setup Skill

Set up GitHub repositories with production-grade automation by fetching templates from the [github-repository-setup](https://github.com/domelic/github-repository-setup) repository.

## Usage

```bash
/github-setup                    # Full setup wizard (auto-detects project type)
/github-setup checklist          # Audit what's missing
/github-setup <preset>           # Apply a specific preset
```

---

## Template Source

**Pinned Version:** `v0.1.19`

**Base URL:** `https://raw.githubusercontent.com/domelic/github-repository-setup/v0.1.19/templates/`

All templates are fetched from this pinned release. This ensures stability - templates won't change unexpectedly.

### Upgrading to a New Version

To use a newer version, update the version in the Base URL (e.g., `v0.1.14`). Check the [releases page](https://github.com/domelic/github-repository-setup/releases) for available versions.

---

## Integrity Verification

Templates include SHA-256 checksums for integrity verification.

### Checksum Manifest

Fetch the checksums file:
```bash
VERSION="v0.1.19"  # Update to match pinned version
curl -s "https://raw.githubusercontent.com/domelic/github-repository-setup/$VERSION/templates/checksums.json"
```

### Verification Process

After fetching a template, verify its integrity:

```bash
# Fetch template
curl -o .editorconfig "https://raw.githubusercontent.com/domelic/github-repository-setup/v0.1.19/templates/.editorconfig"

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
VERSION="v0.1.19"
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

Checksums manifest: `templates/checksums.json` (available in v0.1.19+)
