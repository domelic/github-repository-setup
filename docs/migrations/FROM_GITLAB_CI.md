# Migrating from GitLab CI to GitHub Actions

This guide helps you migrate your CI/CD pipelines from GitLab CI to GitHub Actions.

## Quick Comparison

| Concept | GitLab CI | GitHub Actions |
|---------|-----------|----------------|
| Config file | `.gitlab-ci.yml` | `.github/workflows/*.yml` |
| Stages | `stages:` | Jobs with `needs:` |
| Variables | `variables:` | `env:` |
| Caching | `cache:` | `actions/cache@v4` |
| Artifacts | `artifacts:` | `actions/upload-artifact@v4` |
| Includes | `include:` | Reusable workflows |
| Triggers | `rules:`/`only:`/`except:` | `on:` |

## Basic Conversion

### GitLab CI

```yaml
# .gitlab-ci.yml
stages:
  - build
  - test
  - deploy

variables:
  NODE_ENV: production

cache:
  paths:
    - node_modules/

build:
  stage: build
  image: node:20
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour

test:
  stage: test
  image: node:20
  script:
    - npm ci
    - npm test
  coverage: '/Coverage: \d+.\d+%/'

deploy:
  stage: deploy
  image: node:20
  script:
    - npm run deploy
  only:
    - main
  when: manual
  environment:
    name: production
    url: https://example.com
```

### GitHub Actions Equivalent

```yaml
# .github/workflows/ci.yml
name: CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  NODE_ENV: production

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build

      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: dist
          path: dist/
          retention-days: 1

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

  deploy:
    needs: [build, test]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    environment:
      name: production
      url: https://example.com

    steps:
      - uses: actions/checkout@v4

      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: dist
          path: dist/

      - name: Deploy
        run: npm run deploy
```

## Concept Mapping

### Stages to Jobs

**GitLab CI:**
```yaml
stages:
  - build
  - test
  - deploy

build:
  stage: build
  script: make build

test:
  stage: test
  script: make test

deploy:
  stage: deploy
  script: make deploy
```

**GitHub Actions:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: make build

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: make test

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: make deploy
```

### Rules to Conditions

**GitLab CI:**
```yaml
deploy:
  rules:
    - if: $CI_COMMIT_BRANCH == "main"
      when: manual
    - if: $CI_COMMIT_TAG
      when: always
    - when: never
```

**GitHub Actions:**
```yaml
deploy:
  if: |
    github.ref == 'refs/heads/main' ||
    startsWith(github.ref, 'refs/tags/')
  environment:
    name: production  # For manual approval, add protection rules
```

### Variables and Secrets

**GitLab CI:**
```yaml
variables:
  GLOBAL_VAR: "value"

job:
  variables:
    JOB_VAR: "local"
  script:
    - echo $GLOBAL_VAR
    - echo $SECRET_VAR  # From CI/CD settings
```

**GitHub Actions:**
```yaml
env:
  GLOBAL_VAR: "value"

jobs:
  job:
    runs-on: ubuntu-latest
    env:
      JOB_VAR: "local"
    steps:
      - run: |
          echo $GLOBAL_VAR
          echo ${{ secrets.SECRET_VAR }}
```

### Caching

**GitLab CI:**
```yaml
cache:
  key:
    files:
      - package-lock.json
  paths:
    - node_modules/
```

**GitHub Actions:**
```yaml
- uses: actions/cache@v4
  with:
    path: node_modules
    key: ${{ runner.os }}-npm-${{ hashFiles('package-lock.json') }}
```

### Artifacts

**GitLab CI:**
```yaml
build:
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
    reports:
      junit: test-results.xml
```

**GitHub Actions:**
```yaml
- uses: actions/upload-artifact@v4
  with:
    name: dist
    path: dist/
    retention-days: 7

# For test reports
- uses: dorny/test-reporter@v1
  with:
    name: Test Results
    path: test-results.xml
    reporter: java-junit
