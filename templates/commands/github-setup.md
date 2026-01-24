# GitHub Repository Setup Skill

Set up GitHub repositories with production-grade automation, quality gates, and best practices.

## Usage

```bash
/github-setup                    # Full setup wizard (auto-detects project type)
/github-setup docs               # Documentation files
/github-setup protection         # Branch protection + CODEOWNERS
/github-setup issues             # Templates, labels, Discussions
/github-setup quality            # Commitlint, spell check, link checker, markdown lint
/github-setup releases           # Release Please automation
/github-setup automation         # All GitHub Actions workflows
/github-setup publishing         # Amazon KDP automation (for books)
/github-setup discovery          # Topics, social preview, funding
/github-setup checklist          # Audit what's missing
```

### Language Presets

```bash
/github-setup nodejs             # Node.js/TypeScript preset
/github-setup python             # Python preset
/github-setup go                 # Go preset
/github-setup rust               # Rust preset
/github-setup java               # Java preset (Maven/Gradle)
/github-setup ruby               # Ruby preset
/github-setup php                # PHP preset (Composer)
/github-setup dotnet             # .NET preset
```

### Category Presets

```bash
/github-setup ci                 # CI workflows only
/github-setup security           # Security workflows only
/github-setup deploy             # Deployment workflows only
/github-setup devcontainer       # Dev container setup
/github-setup editor             # Editor config (.editorconfig, VSCode)
/github-setup gitignore          # Language-specific .gitignore
```

---

## Project Auto-Detection

When running `/github-setup` without arguments, automatically detect the project type:

### Detection Logic

| File Present | Project Type | Preset Applied |
|--------------|--------------|----------------|
| `package.json` | Node.js/TypeScript | `nodejs` |
| `pyproject.toml` or `requirements.txt` or `setup.py` | Python | `python` |
| `go.mod` | Go | `go` |
| `Cargo.toml` | Rust | `rust` |
| `pom.xml` or `build.gradle` | Java | `java` |
| `Gemfile` | Ruby | `ruby` |
| `composer.json` | PHP | `php` |
| `*.csproj` or `*.fsproj` or `*.sln` | .NET | `dotnet` |

### Auto-Detection Implementation

```bash
# Check for project type
if [ -f "package.json" ]; then
    PROJECT_TYPE="nodejs"
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
    PROJECT_TYPE="python"
elif [ -f "go.mod" ]; then
    PROJECT_TYPE="go"
elif [ -f "Cargo.toml" ]; then
    PROJECT_TYPE="rust"
elif [ -f "pom.xml" ] || [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
    PROJECT_TYPE="java"
elif [ -f "Gemfile" ]; then
    PROJECT_TYPE="ruby"
elif [ -f "composer.json" ]; then
    PROJECT_TYPE="php"
elif ls *.csproj >/dev/null 2>&1 || ls *.fsproj >/dev/null 2>&1 || ls *.sln >/dev/null 2>&1; then
    PROJECT_TYPE="dotnet"
else
    PROJECT_TYPE="generic"
fi
```

---

## Mode: Full Setup (`/github-setup`)

Assess the repository and implement all missing components:

1. **Detect project type** — Auto-detect or ask user
2. **Audit current state** — Check what exists
3. **Prioritize by impact** — Essential → Recommended → Optional
4. **Implement incrementally** — One category at a time
5. **Verify each step** — Confirm before proceeding

### Implementation Order

1. Documentation (README, LICENSE, CONTRIBUTING)
2. Editor configs (.editorconfig, .vscode/)
3. Branch protection + CODEOWNERS
4. Issue templates + labels
5. Quality gates (commitlint, linting)
6. Language-specific CI workflow
7. Release automation
8. Publishing workflow (if applicable)
9. Dev container setup
10. Discovery (topics, social preview)

---

## Language Preset: Node.js (`/github-setup nodejs`)

Installs the complete Node.js development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-nodejs.yml` | CI with Node.js 18, 20, 22 matrix |
| `.github/workflows/publish-npm.yml` | npm publishing on release |
| `.github/dependabot.yml` | npm + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | Node.js dev container |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with Codecov
- Format check workflow (Prettier, ESLint)
- Deployment to Vercel/Netlify

---

## Language Preset: Python (`/github-setup python`)

Installs the complete Python development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-python.yml` | CI with Python 3.10, 3.11, 3.12 matrix |
| `.github/workflows/publish-pypi.yml` | PyPI publishing (OIDC) on release |
| `.github/dependabot.yml` | pip + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | Python dev container |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings (black, ruff, isort) |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with Codecov
- Format check workflow (ruff, black, isort)
- Type checking with mypy

