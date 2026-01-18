# GitHub Repository Setup Guide

A comprehensive guide and Claude Code skill for setting up GitHub repositories with best practices.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## Quick Start

### Using the Claude Code Skill

```bash
/github-setup              # Full setup assessment and implementation
/github-setup docs         # Documentation files only
/github-setup protection   # Branch protection and CODEOWNERS
/github-setup issues       # Issue templates and labels
/github-setup automation   # GitHub Actions workflows
/github-setup discovery    # Topics, social preview, funding
```

### Manual Setup

Follow the [Complete Setup Checklist](#complete-setup-checklist) below.

---

## What This Guide Covers

| Category | Components |
|----------|------------|
| **Documentation** | README, CONTRIBUTING, CHANGELOG, LICENSE, CODE_OF_CONDUCT |
| **Branch Protection** | PR requirements, CODEOWNERS, admin enforcement |
| **Issue Management** | Templates, labels, Discussions |
| **Automation** | GitHub Actions (CI, releases), GitHub Pages |
| **Discovery** | Topics, social preview, FUNDING.yml |

---

## 1. Documentation Files

### Required Files

| File | Purpose |
|------|---------|
| `README.md` | Project overview, installation, usage |
| `LICENSE` | Legal terms for use and distribution |
| `CONTRIBUTING.md` | How to contribute |
| `CHANGELOG.md` | Version history ([Keep a Changelog](https://keepachangelog.com/)) |

### Recommended Files

| File | Purpose |
|------|---------|
| `CODE_OF_CONDUCT.md` | Community behavior guidelines |
| `CLAUDE.md` | Instructions for Claude Code |
| `SECURITY.md` | Security vulnerability reporting (software projects) |

### License Options

| License | Use Case |
|---------|----------|
| MIT | Permissive, minimal restrictions |
| Apache 2.0 | Permissive with patent protection |
| GPL 3.0 | Copyleft, derivatives must be open source |
| CC BY 4.0 | Documentation/creative works |
| All Rights Reserved | Proprietary |

---

## 2. Branch Protection

### Configuration via CLI

```bash
gh api repos/OWNER/REPO/branches/main/protection -X PUT --input - <<'EOF'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 0
  },
  "restrictions": null
}
EOF
```

### Settings Explained

| Setting | Solo Maintainer | Team |
|---------|-----------------|------|
| PRs required | Yes | Yes |
| Approvals required | 0 (self-merge) | 1+ |
| CODEOWNERS | Optional | Recommended |
| Enforce for admins | Yes | Yes |
| Block force push | Yes | Yes |

### CODEOWNERS File

Location: `.github/CODEOWNERS`

```
# Default owner for all files
* @username

# Specific paths
/docs/ @docs-team
*.md @technical-writer
```

---

## 3. Issue Management

### Issue Templates

Location: `.github/ISSUE_TEMPLATE/`

**Bug Report:**
```yaml
---
name: Bug Report
about: Report an error or issue
title: '[BUG] '
labels: bug
assignees: ''
---

## Description
[Clear description of the issue]

## Steps to Reproduce
1. ...

## Expected vs Actual
- Expected: ...
- Actual: ...
```

**Feature Request:**
```yaml
---
name: Feature Request
about: Suggest an enhancement
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

## Summary
[Brief description]

## Motivation
[Why is this needed?]
```

### Issue Labels

```bash
# Create labels via CLI
gh label create "priority: high" --color "B60205" --description "High priority"
gh label create "priority: low" --color "C5DEF5" --description "Low priority"
gh label create "good first issue" --color "7057FF" --description "Good for newcomers"
gh label create "help wanted" --color "008672" --description "Extra attention needed"
```

### Enable Discussions

```bash
gh api repos/OWNER/REPO -X PATCH -f has_discussions=true
```

---

## 4. GitHub Actions

### CI Workflow Example

Location: `.github/workflows/ci.yml`

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: |
          # Your build/test commands here
          echo "Build successful"
```

### Release Automation

Location: `.github/workflows/release.yml`

```yaml
name: Create Release

on:
  push:
    tags: ['v*']

jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
      - name: Create Release
        uses: softprops/action-gh-release@v1
        with:
          generate_release_notes: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Usage:**
```bash
git tag v1.0.0
git push origin v1.0.0
# Release created automatically
```

---

## 5. GitHub Pages

```bash
# Enable via API
gh api repos/OWNER/REPO/pages -X POST --input - <<'EOF'
{
  "source": {
    "branch": "main",
    "path": "/"
  }
}
EOF
```

Site URL: `https://OWNER.github.io/REPO/`

---

## 6. Discovery & Sponsorship

### Repository Topics

```bash
gh api repos/OWNER/REPO/topics -X PUT --input - <<'EOF'
{
  "names": ["topic1", "topic2", "topic3"]
}
EOF
```

### Social Preview

1. Create image (1280×640 px recommended)
2. Upload: **Settings > General > Social preview**

### FUNDING.yml

Location: `.github/FUNDING.yml`

```yaml
github: [username]
patreon: username
ko_fi: username
custom: ['https://example.com/donate']
```

---

## Complete Setup Checklist

### Documentation
- [ ] README.md with badges and usage
- [ ] LICENSE appropriate for project
- [ ] CONTRIBUTING.md with guidelines
- [ ] CHANGELOG.md following Keep a Changelog
- [ ] CODE_OF_CONDUCT.md (if community-facing)

### GitHub Configuration
- [ ] Branch protection on main
- [ ] CODEOWNERS file (if team project)
- [ ] Issue templates created
- [ ] Issue labels configured
- [ ] Discussions enabled (if applicable)

### Automation
- [ ] CI workflow for builds/tests
- [ ] Release automation workflow
- [ ] GitHub Pages (if applicable)

### Discovery
- [ ] Repository topics set
- [ ] Social preview uploaded
- [ ] FUNDING.yml (if accepting sponsors)
- [ ] Repository description set

---

## Claude Code Skill

This repository includes a `/github-setup` skill for Claude Code. See [.claude/skills/github-setup.md](.claude/skills/github-setup.md).

**Installation:**
```bash
# Copy to your project
cp -r .claude/skills/github-setup.md YOUR_PROJECT/.claude/skills/

# Or copy to global skills
cp .claude/skills/github-setup.md ~/.claude/skills/
```

---

## Maintenance Commands

```bash
# Check branch protection
gh api repos/OWNER/REPO/branches/main/protection

# List labels
gh label list

# List open PRs
gh pr list

# Check workflows
gh run list

# View repository settings
gh repo view --json description,topics,visibility
```

---

## Contributing

Contributions welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

---

## License

MIT License - see [LICENSE](LICENSE) for details.

---

## Related

- [GitHub Docs](https://docs.github.com) — Official documentation
- [Keep a Changelog](https://keepachangelog.com/) — Changelog format
- [Contributor Covenant](https://www.contributor-covenant.org/) — Code of Conduct template
- [Choose a License](https://choosealicense.com/) — License selector
