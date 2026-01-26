# Migrating from CircleCI to GitHub Actions

This guide helps you migrate your CI/CD pipelines from CircleCI to GitHub Actions.

## Quick Comparison

| Concept | CircleCI | GitHub Actions |
|---------|----------|----------------|
| Config file | `.circleci/config.yml` | `.github/workflows/*.yml` |
| Reusable config | Orbs | Actions |
| Executors | `executors:` | `runs-on:` |
| Jobs | `jobs:` | `jobs:` |
| Workflows | `workflows:` | Within each workflow file |
| Caching | `save_cache`/`restore_cache` | `actions/cache@v4` |
| Workspaces | `persist_to_workspace`/`attach_workspace` | Artifacts or outputs |

## Basic Conversion

### CircleCI

```yaml
# .circleci/config.yml
version: 2.1

orbs:
  node: circleci/node@5

executors:
  node-executor:
    docker:
      - image: cimg/node:20.0

jobs:
  build:
    executor: node-executor
    steps:
      - checkout
      - node/install-packages:
          pkg-manager: npm
      - run:
          name: Run tests
          command: npm test
      - run:
          name: Build
          command: npm run build
      - persist_to_workspace:
          root: .
          paths:
            - dist

  deploy:
    executor: node-executor
    steps:
      - attach_workspace:
          at: .
      - run:
          name: Deploy
          command: npm run deploy

workflows:
  build-and-deploy:
    jobs:
      - build
      - deploy:
          requires:
            - build
          filters:
            branches:
              only: main
```

### GitHub Actions Equivalent

```yaml
# .github/workflows/build-and-deploy.yml
name: Build and Deploy

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

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: dist
          path: dist

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    steps:
      - uses: actions/checkout@v4

      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: dist
          path: dist

      - name: Deploy
        run: npm run deploy
```

## Concept Mapping

### Orbs to Actions

| CircleCI Orb | GitHub Action |
|--------------|---------------|
| `circleci/node` | `actions/setup-node` |
| `circleci/python` | `actions/setup-python` |
| `circleci/go` | `actions/setup-go` |
| `circleci/ruby` | `ruby/setup-ruby` |
| `circleci/docker` | `docker/build-push-action` |
| `circleci/aws-cli` | `aws-actions/configure-aws-credentials` |
| `circleci/gcp-gcr` | `google-github-actions/auth` |

### Executors

**CircleCI:**
```yaml
executors:
  my-executor:
    docker:
      - image: cimg/node:20.0
    resource_class: medium
```

**GitHub Actions:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest  # or ubuntu-22.04, macos-latest, windows-latest
    container:
      image: node:20
```

### Caching

**CircleCI:**
```yaml
- restore_cache:
    keys:
      - v1-deps-{{ checksum "package-lock.json" }}
      - v1-deps-

- run: npm ci

- save_cache:
    key: v1-deps-{{ checksum "package-lock.json" }}
    paths:
      - node_modules
```

**GitHub Actions:**
```yaml
- uses: actions/cache@v4
  with:
    path: node_modules
    key: ${{ runner.os }}-npm-${{ hashFiles('package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-npm-

- run: npm ci
```

### Workspaces to Artifacts

**CircleCI:**
```yaml
# Save
- persist_to_workspace:
    root: .
    paths:
      - dist
      - node_modules

# Restore
- attach_workspace:
    at: .
```

**GitHub Actions:**
```yaml
# Save
- uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: |
      dist
      node_modules

# Restore
- uses: actions/download-artifact@v4
  with:
    name: build-output
```

### Parallelism

**CircleCI:**
```yaml
jobs:
  test:
    parallelism: 4
    steps:
      - run:
          command: |
            TEST_FILES=$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split)
            bundle exec rspec $TEST_FILES
```

**GitHub Actions:**
```yaml
jobs:
  test:
    strategy:
      matrix:
        shard: [1, 2, 3, 4]
    steps:
      - run: |
          npm test -- --shard=${{ matrix.shard }}/4
```

### Context and Secrets

**CircleCI:**
```yaml
workflows:
  deploy:
    jobs:
      - deploy:
          context:
            - production-secrets
```

**GitHub Actions:**
```yaml
jobs:
  deploy:
    environment: production
    steps:
      - run: echo ${{ secrets.PRODUCTION_SECRET }}
```

### Scheduled Jobs

**CircleCI:**
```yaml
workflows:
  nightly:
    triggers:
      - schedule:
          cron: "0 0 * * *"
          filters:
            branches:
              only: main
    jobs:
      - nightly-job
```

**GitHub Actions:**
```yaml
on:
  schedule:
    - cron: '0 0 * * *'

jobs:
  nightly-job:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
```

### Conditional Steps

**CircleCI:**
```yaml
- when:
    condition: << pipeline.git.branch >> == "main"
    steps:
      - run: deploy.sh
```

**GitHub Actions:**
```yaml
- name: Deploy
  if: github.ref == 'refs/heads/main'
  run: ./deploy.sh
```

### Matrix Builds

**CircleCI:**
```yaml
jobs:
  test:
    parameters:
      version:
        type: string
    docker:
      - image: cimg/node:<< parameters.version >>

workflows:
  test-multiple:
    jobs:
      - test:
          matrix:
            parameters:
              version: ["18.0", "20.0"]
```

**GitHub Actions:**
```yaml
jobs:
  test:
    strategy:
      matrix:
        node-version: ['18', '20']
    runs-on: ubuntu-latest
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
```

## Migration Checklist

- [ ] Create `.github/workflows/` directory
- [ ] Convert `.circleci/config.yml` to GitHub Actions workflow(s)
- [ ] Replace Orbs with equivalent Actions
- [ ] Migrate Context secrets to GitHub Secrets/Environments
- [ ] Convert caching strategy
- [ ] Update workspace to artifact-based sharing
- [ ] Migrate scheduled workflows
- [ ] Test workflow on a branch before merging
- [ ] Update README.md badges
- [ ] Remove `.circleci/` directory after successful migration

## Common Gotchas

1. **Multiple workflows**: GitHub Actions uses separate files per workflow
2. **Environment variables**: Use `${{ env.VAR }}` or `$VAR` in run steps
3. **Docker layer caching**: Use `docker/build-push-action` with cache
4. **Approval gates**: Use `environment:` with protection rules
5. **Reusable workflows**: Create `.github/workflows/reusable-*.yml`

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Migrating from CircleCI](https://docs.github.com/en/actions/migrating-to-github-actions/migrating-from-circleci-to-github-actions)
