# Monorepo Patterns Guide

Best practices for managing multi-package repositories with GitHub Actions.

---

## Table of Contents

1. [When to Use a Monorepo](#when-to-use-a-monorepo)
2. [Directory Structure](#directory-structure)
3. [Path Filtering](#path-filtering)
4. [Matrix Builds](#matrix-builds)
5. [Dependency Management](#dependency-management)
6. [Release Strategies](#release-strategies)
7. [CI Optimization](#ci-optimization)
8. [Common Patterns by Language](#common-patterns-by-language)

---

## When to Use a Monorepo

### Good Fit

| Scenario | Why Monorepo Works |
|----------|-------------------|
| Shared dependencies | Single lockfile, coordinated updates |
| Related packages | Atomic changes across packages |
| Consistent tooling | Shared configs, scripts, CI |
| Small team | Simpler access control |

### Poor Fit

| Scenario | Why Split Repos |
|----------|-----------------|
| Independent lifecycles | Different release cadences |
| Different teams | Access control complexity |
| Large, slow CI | Build times become prohibitive |
| Open source components | Contributors need focused scope |

---

## Directory Structure

### Flat Structure

```text
my-monorepo/
├── packages/
│   ├── core/
│   │   ├── package.json
│   │   └── src/
│   ├── cli/
│   │   ├── package.json
│   │   └── src/
│   └── web/
│       ├── package.json
│       └── src/
├── package.json          # Root workspace config
├── pnpm-workspace.yaml   # or lerna.json, nx.json
└── .github/
    └── workflows/
```

### Apps + Packages Structure

```text
my-monorepo/
├── apps/
│   ├── web/              # Deployable applications
│   ├── api/
│   └── mobile/
├── packages/
│   ├── ui/               # Shared libraries
│   ├── utils/
│   └── config/
├── tooling/
│   ├── eslint/           # Shared configs
│   └── typescript/
└── .github/
    └── workflows/
```

---

## Path Filtering

Run workflows only when relevant files change.

### Basic Path Filter

```yaml
name: CI - Core Package

on:
  push:
    branches: [main]
    paths:
      - 'packages/core/**'
      - 'package.json'
      - 'pnpm-lock.yaml'
  pull_request:
    paths:
      - 'packages/core/**'
      - 'package.json'
      - 'pnpm-lock.yaml'

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: pnpm test --filter=@org/core
```

### Dorny Path Filter Action

More flexible path detection:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  changes:
    runs-on: ubuntu-latest
    outputs:
      core: ${{ steps.filter.outputs.core }}
      cli: ${{ steps.filter.outputs.cli }}
      web: ${{ steps.filter.outputs.web }}
    steps:
      - uses: actions/checkout@v4
      - uses: dorny/paths-filter@v3
        id: filter
        with:
          filters: |
            core:
              - 'packages/core/**'
            cli:
              - 'packages/cli/**'
              - 'packages/core/**'  # CLI depends on core
            web:
              - 'packages/web/**'
              - 'packages/ui/**'    # Web depends on UI

  test-core:
    needs: changes
    if: needs.changes.outputs.core == 'true'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: pnpm test --filter=@org/core

  test-cli:
    needs: changes
    if: needs.changes.outputs.cli == 'true'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: pnpm test --filter=@org/cli
```

---

## Matrix Builds

### Dynamic Matrix

```yaml
name: CI

on: [push, pull_request]

jobs:
  detect-packages:
    runs-on: ubuntu-latest
    outputs:
      packages: ${{ steps.detect.outputs.packages }}
    steps:
      - uses: actions/checkout@v4
      - id: detect
        run: |
          PACKAGES=$(ls -d packages/*/ | jq -R -s -c 'split("\n")[:-1] | map(split("/")[-2])')
          echo "packages=$PACKAGES" >> $GITHUB_OUTPUT

  test:
    needs: detect-packages
    runs-on: ubuntu-latest
    strategy:
      matrix:
        package: ${{ fromJson(needs.detect-packages.outputs.packages) }}
    steps:
      - uses: actions/checkout@v4
      - run: pnpm test --filter=@org/${{ matrix.package }}
```

### Static Matrix with Exclusions

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        package: [core, cli, web, api]
        node: ['18', '20']
        exclude:
          # CLI doesn't need multiple Node versions
          - package: cli
            node: '18'
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      - run: pnpm test --filter=@org/${{ matrix.package }}
```

---

## Dependency Management

### Dependabot Configuration

```yaml
# .github/dependabot.yml
version: 2
updates:
  # Root dependencies
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    groups:
      dev-dependencies:
        patterns: ["*"]

  # Per-package updates (optional, for fine control)
  - package-ecosystem: "npm"
    directory: "/packages/core"
    schedule:
      interval: "weekly"
    groups:
      all:
        patterns: ["*"]

  # GitHub Actions
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
    groups:
      actions:
        patterns: ["*"]
```

### Workspace Dependency Updates

```yaml
name: Update Dependencies

on:
  schedule:
    - cron: '0 6 * * 1'  # Weekly
  workflow_dispatch:

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Update all packages
        run: |
          pnpm update --recursive --latest
          pnpm install

      - name: Create PR
        uses: peter-evans/create-pull-request@v6
        with:
          commit-message: 'chore: update dependencies'
          title: 'chore: weekly dependency updates'
          branch: chore/weekly-deps
```

---

## Release Strategies

### Independent Versioning (Recommended for Most)

Each package has its own version:

```yaml
# release-please-config.json
{
  "packages": {
    "packages/core": {
      "release-type": "node",
      "component": "core"
    },
    "packages/cli": {
      "release-type": "node",
      "component": "cli"
    }
  },
  "separate-pull-requests": true
}
```

### Fixed/Locked Versioning

All packages share the same version:

```yaml
# release-please-config.json
{
  "packages": {
    "packages/core": {},
    "packages/cli": {}
  },
  "linked-versions": true,
  "group-pull-request-title-pattern": "chore: release ${version}"
}
```

### Changesets

Alternative to Release Please:

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    branches: [main]

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Create Release PR or Publish
        uses: changesets/action@v1
        with:
          publish: pnpm release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

---

## CI Optimization

### Caching

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: pnpm/action-setup@v3
        with:
          version: 8

      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'

      # Turborepo cache
      - uses: actions/cache@v4
        with:
          path: .turbo
          key: ${{ runner.os }}-turbo-${{ github.sha }}
          restore-keys: |
            ${{ runner.os }}-turbo-

      - run: pnpm install --frozen-lockfile
      - run: pnpm turbo build test
```

### Turborepo Remote Caching

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v3
      - uses: actions/setup-node@v4
        with:
          cache: 'pnpm'

      - run: pnpm install --frozen-lockfile

      - run: pnpm turbo build test
        env:
          TURBO_TOKEN: ${{ secrets.TURBO_TOKEN }}
          TURBO_TEAM: ${{ vars.TURBO_TEAM }}
```

### Nx Affected

Run only affected projects:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Required for affected detection

      - uses: nrwl/nx-set-shas@v4

      - run: pnpm install --frozen-lockfile

      # Only test affected packages
      - run: pnpm nx affected -t test --base=$NX_BASE --head=$NX_HEAD
```

---

## Common Patterns by Language

### JavaScript/TypeScript (pnpm/npm workspaces)

```yaml
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: pnpm/action-setup@v3
        with:
          version: 8

      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'

      - run: pnpm install --frozen-lockfile
      - run: pnpm -r build
      - run: pnpm -r test
      - run: pnpm -r lint
```

### Python (uv workspaces)

```yaml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        package: [core, cli, api]
    steps:
      - uses: actions/checkout@v4

      - uses: astral-sh/setup-uv@v3

      - run: |
          cd packages/${{ matrix.package }}
          uv sync
          uv run pytest
```

### Go (Go Workspaces)

```yaml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-go@v5
        with:
          go-version: '1.22'

      # Go workspaces auto-detect modules
      - run: go work sync
      - run: go build ./...
      - run: go test ./...
```

### Rust (Cargo Workspaces)

```yaml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: dtolnay/rust-toolchain@stable

      - uses: Swatinem/rust-cache@v2

      # Cargo workspaces build all members
      - run: cargo build --workspace
      - run: cargo test --workspace
      - run: cargo clippy --workspace
```

---

## Anti-Patterns to Avoid

### Running Everything Always

**Bad:**
```yaml
on: [push]
jobs:
  test:
    steps:
      - run: pnpm test  # Tests ALL packages on every push
```

**Good:**
```yaml
on:
  push:
    paths:
      - 'packages/core/**'
jobs:
  test:
    steps:
      - run: pnpm test --filter=@org/core
```

### No Caching

**Bad:**
```yaml
steps:
  - run: pnpm install  # Downloads everything every time
```

**Good:**
```yaml
steps:
  - uses: actions/setup-node@v4
    with:
      cache: 'pnpm'
  - run: pnpm install --frozen-lockfile
```

### Sequential Package Builds

**Bad:**
```yaml
steps:
  - run: cd packages/a && pnpm build
  - run: cd packages/b && pnpm build
  - run: cd packages/c && pnpm build
```

**Good:**
```yaml
steps:
  - run: pnpm turbo build  # Parallel with dependency awareness
```

---

## Resources

- [pnpm Workspaces](https://pnpm.io/workspaces)
- [Turborepo](https://turbo.build/repo)
- [Nx](https://nx.dev/)
- [Changesets](https://github.com/changesets/changesets)
- [Release Please Monorepo](https://github.com/googleapis/release-please/blob/main/docs/manifest-releaser.md)
- [Cargo Workspaces](https://doc.rust-lang.org/cargo/reference/workspaces.html)
- [Go Workspaces](https://go.dev/doc/tutorial/workspaces)
