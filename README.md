# GitHub Repository Setup Guide

A comprehensive guide and Claude Code skill for setting up GitHub repositories with production-grade automation.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## Overview

This guide covers everything needed to set up a professional GitHub repository:

| Category | What's Included |
|----------|-----------------|
| **Documentation** | README, LICENSE, CONTRIBUTING, CHANGELOG, CODE_OF_CONDUCT, RELEASING |
| **Branch Protection** | PR requirements, CODEOWNERS, admin enforcement |
| **Issue/PR Management** | Templates, labels, PR template, stale bot, welcome bot |
| **Quality Gates** | Commitlint, spell check, link checker, markdown lint |
| **Release Automation** | Release Please, auto-CHANGELOG, semantic versioning |
| **CI/CD** | Build workflows, PDF/artifact previews, Dependabot |
| **Discovery** | Topics, social preview, FUNDING.yml, CITATION.cff |

---

## Quick Start

### Using the Claude Code Skill

```bash
/github-setup                    # Full setup wizard
/github-setup docs               # Documentation files
/github-setup protection         # Branch protection + CODEOWNERS
/github-setup issues             # Templates, labels, Discussions
/github-setup quality            # Linting, spell check, link checker
/github-setup releases           # Release Please automation
/github-setup automation         # All GitHub Actions
/github-setup discovery          # Topics, social preview, funding
/github-setup checklist          # Show what's missing
```

### Manual Setup

