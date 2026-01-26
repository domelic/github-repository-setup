# Release Drafter Guide

An alternative to Release Please for teams that prefer manual release publishing.

---

## Table of Contents

1. [Release Drafter vs Release Please](#release-drafter-vs-release-please)
2. [When to Choose Each](#when-to-choose-each)
3. [Setup Guide](#setup-guide)
4. [Configuration](#configuration)
5. [Workflow Template](#workflow-template)
6. [Migration Guide](#migration-guide)
7. [Advanced Patterns](#advanced-patterns)

---

## Release Drafter vs Release Please

| Feature | Release Drafter | Release Please |
|---------|-----------------|----------------|
| **Release creation** | Draft releases (manual publish) | Auto-publish on merge |
| **Changelog** | Aggregates PR titles | Generates from commits |
| **Version bumping** | Label-based | Conventional commits |
| **Release PR** | No | Yes (updates changelog file) |
| **Best for** | Human review before release | Fully automated pipelines |
| **Monorepo support** | Limited | Built-in |

### How Release Drafter Works

1. Every merged PR updates a **draft release** in GitHub
2. PRs are categorized by labels (feature, bugfix, etc.)
3. Version is calculated based on PR labels
4. Maintainer reviews and **manually publishes** when ready

### How Release Please Works

1. Conventional commits trigger a **release PR**
2. Release PR contains changelog updates and version bumps
3. Merging the release PR **automatically publishes** the release
4. No manual intervention required

---

## When to Choose Each

### Choose Release Drafter When

- Your team wants to **review releases** before publishing
- You prefer **PR-based versioning** over commit conventions
- You need **flexible categorization** of changes
- You want to **batch multiple PRs** into a single release
- Your workflow involves **manual QA** before releases

### Choose Release Please When

- You want **fully automated releases** on merge to main
- Your team already uses **conventional commits**
- You need **monorepo support** with multiple packages
- You want **changelog files** committed to the repository
- You prefer **no manual release steps**

### Decision Matrix

| Scenario | Recommended |
|----------|-------------|
| Small team, manual QA | Release Drafter |
| CI/CD with auto-deploy | Release Please |
| Monorepo with multiple packages | Release Please |
| Need human approval before release | Release Drafter |
| Library published to npm/PyPI | Either (Release Please for automation) |
| Internal tools | Release Drafter (simpler) |

---

## Setup Guide

### Step 1: Create Configuration File

Create `.github/release-drafter.yml`:

```yaml
name-template: 'v$RESOLVED_VERSION'
tag-template: 'v$RESOLVED_VERSION'

# Categories for organizing changelog
categories:
  - title: '🚀 Features'
    labels:
      - 'feature'
      - 'enhancement'
  - title: '🐛 Bug Fixes'
    labels:
      - 'fix'
      - 'bugfix'
      - 'bug'
  - title: '🧰 Maintenance'
    labels:
      - 'chore'
      - 'maintenance'
  - title: '📖 Documentation'
    labels:
      - 'documentation'
      - 'docs'
  - title: '⬆️ Dependencies'
    labels:
      - 'dependencies'
    collapse-after: 5

# Exclude from changelog
exclude-labels:
  - 'skip-changelog'

# Version resolution based on labels
version-resolver:
  major:
    labels:
      - 'major'
      - 'breaking'
  minor:
    labels:
      - 'minor'
      - 'feature'
      - 'enhancement'
  patch:
    labels:
      - 'patch'
      - 'fix'
      - 'bugfix'
      - 'bug'
  default: patch

# Autolabeler for PRs
autolabeler:
  - label: 'feature'
    branch:
      - '/^feat(ure)?[/-].+/'
    title:
      - '/^feat(\(.+\))?:/'
  - label: 'fix'
    branch:
      - '/^fix[/-].+/'
    title:
      - '/^fix(\(.+\))?:/'
  - label: 'documentation'
    branch:
      - '/^docs?[/-].+/'
    files:
      - '*.md'
      - 'docs/**/*'
  - label: 'chore'
    branch:
      - '/^chore[/-].+/'
    title:
      - '/^chore(\(.+\))?:/'
  - label: 'dependencies'
    files:
      - 'package-lock.json'
      - 'yarn.lock'
      - 'Gemfile.lock'
      - 'requirements*.txt'
      - 'poetry.lock'

# Changelog template
template: |
  ## Changes

  $CHANGES

  ## Contributors

  $CONTRIBUTORS
```

### Step 2: Add Workflow

Create `.github/workflows/release-drafter.yml`:

```yaml
name: Release Drafter

on:
  push:
    branches:
      - main
  pull_request:
    types:
      - opened
      - reopened
      - synchronize
      - labeled
      - unlabeled

permissions:
  contents: read
  pull-requests: write

jobs:
  update-release-draft:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
    steps:
      - uses: release-drafter/release-drafter@v6
        with:
          config-name: release-drafter.yml
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Step 3: Add Required Labels

Create labels in your repository (Settings > Labels):

| Label | Color | Description |
|-------|-------|-------------|
| `feature` | `#0E8A16` | New feature |
| `enhancement` | `#84B6EB` | Enhancement |
| `fix` | `#D73A4A` | Bug fix |
| `bugfix` | `#D73A4A` | Bug fix |
| `documentation` | `#0075CA` | Documentation |
| `chore` | `#FEF2C0` | Maintenance |
| `dependencies` | `#0366D6` | Dependency updates |
| `breaking` | `#B60205` | Breaking change |
| `skip-changelog` | `#EEEEEE` | Exclude from changelog |

---

## Configuration

### Version Resolution

Control how versions are bumped based on labels:

```yaml
version-resolver:
  major:
    labels:
      - 'breaking'
      - 'major'
  minor:
    labels:
      - 'feature'
      - 'enhancement'
  patch:
    labels:
      - 'fix'
      - 'bugfix'
  default: patch
```

### Custom Templates

Customize the release notes format:

```yaml
template: |
  ## What's New in $RESOLVED_VERSION

  $CHANGES

  ---

  **Full Changelog**: https://github.com/$OWNER/$REPOSITORY/compare/$PREVIOUS_TAG...v$RESOLVED_VERSION

  ### Contributors
  $CONTRIBUTORS
```

### Available Placeholders

| Placeholder | Description |
|-------------|-------------|
| `$CHANGES` | List of changes by category |
| `$CONTRIBUTORS` | List of contributors |
| `$PREVIOUS_TAG` | Previous release tag |
| `$RESOLVED_VERSION` | Calculated version |
| `$OWNER` | Repository owner |
| `$REPOSITORY` | Repository name |

### Collapsible Sections

Collapse long lists (like dependencies):

```yaml
categories:
  - title: '⬆️ Dependencies'
    labels:
      - 'dependencies'
    collapse-after: 3  # Collapse after 3 items
```

---

## Workflow Template

Full workflow with post-release actions:

```yaml
name: Release Drafter

on:
  push:
    branches:
      - main
  pull_request:
    types:
      - opened
      - reopened
      - synchronize
      - labeled
      - unlabeled
  # Allow manual trigger to create release
  workflow_dispatch:
    inputs:
      publish:
        description: 'Publish the release'
        required: true
        type: boolean
        default: false

permissions:
  contents: read
  pull-requests: write

jobs:
  update-release-draft:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
    outputs:
      tag_name: ${{ steps.drafter.outputs.tag_name }}
      upload_url: ${{ steps.drafter.outputs.upload_url }}
    steps:
      - uses: release-drafter/release-drafter@v6
        id: drafter
        with:
          config-name: release-drafter.yml
          publish: ${{ github.event.inputs.publish == 'true' }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  # Optional: Post-release tasks when manually published
  post-release:
    needs: update-release-draft
    if: github.event.inputs.publish == 'true'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Build release artifacts
        run: |
          # Build your artifacts here
          echo "Building artifacts for ${{ needs.update-release-draft.outputs.tag_name }}"

      # - name: Upload assets
      #   uses: actions/upload-release-asset@v1
      #   with:
      #     upload_url: ${{ needs.update-release-draft.outputs.upload_url }}
      #     asset_path: ./dist/app.zip
      #     asset_name: app.zip
      #     asset_content_type: application/zip
```

---

## Migration Guide

### From Release Please to Release Drafter

1. **Remove Release Please configuration**
   ```bash
   rm .github/workflows/release-please.yml
   rm release-please-config.json
   rm .release-please-manifest.json
   ```

2. **Add Release Drafter configuration**
   - Create `.github/release-drafter.yml`
   - Create `.github/workflows/release-drafter.yml`

3. **Set up labels**
   - Add required labels to your repository
   - Consider using the autolabeler feature

4. **Update PR workflow**
   - Ensure PRs are labeled appropriately
   - Train team on new labeling conventions

### From Release Drafter to Release Please

1. **Remove Release Drafter configuration**
   ```bash
   rm .github/release-drafter.yml
   rm .github/workflows/release-drafter.yml
   ```

2. **Add Release Please configuration**
   - Copy from `templates/workflows/release-please.yml`
   - Configure release type and package name

3. **Adopt conventional commits**
   - Set up commitlint (see `templates/workflows/commitlint.yml`)
   - Update team guidelines

4. **Create initial manifest**
   ```bash
   # For simple projects
   echo '{}' > .release-please-manifest.json
   ```

---

## Advanced Patterns

### Monorepo Support

For monorepos, use separate configurations:

```yaml
# .github/release-drafter-frontend.yml
filter-by-commitish: true
include-paths:
  - 'frontend/**'
tag-prefix: 'frontend-v'
```

```yaml
# .github/release-drafter-backend.yml
filter-by-commitish: true
include-paths:
  - 'backend/**'
tag-prefix: 'backend-v'
```

### Pre-release Versions

Create pre-releases with a modified template:

```yaml
prerelease: true
name-template: 'v$RESOLVED_VERSION-beta'
tag-template: 'v$RESOLVED_VERSION-beta'
```

### Combining with Auto-labeler

Use with the auto-labeler workflow for hands-free labeling:

```yaml
# In release-drafter.yml
autolabeler:
  - label: 'feature'
    title:
      - '/^feat(\(.+\))?:/'
  - label: 'fix'
    title:
      - '/^fix(\(.+\))?:/'
```

### Triggering Deployments on Publish

```yaml
name: Deploy on Release

on:
  release:
    types: [published]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy
        run: |
          echo "Deploying ${{ github.event.release.tag_name }}"
          # Your deployment commands here
```

---

## Resources

- [Release Drafter GitHub](https://github.com/release-drafter/release-drafter)
- [Release Please GitHub](https://github.com/google-github-actions/release-please-action)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Releases Documentation](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)
