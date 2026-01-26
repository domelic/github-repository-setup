# Branching Strategies Guide

This guide covers the most common Git branching strategies and helps you choose the right one for your team.

## Overview

| Strategy | Best For | Complexity | Release Frequency |
|----------|----------|------------|-------------------|
| Trunk-Based | Small teams, CI/CD | Low | Continuous |
| GitHub Flow | Most projects | Low | On-demand |
| Git Flow | Scheduled releases | High | Scheduled |
| GitLab Flow | Multiple environments | Medium | Environment-based |

## Trunk-Based Development

The simplest approach: everyone commits to `main` (or short-lived feature branches).

```text
main ─────●────●────●────●────●────●──────►
           │              │
           └──feature──┘  └──fix──┘
             (< 1 day)     (hours)
```

### When to Use

- Small teams (2-10 developers)
- Strong CI/CD pipeline
- Feature flags available
- Continuous deployment

### Workflow

1. Create short-lived feature branch (optional)
2. Make small, frequent commits
3. Open PR for code review
4. Merge to `main` (same day)
5. Deploy automatically

### Configuration

```yaml
# .github/workflows/trunk-based.yml
name: Trunk-Based CI/CD

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build-test-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Build and Test
        run: |
          npm ci
          npm test

      - name: Deploy to Production
        if: github.ref == 'refs/heads/main'
        run: npm run deploy
```

### Branch Protection

```json
{
  "main": {
    "required_reviews": 1,
    "require_status_checks": true,
    "require_linear_history": true,
    "allow_force_pushes": false
  }
}
```

---

## GitHub Flow

Simple branch-based workflow with PRs and deployments from `main`.

```text
main ─────●────────────●─────────●────────►
           \          /           \       /
            └─feature─┘            └─fix─┘
```

### When to Use

- Web applications
- On-demand deployments
- Most team sizes
- When simplicity matters

### Workflow

1. Create feature branch from `main`
2. Make commits with descriptive messages
3. Open Pull Request
4. Discuss and review code
5. Deploy and test (optional)
6. Merge to `main`

### Branch Naming

```bash
# Convention: type/description
feat/user-authentication
fix/login-validation-error
docs/api-documentation
refactor/database-connection
```

### Automation

```yaml
# Auto-delete branches after merge
name: Cleanup

on:
  pull_request:
    types: [closed]

jobs:
  delete-branch:
    runs-on: ubuntu-latest
    if: github.event.pull_request.merged == true
    steps:
      - uses: actions/checkout@v4
      - run: git push origin --delete ${{ github.head_ref }}
```

---

## Git Flow

Feature-rich workflow for scheduled releases with multiple branch types.

```text
main     ─────●───────────────●───────────●───────►
              │               │           │
              │   ┌───────────┘           │
              │   │                       │
release  ─────┼───●──────────────────────►│
              │   │                       │
develop  ─────●───●───●───●───●───●───●───●───────►
               \     /   \       /
feature         └───┘     └─────┘

hotfix   ──────────────────────●─────────►
                                \       /
main     ─────●───────────────●──●─────●──►
```

### Branches

| Branch | Purpose | Merges To |
|--------|---------|-----------|
| `main` | Production code | - |
| `develop` | Integration branch | `release`, `main` |
| `feature/*` | New features | `develop` |
| `release/*` | Release preparation | `main`, `develop` |
| `hotfix/*` | Production fixes | `main`, `develop` |

### When to Use

- Scheduled releases (monthly, quarterly)
- Multiple versions in production
- Large teams with release managers
- Products requiring extensive QA

### Workflow

```bash
# Start a feature
git checkout develop
git checkout -b feature/new-feature

# Complete feature
git checkout develop
git merge --no-ff feature/new-feature
git branch -d feature/new-feature

# Create release
git checkout develop
git checkout -b release/1.0.0

# Complete release
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Release 1.0.0"
git checkout develop
git merge --no-ff release/1.0.0
git branch -d release/1.0.0

# Hotfix
git checkout main
git checkout -b hotfix/critical-fix
# Fix the issue
git checkout main
git merge --no-ff hotfix/critical-fix
git tag -a v1.0.1 -m "Hotfix 1.0.1"
git checkout develop
git merge --no-ff hotfix/critical-fix
git branch -d hotfix/critical-fix
```

### Automation

```yaml
# .github/workflows/git-flow.yml
name: Git Flow

on:
  push:
    branches:
      - main
      - develop
      - 'release/*'
      - 'hotfix/*'
  pull_request:
    branches:
      - main
      - develop

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Validate branch name
        run: |
          branch="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
          if [[ ! "$branch" =~ ^(main|develop|feature/|release/|hotfix/).* ]]; then
            echo "Invalid branch name: $branch"
            exit 1
          fi
```

---

## GitLab Flow

Environment-based branches that combine aspects of Git Flow and trunk-based.

```text
main       ─────●───●───●───●───●───────────►
                │       │
staging    ─────●───────●───────●───────────►
                        │       │
production ─────────────●───────●───────────►
```

### When to Use

- Multiple deployment environments
- Need traceability per environment
- Continuous delivery (not deployment)
- Regulated industries

### Workflow

1. Develop on feature branches
2. Merge to `main` (triggers staging deploy)
3. Cherry-pick or merge to `production` branch
4. Deploy from environment branches

### Environment Mapping

| Branch | Environment | Deployment |
|--------|-------------|------------|
| `main` | Development | Automatic |
| `staging` | Staging | Automatic |
| `production` | Production | Manual approval |

---

## Feature Flags Integration

All strategies can benefit from feature flags for safer deployments.

### Why Use Feature Flags

- Deploy incomplete features safely
- Gradual rollouts
- A/B testing
- Quick rollback without deploy

### Implementation

```javascript
// Example: LaunchDarkly integration
import * as LaunchDarkly from 'launchdarkly-node-server-sdk';

const client = LaunchDarkly.init(process.env.LAUNCHDARKLY_SDK_KEY);

async function showNewFeature(user) {
  const showFeature = await client.variation('new-dashboard', user, false);
  return showFeature;
}
```

### Workflow with Flags

```text
1. Create feature branch
2. Implement feature behind flag (default: off)
3. Merge to main (feature hidden)
4. Deploy to production
5. Enable flag for internal users
6. Gradual rollout to all users
7. Remove flag after stable
```

---

## Choosing a Strategy

### Decision Tree

```text
Start
  │
  ├─► "Do you deploy continuously?"
  │     ├─► Yes → Trunk-Based Development
  │     └─► No ↓
  │
  ├─► "Do you have scheduled releases?"
  │     ├─► Yes → Git Flow
  │     └─► No ↓
  │
  ├─► "Do you have multiple environments?"
  │     ├─► Yes → GitLab Flow
  │     └─► No → GitHub Flow
```

### Team Size Recommendations

| Team Size | Recommended Strategy |
|-----------|---------------------|
| 1-3 | Trunk-Based |
| 4-10 | GitHub Flow |
| 10-30 | GitHub Flow or Git Flow |
| 30+ | Git Flow or GitLab Flow |

---

## Related Resources

- [CLAUDE.md](../CLAUDE.md) - Branch naming conventions
- [CONTRIBUTING.md](../templates/CONTRIBUTING.md) - Contribution guidelines
- [Feature Flags Guide](../architecture/FEATURE_FLAGS.md) - Feature flag patterns