1. Copy templates from [`templates/`](templates/) directory
2. Follow the [Complete Checklist](#complete-setup-checklist)
3. Customize for your project

---

## Table of Contents

1. [Documentation Files](#1-documentation-files)
2. [Branch Protection](#2-branch-protection)
3. [Issue & PR Management](#3-issue--pr-management)
4. [Quality Gate Workflows](#4-quality-gate-workflows)
5. [Release Automation](#5-release-automation)
6. [CI/CD Workflows](#6-cicd-workflows)
7. [Discovery & Sponsorship](#7-discovery--sponsorship)
8. [Complete Setup Checklist](#complete-setup-checklist)
9. [Workflow Reference](#workflow-reference)

---

## 1. Documentation Files

### Required Files

| File | Purpose | Template |
|------|---------|----------|
| `README.md` | Project overview, badges, usage | — |
| `LICENSE` | Legal terms | [choosealicense.com](https://choosealicense.com/) |
| `CONTRIBUTING.md` | How to contribute | [Template](templates/CONTRIBUTING.md) |
| `CHANGELOG.md` | Version history | [Keep a Changelog](https://keepachangelog.com/) |

### Recommended Files

| File | Purpose | Template |
|------|---------|----------|
| `CODE_OF_CONDUCT.md` | Community guidelines | [Contributor Covenant](https://www.contributor-covenant.org/) |
| `RELEASING.md` | Release process docs | [Template](templates/RELEASING.md) |
| `CITATION.cff` | Machine-readable citation | [Template](templates/CITATION.cff) |
| `CLAUDE.md` | Claude Code instructions | — |
| `SECURITY.md` | Vulnerability reporting | For software projects |

### CITATION.cff (For Academic/Citable Projects)

```yaml
cff-version: 1.2.0
title: "Your Project Title"
message: "If you use this software, please cite it as below."
authors:
  - family-names: LastName
    given-names: FirstName
    orcid: "https://orcid.org/0000-0000-0000-0000"
version: "1.0.0"
doi: "10.5281/zenodo.XXXXXXX"
date-released: "2024-01-01"
url: "https://github.com/owner/repo"
```

GitHub displays a "Cite this repository" button when this file exists.

---

## 2. Branch Protection

### Configuration via CLI

```bash
gh api repos/OWNER/REPO/branches/main/protection -X PUT --input - <<'EOF'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["build", "test"]
  },
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

### Settings by Team Size

| Setting | Solo | Small Team | Large Team |
|---------|------|------------|------------|
| PRs required | ✅ | ✅ | ✅ |
| Approvals | 0 | 1 | 2+ |
| CODEOWNERS | Optional | ✅ | ✅ |
| Status checks | Optional | ✅ | ✅ |
| Enforce admins | ✅ | ✅ | ✅ |

### CODEOWNERS

Location: `.github/CODEOWNERS`

```
# Default owner
* @username

# By path
/docs/ @docs-team
/src/api/ @backend-team

# By file type
*.ts @typescript-team
```

---

## 3. Issue & PR Management

### Issue Templates

Location: `.github/ISSUE_TEMPLATE/`

See [`templates/ISSUE_TEMPLATE/`](templates/ISSUE_TEMPLATE/) for complete examples:
- `bug_report.md` — Bug reports
- `feature_request.md` — Feature requests
- `config.yml` — Template chooser config

### PR Template

Location: `.github/PULL_REQUEST_TEMPLATE.md`

```markdown
## Summary
<!-- Brief description -->

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation
- [ ] Refactoring

## Checklist
- [ ] Tests pass
- [ ] Documentation updated
- [ ] Commits follow conventional format
```

### Labels

```bash
# Essential labels
gh label create "bug" -c "d73a4a" -d "Something isn't working"
gh label create "enhancement" -c "a2eeef" -d "New feature or request"
gh label create "documentation" -c "0075ca" -d "Documentation improvements"
gh label create "good first issue" -c "7057ff" -d "Good for newcomers"
gh label create "help wanted" -c "008672" -d "Extra attention needed"

# Priority labels
gh label create "priority: critical" -c "b60205" -d "Must be fixed immediately"
gh label create "priority: high" -c "d93f0b" -d "High priority"
gh label create "priority: medium" -c "fbca04" -d "Medium priority"
gh label create "priority: low" -c "c5def5" -d "Low priority"

# Status labels
gh label create "in-progress" -c "0e8a16" -d "Work in progress"
gh label create "blocked" -c "b60205" -d "Blocked by dependency"
gh label create "stale" -c "ededed" -d "Inactive issue/PR"
gh label create "pinned" -c "006b75" -d "Exempt from stale bot"

# Automation labels
gh label create "dependencies" -c "0366d6" -d "Dependency updates"
gh label create "github-actions" -c "000000" -d "CI/CD changes"
```

### Enable Discussions

```bash
gh api repos/OWNER/REPO -X PATCH -f has_discussions=true
```

### Stale Bot

See [`templates/workflows/stale.yml`](templates/workflows/stale.yml)

Automatically marks and closes inactive issues/PRs:
- Marks stale after 45 days
- Closes after 14 more days (60 total)
- Exempt: `pinned`, `security`, `in-progress` labels

### Welcome Bot

See [`templates/workflows/welcome.yml`](templates/workflows/welcome.yml)

Greets first-time contributors with helpful information.

---

## 4. Quality Gate Workflows

### Commitlint (Conventional Commits)

Enforces commit message format: `type: description`

**Workflow:** [`templates/workflows/commitlint.yml`](templates/workflows/commitlint.yml)
**Config:** [`templates/commitlint.config.js`](templates/commitlint.config.js)

```bash
# Valid commits
feat: add user authentication
fix: resolve memory leak in parser
docs: update API documentation

# Invalid commits
added feature        # No type
feat add feature     # Missing colon
FEAT: add feature    # Wrong case
```

### Spell Check

Uses cspell with custom dictionary support.

**Workflow:** [`templates/workflows/spell-check.yml`](templates/workflows/spell-check.yml)
**Config:** [`templates/.cspell.json`](templates/.cspell.json)

### Link Checker

Validates all links in markdown files.

**Workflow:** [`templates/workflows/link-checker.yml`](templates/workflows/link-checker.yml)

- Runs on push/PR to markdown files
- Weekly scheduled scan
- Auto-creates issue if broken links found

### Markdown Lint

Enforces consistent markdown formatting.

**Workflow:** [`templates/workflows/markdown-lint.yml`](templates/workflows/markdown-lint.yml)
**Config:** [`templates/.markdownlint.json`](templates/.markdownlint.json)

---

## 5. Release Automation

### Release Please (Recommended)

Fully automated releases from conventional commits.

**Workflow:** [`templates/workflows/release-please.yml`](templates/workflows/release-please.yml)
**Config:** [`templates/release-please-config.json`](templates/release-please-config.json)

**How it works:**
```
feat: add feature → Push → Release PR created → Merge → v1.1.0 released
```

| Commit Type | Version Bump |
|-------------|--------------|
| `feat:` | Minor (1.0.0 → 1.1.0) |
| `fix:` | Patch (1.0.0 → 1.0.1) |
| `feat!:` or `BREAKING CHANGE:` | Major (1.0.0 → 2.0.0) |
| `chore:`, `ci:` | No release |

### Manual Release Workflow

If you prefer manual control:

**Workflow:** [`templates/workflows/release-manual.yml`](templates/workflows/release-manual.yml)

```bash
git tag v1.0.0
git push origin v1.0.0
# Release created automatically
```

---

## 6. CI/CD Workflows

### Dependabot (Auto-update Actions)

**Config:** [`templates/dependabot.yml`](templates/dependabot.yml)

- Updates GitHub Actions weekly
- Groups updates into single PR
- Uses conventional commit format

### Build/Test Workflow

**Workflow:** [`templates/workflows/ci.yml`](templates/workflows/ci.yml)

### Artifact Preview on PRs

Upload build artifacts for review before merge.

**Workflow:** [`templates/workflows/artifact-preview.yml`](templates/workflows/artifact-preview.yml)

---

## 7. Discovery & Sponsorship

### Repository Topics

```bash
gh api repos/OWNER/REPO/topics -X PUT --input - <<'EOF'
{
  "names": ["topic1", "topic2", "topic3"]
}
EOF
```

### Social Preview

- Recommended size: 1280×640 pixels
- Upload: **Settings > General > Social preview**
- Or provide SVG at `.github/social-preview.svg`

### FUNDING.yml

Location: `.github/FUNDING.yml`

```yaml
github: [username]
patreon: username
ko_fi: username
custom: ['https://example.com/donate']
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

## Complete Setup Checklist

### Documentation
- [ ] README.md with badges, installation, usage
- [ ] LICENSE (MIT, Apache 2.0, etc.)
- [ ] CONTRIBUTING.md with guidelines
- [ ] CHANGELOG.md (or Release Please manages it)
- [ ] CODE_OF_CONDUCT.md
- [ ] RELEASING.md (if manual releases)
- [ ] CITATION.cff (if citable)

### Branch Protection
- [ ] PRs required for main
- [ ] CODEOWNERS file
- [ ] Status checks required (if CI exists)
- [ ] Force push blocked

### Issue & PR Management
- [ ] Bug report template
- [ ] Feature request template
- [ ] PR template
- [ ] Labels configured
- [ ] Discussions enabled
- [ ] Stale bot configured
- [ ] Welcome bot configured

### Quality Gates
- [ ] Commitlint workflow
- [ ] Spell check workflow + dictionary
- [ ] Link checker workflow
- [ ] Markdown lint workflow + config

### Release Automation
- [ ] Release Please OR manual release workflow
- [ ] CITATION.cff auto-update (if applicable)

### CI/CD
- [ ] Build/test workflow
- [ ] Dependabot for Actions
- [ ] Artifact preview on PRs (if applicable)

### Discovery
- [ ] Repository description set
- [ ] Topics configured
- [ ] Social preview uploaded
- [ ] FUNDING.yml (if accepting sponsors)
- [ ] GitHub Pages (if applicable)

---

## Workflow Reference

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `release-please.yml` | Push to main | Auto-create release PRs |
| `commitlint.yml` | PR opened | Validate commit messages |
| `spell-check.yml` | Push/PR with docs | Check spelling |
| `link-checker.yml` | Push/PR + weekly | Validate links |
| `markdown-lint.yml` | Push/PR with .md | Lint markdown |
| `stale.yml` | Daily schedule | Mark inactive issues |
| `welcome.yml` | First issue/PR | Welcome contributors |
| `ci.yml` | Push/PR | Build and test |
| `artifact-preview.yml` | PR | Upload build preview |

---

## Claude Code Skill

Install the `/github-setup` skill:

```bash
# Copy to project
mkdir -p .claude/skills
cp templates/skills/github-setup.md .claude/skills/

# Or global installation
cp templates/skills/github-setup.md ~/.claude/skills/
```

See [templates/skills/github-setup.md](templates/skills/github-setup.md) for full documentation.

---

## Contributing

Contributions welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md).

---

## License

MIT License - see [LICENSE](LICENSE).

---

## Resources

- [GitHub Docs](https://docs.github.com)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Release Please](https://github.com/google-github-actions/release-please-action)
- [Keep a Changelog](https://keepachangelog.com/)
- [Contributor Covenant](https://www.contributor-covenant.org/)
