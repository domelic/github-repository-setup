# GitHub Repository Setup Skill

Set up GitHub repositories with production-grade automation, quality gates, and best practices.

## Usage

```bash
/github-setup                    # Full setup wizard
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

---

## Mode: Full Setup (`/github-setup`)

Assess the repository and implement all missing components:

1. **Audit current state** — Check what exists
2. **Prioritize by impact** — Essential → Recommended → Optional
3. **Implement incrementally** — One category at a time
4. **Verify each step** — Confirm before proceeding

### Implementation Order

1. Documentation (README, LICENSE, CONTRIBUTING)
2. Branch protection + CODEOWNERS
3. Issue templates + labels
4. Quality gates (commitlint, linting)
5. Release automation
6. CI/CD workflows
7. Discovery (topics, social preview)

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

```
* @username
```

### Settings by Team Size

| Setting | Solo | Team |
|---------|------|------|
| PRs required | ✅ | ✅ |
| Approvals | 0 | 1+ |
| CODEOWNERS | Optional | ✅ |

---

## Mode: Issue Management (`/github-setup issues`)

Set up issue templates, labels, and discussions:

### Issue Templates

Create in `.github/ISSUE_TEMPLATE/`:
- `bug_report.md`
- `feature_request.md`
- `config.yml`

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

---

## Mode: Release Automation (`/github-setup releases`)

Set up automated releases with Release Please:

### Files

- `.github/workflows/release-please.yml`
- `release-please-config.json`
- `.release-please-manifest.json`

### How It Works

```
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

### Dependabot

Create `.github/dependabot.yml` for auto-updating Actions.

---

## Mode: Publishing (`/github-setup publishing`)

Set up Amazon KDP automation for book/ebook projects:

### Amazon KDP Workflow

**Workflow:** `.github/workflows/amazon-kdp-publish.yml`

**What it does:**
1. Builds EPUB from source (LaTeX/Markdown) using Pandoc
2. Attaches EPUB to GitHub release
3. Creates issue with KDP upload checklist

### Customization

```yaml
env:
  BOOK_TITLE: "Your Book Title"
  BOOK_SUBTITLE: "Your Subtitle"
  BOOK_AUTHOR: "Your Name"
  SOURCE_FILE: "book.tex"  # or book.md
  COVER_IMAGE: "cover.jpg"
  BIBLIOGRAPHY: "references.bib"
```

### Why Semi-Automated?

Amazon KDP has no public API. The workflow automates:
- EPUB generation from source
- Release asset attachment
- Upload instructions via GitHub issue

Manual step required: Upload EPUB to KDP dashboard.

### Create amazon-kdp Label

```bash
gh label create "amazon-kdp" -c "f9d0c4" -d "Amazon KDP publishing"
```

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

- Create 1280×640 image
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

**Protection:**
- [ ] Branch protection enabled
- [ ] Auto-delete merged branches enabled
- [ ] CODEOWNERS file exists

**Issues:**
- [ ] Issue templates exist
- [ ] Labels configured
- [ ] PR template exists
- [ ] Discussions enabled

**Quality:**
- [ ] Commitlint workflow
- [ ] Spell check workflow
- [ ] Link checker workflow
- [ ] Markdown lint workflow

**Releases:**
- [ ] Release automation configured

**CI/CD:**
- [ ] Build workflow exists
- [ ] Dependabot configured
- [ ] Stale bot configured

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

| Category | Files |
|----------|-------|
| Workflows | `workflows/*.yml` |
| Configs | `.cspell.json`, `.markdownlint.json`, `commitlint.config.js` |
| Issue Templates | `ISSUE_TEMPLATE/*.md` |
| Docs | `CONTRIBUTING.md`, `RELEASING.md`, `CITATION.cff`, `CLAUDE.md` |
| Release Please | `release-please-config.json`, `.release-please-manifest.json` |
