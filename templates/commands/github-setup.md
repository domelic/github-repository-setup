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

**Base URL:** `https://raw.githubusercontent.com/domelic/github-repository-setup/main/templates/`

All templates are fetched from this repository. Use `curl`, `wget`, or WebFetch to download.

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

## Category Presets

### `/github-setup docs`

| Template | Destination |
|----------|-------------|
| `CONTRIBUTING.md` | `CONTRIBUTING.md` |
| `RELEASING.md` | `RELEASING.md` |
| `CITATION.cff` | `CITATION.cff` |
| `CLAUDE.md` | `CLAUDE.md` |

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

Report missing items grouped by priority: Essential → Recommended → Optional.

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
BASE_URL="https://raw.githubusercontent.com/domelic/github-repository-setup/main/templates"

# Example: Fetch Node.js CI workflow
mkdir -p .github/workflows
curl -o .github/workflows/ci-nodejs.yml "$BASE_URL/workflows/ci-nodejs.yml"
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
