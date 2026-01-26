# Migrating from Travis CI to GitHub Actions

This guide helps you migrate your CI/CD pipelines from Travis CI to GitHub Actions.

## Quick Comparison

| Concept | Travis CI | GitHub Actions |
|---------|-----------|----------------|
| Config file | `.travis.yml` | `.github/workflows/*.yml` |
| Stages | `stages:` | `jobs:` |
| Build matrix | `matrix:` | `strategy.matrix:` |
| Caching | `cache:` | `actions/cache@v4` |
| Secrets | Repository Settings | Repository Settings → Secrets |
| Artifacts | Travis artifacts | `actions/upload-artifact@v4` |

## Basic Conversion

### Travis CI

```yaml
# .travis.yml
language: node_js
node_js:
  - "18"
  - "20"

cache:
  directories:
    - node_modules

install:
  - npm ci

script:
  - npm test
  - npm run build

after_success:
  - npm run coverage

deploy:
  provider: npm
  skip_cleanup: true
  api_key: $NPM_TOKEN
  on:
    tags: true
```

### GitHub Actions Equivalent

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20]

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Upload coverage
        if: success()
        run: npm run coverage

  publish:
    needs: test
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/')
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          registry-url: 'https://registry.npmjs.org'

      - run: npm ci
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

## Concept Mapping

### Lifecycle Hooks

| Travis CI | GitHub Actions |
|-----------|----------------|
| `before_install` | Step before `npm ci` |
| `install` | Step with `npm ci` |
| `before_script` | Steps before main script |
| `script` | Main test/build steps |
| `after_success` | Step with `if: success()` |
| `after_failure` | Step with `if: failure()` |
| `after_script` | Step with `if: always()` |
| `deploy` | Separate job with conditions |

### Build Matrix

**Travis CI:**
```yaml
language: python
python:
  - "3.10"
  - "3.11"
  - "3.12"
env:
  - DATABASE=postgres
  - DATABASE=mysql
```

**GitHub Actions:**
```yaml
jobs:
  test:
    strategy:
      matrix:
        python-version: ['3.10', '3.11', '3.12']
        database: [postgres, mysql]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
```

### Caching

**Travis CI:**
```yaml
cache:
  directories:
    - node_modules
    - ~/.cache/pip
```

**GitHub Actions:**
```yaml
- uses: actions/cache@v4
  with:
    path: |
      node_modules
      ~/.cache/pip
    key: ${{ runner.os }}-${{ hashFiles('**/package-lock.json', '**/requirements.txt') }}
```

Or use built-in caching:

```yaml
- uses: actions/setup-node@v4
  with:
    node-version: '20'
    cache: 'npm'  # Automatic caching
```

### Services

**Travis CI:**
```yaml
services:
  - docker
  - postgresql
  - redis
```

**GitHub Actions:**
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_PASSWORD: postgres
        ports:
          - 5432:5432
      redis:
        image: redis:7
        ports:
          - 6379:6379
```

### Environment Variables

**Travis CI:**
```yaml
env:
  global:
    - CI=true
    - NODE_ENV=test
  matrix:
    - DB=postgres
    - DB=mysql
```

**GitHub Actions:**
```yaml
env:
  CI: true
  NODE_ENV: test

jobs:
  test:
    strategy:
      matrix:
        db: [postgres, mysql]
    env:
      DB: ${{ matrix.db }}
```

### Conditional Builds

**Travis CI:**
```yaml
branches:
  only:
    - main
    - /^v\d+\.\d+(\.\d+)?(-\S*)?$/

if: branch = main OR tag IS present
```

**GitHub Actions:**
```yaml
on:
  push:
    branches: [main]
    tags: ['v*']
  pull_request:
    branches: [main]

jobs:
  deploy:
    if: startsWith(github.ref, 'refs/tags/v')
```

### Deployment

**Travis CI:**
```yaml
deploy:
  - provider: pages
    skip_cleanup: true
    github_token: $GITHUB_TOKEN
    local_dir: build
    on:
      branch: main

  - provider: heroku
    api_key: $HEROKU_API_KEY
    app: my-app
    on:
      branch: main
```

**GitHub Actions:**
```yaml
# GitHub Pages
- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v4
  if: github.ref == 'refs/heads/main'
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./build

# Heroku
- name: Deploy to Heroku
  uses: akhileshns/heroku-deploy@v3
  if: github.ref == 'refs/heads/main'
  with:
    heroku_api_key: ${{ secrets.HEROKU_API_KEY }}
    heroku_app_name: my-app
    heroku_email: ${{ secrets.HEROKU_EMAIL }}
```

## Migration Checklist

- [ ] Create `.github/workflows/` directory
- [ ] Convert `.travis.yml` to GitHub Actions workflow
- [ ] Migrate encrypted environment variables to GitHub Secrets
- [ ] Update caching strategy
- [ ] Convert build matrix to `strategy.matrix`
- [ ] Update deployment configuration
- [ ] Test workflow on a branch before merging
- [ ] Update badge in README.md
- [ ] Remove `.travis.yml` after successful migration
- [ ] Cancel Travis CI subscription (if applicable)

## Common Gotchas

1. **Default shell**: GitHub Actions uses `bash` by default, Travis uses `bash` for Linux/macOS
2. **Working directory**: Use `working-directory:` instead of `cd`
3. **Exit codes**: Use `continue-on-error: true` instead of `|| true`
4. **Artifacts**: Use `actions/upload-artifact` and `actions/download-artifact`
5. **Parallelism**: GitHub Actions jobs run in parallel by default

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Migrating from Travis CI](https://docs.github.com/en/actions/migrating-to-github-actions/migrating-from-travis-ci-to-github-actions)