---

## Language Preset: Go (`/github-setup go`)

Installs the complete Go development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-go.yml` | CI with Go 1.21, 1.22 matrix |
| `.github/dependabot.yml` | gomod + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | Go dev container |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings (gofmt, golangci-lint) |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with Codecov
- Format check workflow (gofmt, go vet)
- golangci-lint configuration

---

## Language Preset: Rust (`/github-setup rust`)

Installs the complete Rust development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-rust.yml` | CI with stable, nightly, MSRV matrix |
| `.github/workflows/publish-crates.yml` | crates.io publishing on release |
| `.github/dependabot.yml` | cargo + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | Rust dev container |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings (rust-analyzer, clippy) |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with cargo-tarpaulin
- Format check workflow (rustfmt, clippy)
- Documentation workflow

---

## Language Preset: Java (`/github-setup java`)

Installs the complete Java development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-java.yml` | CI with JDK 17, 21 matrix (Maven/Gradle) |
| `.github/dependabot.yml` | maven/gradle + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | Java dev container (JDK 21) |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with JaCoCo
- CodeQL security scanning
- Checkstyle/SpotBugs linting

---

## Language Preset: Ruby (`/github-setup ruby`)

Installs the complete Ruby development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-ruby.yml` | CI with Ruby 3.2, 3.3 matrix |
| `.github/dependabot.yml` | bundler + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | Ruby dev container (3.3) |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings (RuboCop, Solargraph) |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with SimpleCov
- RuboCop linting workflow
- Rails-specific templates

---

## Language Preset: PHP (`/github-setup php`)

Installs the complete PHP development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-php.yml` | CI with PHP 8.2, 8.3 matrix |
| `.github/dependabot.yml` | composer + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | PHP dev container (8.3) |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings (Intelephense, PHP-CS-Fixer) |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with PHPUnit
- PHP-CS-Fixer/PHPStan workflow
- Laravel/Symfony-specific templates

---

## Language Preset: .NET (`/github-setup dotnet`)

Installs the complete .NET development setup:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/ci-dotnet.yml` | CI with .NET 8, 9 matrix |
| `.github/dependabot.yml` | nuget + GitHub Actions updates |
| `.devcontainer/devcontainer.json` | .NET dev container (8.0) |
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode settings (OmniSharp) |
| `.vscode/extensions.json` | Recommended extensions |

### Optional Add-ons

- Coverage workflow with Coverlet
- Format check workflow (dotnet format)
- NuGet publishing workflow

---

## Category Preset: CI (`/github-setup ci`)

Install CI workflows without publishing:

### Available Workflows

| Workflow | Languages |
|----------|-----------|
| `ci-nodejs.yml` | Node.js 18, 20, 22 |
| `ci-python.yml` | Python 3.10, 3.11, 3.12 |
| `ci-go.yml` | Go 1.21, 1.22 |
| `ci-rust.yml` | Rust stable, nightly |
| `ci-java.yml` | Java 17, 21 (Maven/Gradle) |
| `ci-ruby.yml` | Ruby 3.2, 3.3 |
| `ci-php.yml` | PHP 8.2, 8.3 |
| `ci-dotnet.yml` | .NET 8, 9 |

### Shared Features

All CI workflows include:
- Matrix builds across versions
- Concurrency control (cancel in-progress)
- Linting and formatting checks
- Test execution
- Build verification

---

## Category Preset: Security (`/github-setup security`)

Install security-focused workflows:

### Files Installed

| File | Purpose |
|------|---------|
| `.github/workflows/dependency-review.yml` | PR dependency vulnerability check |
| `.github/workflows/codeql.yml` | CodeQL SAST scanning |
| `.github/workflows/trivy.yml` | Container/filesystem vulnerability scanning |
| `.github/workflows/scorecard.yml` | OpenSSF Scorecard supply chain security |
| `.github/workflows/sbom.yml` | SBOM generation with Syft |
| `.github/dependabot.yml` | Automated dependency updates |

