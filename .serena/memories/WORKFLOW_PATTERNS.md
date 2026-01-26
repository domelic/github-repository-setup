# GitHub Actions Workflow Patterns

Common patterns used across all workflow templates.

## Concurrency Control

Prevents duplicate workflow runs on the same branch:

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

**Use cases:**
- CI workflows: Cancel old runs when new commits pushed
- Deploy workflows: Usually set `cancel-in-progress: false` to prevent partial deploys

## Matrix Testing

Test across multiple versions/platforms:

```yaml
strategy:
  fail-fast: false
  matrix:
    node-version: ['18', '20', '22']
    os: [ubuntu-latest, windows-latest, macos-latest]
```

**Common matrices by language:**

| Language | Versions | Notes |
|----------|----------|-------|
| Node.js | 18, 20, 22 | LTS versions |
| Python | 3.10, 3.11, 3.12 | Active versions |
| Go | 1.21, 1.22 | Last two minors |
| Rust | stable, beta | Or MSRV |
| Java | 11, 17, 21 | LTS versions |

## Caching

### Node.js (npm/pnpm/yarn)
```yaml
- uses: actions/setup-node@v4
  with:
    node-version: '20'
    cache: 'npm'  # or 'pnpm', 'yarn'
```

### Python (pip)
```yaml
- uses: actions/setup-python@v5
  with:
    python-version: '3.12'
    cache: 'pip'
```

### Go
```yaml
- uses: actions/setup-go@v5
  with:
    go-version: '1.22'
    cache: true
```

### Rust (cargo)
```yaml
- uses: Swatinem/rust-cache@v2
```

## Permissions Model

Minimum permissions for common tasks:

```yaml
# Read-only (default for forks)
permissions:
  contents: read

# Publishing packages
permissions:
  contents: read
  id-token: write

# Creating releases/PRs
permissions:
  contents: write
  pull-requests: write

# GitHub Pages
permissions:
  pages: write
  id-token: write

# Container registry
permissions:
  contents: read
  packages: write
```

## Trigger Patterns

### CI (push + PR)
```yaml
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
```

### Deploy on main push only
```yaml
on:
  push:
    branches: [main]
```

### Release publishing
```yaml
on:
  release:
    types: [published]
```

### Scheduled (cron)
```yaml
on:
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday
```

### Path filtering
```yaml
on:
  push:
    paths:
      - 'src/**'
      - '!src/**/*.md'
```

### Manual dispatch with inputs
```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        type: choice
        options: [staging, production]
```

## Job Dependencies

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    # ...

  test:
    needs: build
    runs-on: ubuntu-latest
    # ...

  deploy:
    needs: [build, test]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
```

## Environment Protection

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://myapp.com
```

## Common Action Versions

| Action | Version | Purpose |
|--------|---------|---------|
| `actions/checkout` | v4 | Checkout repo |
| `actions/setup-node` | v4 | Node.js setup |
| `actions/setup-python` | v5 | Python setup |
| `actions/setup-go` | v5 | Go setup |
| `actions/upload-artifact` | v4 | Artifact upload |
| `actions/download-artifact` | v4 | Artifact download |
| `codecov/codecov-action` | v4 | Coverage upload |
| `google-github-actions/release-please-action` | v4 | Release automation |

## Conditional Execution

```yaml
# Run only on main branch
if: github.ref == 'refs/heads/main'

# Run only for PRs
if: github.event_name == 'pull_request'

# Skip for certain commits
if: "!contains(github.event.head_commit.message, '[skip ci]')"

# Run only when specific files change
if: contains(github.event.head_commit.modified, 'package.json')
```

## Secrets Best Practices

- Never hardcode secrets in workflows
- Use repository/organization secrets
- Use environment-scoped secrets for sensitive deploys
- Use OIDC (`id-token: write`) over long-lived tokens when possible

```yaml
env:
  NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
  DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
```
