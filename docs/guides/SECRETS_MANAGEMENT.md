# Secrets Management Guide

Best practices for managing secrets in GitHub Actions workflows.

---

## Table of Contents

1. [Secret Types](#secret-types)
2. [Creating Secrets](#creating-secrets)
3. [Using Secrets in Workflows](#using-secrets-in-workflows)
4. [Environment Secrets](#environment-secrets)
5. [OIDC Authentication](#oidc-authentication)
6. [Secret Rotation](#secret-rotation)
7. [Security Best Practices](#security-best-practices)
8. [Common Patterns](#common-patterns)

---

## Secret Types

GitHub provides several types of secrets for different use cases:

| Type | Scope | Best For |
|------|-------|----------|
| **Repository secrets** | Single repository | Project-specific tokens |
| **Environment secrets** | Specific environment (production, staging) | Deployment credentials |
| **Organization secrets** | All/selected repos in org | Shared credentials |
| **Dependabot secrets** | Dependabot workflows only | Private registry access |

---

## Creating Secrets

### Via GitHub CLI

```bash
# Repository secret
gh secret set SECRET_NAME --body "secret-value"
gh secret set SECRET_NAME < secret-file.txt

# From environment variable
gh secret set NPM_TOKEN --body "$NPM_TOKEN"

# Organization secret (requires org admin)
gh secret set SECRET_NAME --org my-org --body "secret-value"

# Environment secret
gh secret set SECRET_NAME --env production --body "secret-value"
```

### Via GitHub UI

1. Go to **Settings > Secrets and variables > Actions**
2. Click **New repository secret**
3. Enter name (uppercase with underscores: `MY_SECRET_NAME`)
4. Enter value
5. Click **Add secret**

---

## Using Secrets in Workflows

### Basic Usage

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to production
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: |
          # Secret is available as environment variable
          ./deploy.sh
```

### Masking Secrets

GitHub automatically masks secrets in logs. To mask dynamic values:

```yaml
- name: Generate and mask token
  run: |
    TOKEN=$(generate-token)
    echo "::add-mask::$TOKEN"
    echo "TOKEN=$TOKEN" >> $GITHUB_ENV
```

### Secrets in Composite Actions

Pass secrets explicitly (they're not inherited):

```yaml
# In workflow
- uses: ./.github/actions/deploy
  with:
    api-key: ${{ secrets.API_KEY }}

# In composite action
inputs:
  api-key:
    required: true
runs:
  steps:
    - run: deploy --key ${{ inputs.api-key }}
```

---

## Environment Secrets

Use environments for deployment-specific secrets with additional protection.

### Creating an Environment

1. Go to **Settings > Environments**
2. Click **New environment**
3. Add protection rules:
   - Required reviewers
   - Wait timer
   - Deployment branches

### Using Environment Secrets

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production  # Activates environment secrets
    steps:
      - name: Deploy
        env:
          DATABASE_URL: ${{ secrets.DATABASE_URL }}  # From 'production' environment
        run: ./deploy.sh
```

### Environment Protection Rules

```yaml
jobs:
  deploy-staging:
    environment: staging
    # No approval needed

  deploy-production:
    environment: production
    needs: deploy-staging
    # Requires approval if configured
```

---

## OIDC Authentication

OpenID Connect (OIDC) eliminates the need for long-lived secrets by providing short-lived tokens.

### Supported Providers

| Provider | Documentation |
|----------|--------------|
| AWS | [configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials) |
| Azure | [azure/login](https://github.com/Azure/login) |
| GCP | [auth](https://github.com/google-github-actions/auth) |
| PyPI | [Trusted Publishing](https://docs.pypi.org/trusted-publishers/) |
| npm | [Provenance](https://docs.npmjs.com/generating-provenance-statements) |

### AWS OIDC Example

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
    steps:
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789:role/GitHubActions
          aws-region: us-east-1
      # No secrets needed - uses OIDC token
```

### PyPI OIDC (Trusted Publishing)

```yaml
jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
    environment: pypi
    steps:
      - uses: pypa/gh-action-pypi-publish@release/v1
        # No PYPI_TOKEN needed - uses OIDC
```

Setup at [pypi.org/manage/account/publishing](https://pypi.org/manage/account/publishing).

---

## Secret Rotation

### Automated Rotation

```yaml
name: Rotate Secrets

on:
  schedule:
    - cron: '0 0 1 * *'  # Monthly

jobs:
  rotate:
    runs-on: ubuntu-latest
    steps:
      - name: Generate new token
        id: new-token
        run: |
          NEW_TOKEN=$(openssl rand -hex 32)
          echo "token=$NEW_TOKEN" >> $GITHUB_OUTPUT

      - name: Update secret
        env:
          GH_TOKEN: ${{ secrets.ADMIN_TOKEN }}
        run: |
          gh secret set API_TOKEN --body "${{ steps.new-token.outputs.token }}"

      - name: Update external service
        run: |
          # Update the token in your service
          curl -X POST https://api.example.com/rotate-token \
            -H "Authorization: Bearer ${{ secrets.ADMIN_TOKEN }}" \
            -d '{"new_token": "${{ steps.new-token.outputs.token }}"}'
```

### Rotation Checklist

| Secret Type | Rotation Frequency | Method |
|-------------|-------------------|--------|
| API tokens | 90 days | Automated |
| SSH keys | Annually | Manual |
| OIDC | N/A | Auto-rotated |
| Service accounts | 90 days | Automated |

---

## Security Best Practices

### Do's

- Use OIDC when available (AWS, GCP, Azure, PyPI)
- Use environment secrets for production
- Enable required reviewers for production environments
- Audit secret access regularly
- Use least-privilege principle for tokens
- Rotate secrets on a schedule

### Don'ts

- Never log secrets (even partially)
- Never commit secrets to the repository
- Don't use secrets in pull request workflows from forks
- Don't share secrets across unrelated projects
- Don't use personal tokens for CI (create service accounts)

### Preventing Secret Exposure

```yaml
# Prevent secrets in PR workflows from forks
on:
  pull_request_target:  # Use carefully - runs in repo context
    types: [labeled]

jobs:
  build:
    if: github.event.label.name == 'safe to test'
    # Only runs after maintainer labels the PR
```

### Secret Scanning

Enable GitHub secret scanning:

1. Go to **Settings > Code security and analysis**
2. Enable **Secret scanning**
3. Enable **Push protection** (blocks commits with secrets)

---

## Common Patterns

### npm Publishing

```yaml
# Recommended: npm provenance (OIDC)
jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      id-token: write
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          registry-url: 'https://registry.npmjs.org'
      - run: npm publish --provenance
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

### Docker Registry

```yaml
jobs:
  push:
    runs-on: ubuntu-latest
    steps:
      - uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}  # Built-in token
```

### SSH Deployment

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Setup SSH
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          ssh-keyscan -H example.com >> ~/.ssh/known_hosts
      - run: rsync -avz ./dist/ user@example.com:/var/www/
```

### Multi-Environment Deployment

```yaml
jobs:
  deploy-staging:
    environment: staging
    runs-on: ubuntu-latest
    steps:
      - run: ./deploy.sh
        env:
          API_URL: ${{ vars.API_URL }}      # Environment variable
          API_KEY: ${{ secrets.API_KEY }}   # Environment secret

  deploy-production:
    needs: deploy-staging
    environment: production
    runs-on: ubuntu-latest
    steps:
      - run: ./deploy.sh
        env:
          API_URL: ${{ vars.API_URL }}      # Different value per environment
          API_KEY: ${{ secrets.API_KEY }}   # Different secret per environment
```

---

## Troubleshooting

### Secret Not Available

**Problem:** `Error: Secret not found`

**Causes:**
1. Secret name mismatch (case-sensitive)
2. Missing permissions for organization secrets
3. Environment not activated in job

**Fix:**
```yaml
jobs:
  build:
    environment: production  # Must specify environment for env secrets
    runs-on: ubuntu-latest
```

### Secret Appears as `***`

**Problem:** Secret value shows as `***` in logs

**This is expected behavior.** GitHub masks secrets automatically. If you need to debug:

```yaml
- run: |
    # Don't do this in production!
    echo "Length: ${#MY_SECRET}"
    echo "First char: ${MY_SECRET:0:1}"
```

### Fork PR Secrets

**Problem:** Secrets not available in PRs from forks

**This is a security feature.** Options:
1. Use `pull_request_target` with label protection
2. Split workflow: untrusted build, trusted deploy
3. Require contributors to test locally

---

## Resources

- [GitHub Docs: Encrypted Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitHub Docs: OIDC](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- [PyPI Trusted Publishers](https://docs.pypi.org/trusted-publishers/)
- [npm Provenance](https://docs.npmjs.com/generating-provenance-statements)