```

### Services

**GitLab CI:**
```yaml
test:
  services:
    - postgres:16
    - redis:7
  variables:
    POSTGRES_DB: test
    POSTGRES_USER: test
    POSTGRES_PASSWORD: test
  script:
    - npm test
```

**GitHub Actions:**
```yaml
test:
  runs-on: ubuntu-latest
  services:
    postgres:
      image: postgres:16
      env:
        POSTGRES_DB: test
        POSTGRES_USER: test
        POSTGRES_PASSWORD: test
      ports:
        - 5432:5432
    redis:
      image: redis:7
      ports:
        - 6379:6379
  steps:
    - run: npm test
```

### Include/Extends

**GitLab CI:**
```yaml
include:
  - template: Jobs/Build.gitlab-ci.yml
  - local: .gitlab/ci/test.yml
  - remote: https://example.com/ci-templates/deploy.yml

.base_job:
  before_script:
    - npm ci

test:
  extends: .base_job
  script:
    - npm test
```

**GitHub Actions:**
```yaml
# Reusable workflow: .github/workflows/build.yml
on:
  workflow_call:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run build

# Main workflow
jobs:
  build:
    uses: ./.github/workflows/build.yml

  # Or from another repo
  deploy:
    uses: org/repo/.github/workflows/deploy.yml@main
    secrets: inherit
```

### Environments

**GitLab CI:**
```yaml
deploy:
  environment:
    name: production
    url: https://example.com
    on_stop: stop_deployment
  when: manual
```

**GitHub Actions:**
```yaml
deploy:
  environment:
    name: production
    url: https://example.com
  # Configure protection rules in repository settings
```

### Matrix Builds

**GitLab CI:**
```yaml
test:
  parallel:
    matrix:
      - NODE: ['18', '20']
        DB: ['postgres', 'mysql']
  image: node:$NODE
  script:
    - npm test
```

**GitHub Actions:**
```yaml
test:
  strategy:
    matrix:
      node: ['18', '20']
      db: ['postgres', 'mysql']
  runs-on: ubuntu-latest
  steps:
    - uses: actions/setup-node@v4
      with:
        node-version: ${{ matrix.node }}
    - run: npm test
      env:
        DATABASE: ${{ matrix.db }}
```

### Scheduled Pipelines

**GitLab CI:**
```yaml
# Configured in GitLab UI: CI/CD → Schedules
# Or via API
nightly:
  rules:
    - if: $CI_PIPELINE_SOURCE == "schedule"
  script:
    - ./nightly-job.sh
```

**GitHub Actions:**
```yaml
on:
  schedule:
    - cron: '0 0 * * *'

jobs:
  nightly:
    runs-on: ubuntu-latest
    steps:
      - run: ./nightly-job.sh
```

## Migration Checklist

- [ ] Create `.github/workflows/` directory
- [ ] Convert `.gitlab-ci.yml` to GitHub Actions workflow(s)
- [ ] Migrate CI/CD variables to GitHub Secrets/Variables
- [ ] Convert caching strategy
- [ ] Set up environments with protection rules
- [ ] Configure branch protection rules
- [ ] Migrate scheduled pipelines
- [ ] Update container registry references (if using GitLab Container Registry)
- [ ] Test workflow on a branch before merging
- [ ] Update README.md badges
- [ ] Remove `.gitlab-ci.yml` after successful migration

## Common Gotchas

1. **Parallel jobs**: GitLab runs stage jobs in parallel by default; use `needs:` in GitHub Actions
2. **Hidden jobs**: Use `name: _job` convention or just don't include in workflow
3. **Merge request pipelines**: Use `pull_request` event
4. **Protected variables**: Use GitHub Environments with protection rules
5. **Child pipelines**: Use reusable workflows

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Migrating from GitLab CI/CD](https://docs.github.com/en/actions/migrating-to-github-actions/migrating-from-gitlab-ci-cd-to-github-actions)