### CodeQL Features

- Weekly scheduled scans + PR checks
- Multi-language support (JS, Python, Java, C#, Go, Ruby)
- Results in GitHub Security tab
- Custom queries support

### Trivy Features

- Filesystem vulnerability scanning
- Container image scanning (optional)
- IaC configuration scanning (optional)
- SARIF output for GitHub integration

### Scorecard Features

- Supply chain security assessment
- OpenSSF badge eligibility
- Automated weekly checks
- Actionable security recommendations

### SBOM Features

- SPDX and CycloneDX format generation
- Automatic attachment to releases
- Optional Grype vulnerability scanning

---

## Category Preset: Deploy (`/github-setup deploy`)

Install deployment workflows:

### Available Deployments

| Workflow | Platform |
|----------|----------|
| `deploy-github-pages.yml` | GitHub Pages |
| `deploy-vercel.yml` | Vercel |
| `deploy-netlify.yml` | Netlify |

### Features

- Preview deployments on PRs
- Production deployments on merge to main
- Automatic PR comments with preview URLs

---

## Category Preset: Dev Container (`/github-setup devcontainer`)

Set up development containers for consistent environments:

### Available Containers

| File | Language | Base Image |
|------|----------|------------|
| `devcontainer.json` | Generic | Ubuntu base |
| `devcontainer-nodejs.json` | Node.js | Node 22 |
| `devcontainer-python.json` | Python | Python 3.12 |
| `devcontainer-go.json` | Go | Go 1.22 |
| `devcontainer-rust.json` | Rust | Rust latest |
| `devcontainer-java.json` | Java | JDK 21 |
| `devcontainer-ruby.json` | Ruby | Ruby 3.3 |
| `devcontainer-php.json` | PHP | PHP 8.3 |
| `devcontainer-dotnet.json` | .NET | .NET 8 |

### Features Included

- Common utilities (zsh, Oh My Zsh, git, GitHub CLI)
- Language-specific tools and extensions
- VS Code extensions pre-installed
- Port forwarding configured

---

## Category Preset: Editor Config (`/github-setup editor`)

Set up editor configuration files:

### Files Installed

| File | Purpose |
|------|---------|
| `.editorconfig` | Universal formatting rules |
| `.vscode/settings.json` | VSCode workspace settings |
| `.vscode/extensions.json` | Recommended extensions |
| `.prettierrc` | Prettier config (JS/TS) |
| `.eslintrc.json` | ESLint config (JS/TS) |
| `tsconfig.json` | TypeScript config |
| `pyproject.toml` | Python tooling config (ruff, mypy, pytest) |

### Language-Specific Formatters

| Language | Formatter |
|----------|-----------|
| JavaScript/TypeScript | Prettier |
| Python | Black + Ruff |
| Go | gofmt |
| Rust | rustfmt |
| Java | Google Java Format |
| PHP | PHP-CS-Fixer |
| Ruby | RuboCop |
| C# | dotnet format |

---

## Category Preset: Gitignore (`/github-setup gitignore`)

Install language-specific .gitignore files:

### Available Templates

| File | Language |
|------|----------|
| `.gitignore-nodejs` | Node.js (node_modules, dist, .env) |
| `.gitignore-python` | Python (__pycache__, .venv, .egg-info) |
| `.gitignore-go` | Go (vendor, binaries) |
| `.gitignore-rust` | Rust (target/, Cargo.lock for libs) |

### Usage

Copy and rename to `.gitignore`:

```bash
cp templates/.gitignore-nodejs .gitignore
```

Or merge with existing .gitignore.

---

## Mode: Documentation (`/github-setup docs`)

Create essential documentation files:

### Required
- [ ] `README.md` — Project overview, installation, usage, badges
- [ ] `LICENSE` — Choose appropriate license (MIT, Apache 2.0, etc.)
- [ ] `CONTRIBUTING.md` — Contribution guidelines + commit conventions
- [ ] `CHANGELOG.md` — Version history (or let Release Please manage it)

### Recommended
- [ ] `CODE_OF_CONDUCT.md` — Community guidelines (Contributor Covenant)
- [ ] `RELEASING.md` — Release process documentation
- [ ] `CITATION.cff` — For academic/citable projects

### Ask User
- What license? (MIT, Apache 2.0, GPL, proprietary)
- Is this citable? (needs CITATION.cff)
- Team or solo project? (affects CODE_OF_CONDUCT need)

---

## Mode: Branch Protection (`/github-setup protection`)

Configure branch protection, code ownership, and repository settings:

### Branch Protection

```bash
gh api repos/OWNER/REPO/branches/main/protection -X PUT --input - <<'EOF'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 0
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF
```

### Auto-Delete Merged Branches

Enable automatic deletion of branches after PR merge:

```bash
gh api repos/OWNER/REPO -X PATCH -f delete_branch_on_merge=true
```

### Automated Setup Script

Use `templates/scripts/setup-branch-protection.sh`:

```bash
./setup-branch-protection.sh owner/repo main
```

### Branch Naming Convention

When creating branches, use prefixes matching conventional commit types:

| Type | Branch Prefix | Example |
|------|---------------|---------|
| `feat` | `feat/` | `feat/user-authentication` |
| `fix` | `fix/` | `fix/memory-leak` |
| `docs` | `docs/` | `docs/api-guide` |
| `chore` | `chore/` | `chore/update-deps` |
| `ci` | `ci/` | `ci/add-workflow` |
| `refactor` | `refactor/` | `refactor/parser-logic` |

**Rules:** lowercase, hyphens between words, concise but descriptive

### CODEOWNERS

Create `.github/CODEOWNERS`:

```text
* @username
```

### Settings by Team Size

| Setting | Solo | Team |
|---------|------|------|
| PRs required | Yes | Yes |
| Approvals | 0 | 1+ |
| CODEOWNERS | Optional | Yes |

---

## Mode: Issue Management (`/github-setup issues`)

Set up issue templates, labels, and discussions:

### Issue Templates

Create in `.github/ISSUE_TEMPLATE/`:
- `bug_report.md`
- `feature_request.md`
- `config.yml`

### Discussion Templates

Create in `.github/DISCUSSION_TEMPLATE/`:
- `ideas.yml`
- `q-a.yml`

### Labels

```bash
# Create essential labels
gh label create "bug" -c "d73a4a" -d "Something isn't working"
gh label create "enhancement" -c "a2eeef" -d "New feature"
gh label create "documentation" -c "0075ca" -d "Documentation"
gh label create "good first issue" -c "7057ff" -d "Good for newcomers"
gh label create "help wanted" -c "008672" -d "Extra attention needed"
gh label create "stale" -c "ededed" -d "Inactive"
gh label create "pinned" -c "006b75" -d "Exempt from stale bot"
gh label create "in-progress" -c "0e8a16" -d "Work in progress"
gh label create "dependencies" -c "0366d6" -d "Dependency updates"
```

### Enable Discussions

```bash
gh api repos/OWNER/REPO -X PATCH -f has_discussions=true
```

### PR Template

Create `.github/PULL_REQUEST_TEMPLATE.md` with checklist.

---

## Mode: Quality Gates (`/github-setup quality`)

Set up code quality workflows:

### 1. Commitlint

Enforces conventional commits (`feat:`, `fix:`, etc.)

**Files:**
- `.github/workflows/commitlint.yml`
- `commitlint.config.js`

### 2. Spell Check

**Files:**
- `.github/workflows/spell-check.yml`
- `.cspell.json` (custom dictionary)

### 3. Link Checker

**Files:**
- `.github/workflows/link-checker.yml`

Features: Weekly scan, auto-creates issue on failure.

### 4. Markdown Lint

**Files:**
- `.github/workflows/markdown-lint.yml`
- `.markdownlint.json`

### 5. Format Check (Multi-language)

**Files:**
- `.github/workflows/format-check.yml`

Features: Auto-detects project type, runs appropriate formatters.

---

## Mode: Release Automation (`/github-setup releases`)

Set up automated releases with Release Please:

### Files

- `.github/workflows/release-please.yml`
- `release-please-config.json`
- `.release-please-manifest.json`

### How It Works

```text
feat: add feature → Push → Release PR created → Merge → Release published
```

| Commit | Version Bump |
|--------|--------------|
| `feat:` | Minor |
| `fix:` | Patch |
| `feat!:` | Major |

### Alternative: Manual Releases

Use `.github/workflows/release-manual.yml` for tag-triggered releases.

---

## Mode: Automation (`/github-setup automation`)

Set up all GitHub Actions:

### Workflows to Create

1. **release-please.yml** — Auto-releases
2. **commitlint.yml** — Commit validation
3. **spell-check.yml** — Spelling
4. **link-checker.yml** — Link validation
5. **markdown-lint.yml** — Markdown style
6. **stale.yml** — Inactive issue management
7. **welcome.yml** — First-time contributor greeting
8. **ci.yml** — Build and test (customize per project)
9. **dependency-review.yml** — PR vulnerability check
10. **format-check.yml** — Multi-language formatting
11. **coverage.yml** — Test coverage upload

### Dependabot

Create `.github/dependabot.yml` for auto-updating Actions.

For full ecosystem coverage, use `dependabot-full.yml`.

---

## Mode: Publishing (`/github-setup publishing`)

Set up publishing workflows:

### Package Registries

| Workflow | Registry |
|----------|----------|
| `publish-npm.yml` | npm (with provenance) |
| `publish-pypi.yml` | PyPI (OIDC) |
| `publish-crates.yml` | crates.io |
| `publish-docker.yml` | GHCR + Docker Hub |

### Amazon KDP (Books)

**Workflow:** `.github/workflows/amazon-kdp-publish.yml`

**What it does:**
1. Builds EPUB from source (LaTeX/Markdown) using Pandoc
2. Attaches EPUB to GitHub release
3. Creates issue with KDP upload checklist

---

## Mode: Discovery (`/github-setup discovery`)

Improve repository discoverability:

### Topics

```bash
gh api repos/OWNER/REPO/topics -X PUT --input - <<'EOF'
{
  "names": ["topic1", "topic2", "topic3"]
}
EOF
```

### Social Preview

- Create 1280x640 image
- Upload via Settings > General > Social preview

### FUNDING.yml

Create `.github/FUNDING.yml`:

```yaml
github: [username]
```

### GitHub Pages

```bash
gh api repos/OWNER/REPO/pages -X POST --input - <<'EOF'
{
  "source": { "branch": "main", "path": "/" }
}
EOF
```

---

## Mode: Checklist (`/github-setup checklist`)

Audit the repository and report what's missing:

### Check Each Category

**Documentation:**
- [ ] README.md exists and has badges
- [ ] LICENSE exists
- [ ] CONTRIBUTING.md exists
- [ ] CHANGELOG.md exists
- [ ] CLAUDE.md exists (for Claude Code users)

**Editor Config:**
- [ ] .editorconfig exists
- [ ] .vscode/settings.json exists
- [ ] .vscode/extensions.json exists

**Protection:**
- [ ] Branch protection enabled
- [ ] Auto-delete merged branches enabled
- [ ] CODEOWNERS file exists

**Issues:**
- [ ] Issue templates exist
- [ ] Labels configured
- [ ] PR template exists
- [ ] Discussions enabled
- [ ] Discussion templates exist

**Quality:**
- [ ] Commitlint workflow
- [ ] Spell check workflow
- [ ] Link checker workflow
- [ ] Markdown lint workflow
- [ ] Format check workflow

**CI/CD:**
- [ ] Language-specific CI workflow
- [ ] Coverage workflow
- [ ] Dependabot configured
- [ ] Stale bot configured

**Releases:**
- [ ] Release automation configured
- [ ] Publishing workflow (if applicable)

**Security:**
- [ ] Dependency review workflow

**Dev Experience:**
- [ ] Dev container configured

**Discovery:**
- [ ] Topics set (3+ recommended)
- [ ] Description set
- [ ] Social preview uploaded

### Output

Report missing items grouped by priority:
1. **Essential** — Should have
2. **Recommended** — Nice to have
3. **Optional** — Depends on project type

---

## Templates Reference

All templates available at: https://github.com/domelic/github-repository-setup/tree/main/templates

### Workflows

| File | Purpose |
|------|---------|
| `ci.yml` | Generic CI template |
| `ci-nodejs.yml` | Node.js CI (18, 20, 22) |
| `ci-python.yml` | Python CI (3.10, 3.11, 3.12) |
| `ci-go.yml` | Go CI (1.21, 1.22) |
| `ci-rust.yml` | Rust CI (stable, nightly) |
| `ci-java.yml` | Java CI (17, 21) |
| `ci-ruby.yml` | Ruby CI (3.2, 3.3) |
| `ci-php.yml` | PHP CI (8.2, 8.3) |
| `ci-dotnet.yml` | .NET CI (8, 9) |
| `publish-npm.yml` | npm publishing |
| `publish-pypi.yml` | PyPI publishing (OIDC) |
| `publish-docker.yml` | Docker image publishing |
| `publish-crates.yml` | crates.io publishing |
| `deploy-github-pages.yml` | GitHub Pages deployment |
| `deploy-vercel.yml` | Vercel deployment |
| `deploy-netlify.yml` | Netlify deployment |
| `dependency-review.yml` | PR vulnerability check |
| `codeql.yml` | CodeQL SAST scanning |
| `trivy.yml` | Trivy vulnerability scanning |
| `scorecard.yml` | OpenSSF Scorecard |
| `sbom.yml` | SBOM generation |
| `format-check.yml` | Multi-language formatting |
| `coverage.yml` | Test coverage upload |
| `all-contributors.yml` | Contributor recognition |
| `commitlint.yml` | Commit validation |
| `spell-check.yml` | Spelling check |
| `link-checker.yml` | Link validation |
| `markdown-lint.yml` | Markdown style |
| `stale.yml` | Inactive issue management |
| `welcome.yml` | First-time contributor |
| `release-please.yml` | Auto-releases |
| `release-manual.yml` | Tag-triggered releases |

### Configs

| File | Purpose |
|------|---------|
| `.editorconfig` | Editor formatting rules |
| `.vscode/settings.json` | VSCode workspace settings |
| `.vscode/extensions.json` | Recommended extensions |
| `.cspell.json` | Spell check dictionary |
| `.markdownlint.json` | Markdown lint rules |
| `commitlint.config.js` | Commit lint rules |
| `codecov.yml` | Coverage configuration |
| `dependabot.yml` | Basic dependabot |
| `dependabot-full.yml` | Full ecosystem dependabot |
| `.all-contributorsrc` | Contributor config |
| `.prettierrc` | Prettier config (JS/TS) |
| `.eslintrc.json` | ESLint config (JS/TS) |
| `tsconfig.json` | TypeScript config |
| `pyproject.toml` | Python project config |
| `.gitignore-nodejs` | Node.js .gitignore |
| `.gitignore-python` | Python .gitignore |
| `.gitignore-go` | Go .gitignore |
| `.gitignore-rust` | Rust .gitignore |

### Dev Containers

| File | Purpose |
|------|---------|
| `devcontainer.json` | Base dev container |
| `devcontainer-nodejs.json` | Node.js container |
| `devcontainer-python.json` | Python container |
| `devcontainer-go.json` | Go container |
| `devcontainer-rust.json` | Rust container |
| `devcontainer-java.json` | Java container |
| `devcontainer-ruby.json` | Ruby container |
| `devcontainer-php.json` | PHP container |
| `devcontainer-dotnet.json` | .NET container |

### Templates

| File | Purpose |
|------|---------|
| `ISSUE_TEMPLATE/bug_report.md` | Bug report template |
| `ISSUE_TEMPLATE/feature_request.md` | Feature request template |
| `ISSUE_TEMPLATE/config.yml` | Issue chooser config |
| `DISCUSSION_TEMPLATE/ideas.yml` | Ideas discussion |
| `DISCUSSION_TEMPLATE/q-a.yml` | Q&A discussion |
| `PULL_REQUEST_TEMPLATE.md` | PR template |

### Docs

| File | Purpose |
|------|---------|
| `CONTRIBUTING.md` | Contribution guidelines |
| `RELEASING.md` | Release process |
| `CITATION.cff` | Citation file |
| `CLAUDE.md` | Claude Code guide |
| `SECRETS_MANAGEMENT.md` | Secrets management guide |
| `MONOREPO_PATTERNS.md` | Monorepo patterns guide |

### Scripts

| File | Purpose |
|------|---------|
| `scripts/setup-branch-protection.sh` | Branch protection setup |

### Release Please

| File | Purpose |
|------|---------|
| `release-please-config.json` | Release config |
| `.release-please-manifest.json` | Version manifest |
