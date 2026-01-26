# Template Customization Guide

This guide explains how to customize templates after fetching them from the repository.

## How Templates Work

Templates use GitHub Actions context variables that auto-populate when the workflow runs:

| Variable | Description | Example |
|----------|-------------|---------|
| `${{ github.repository }}` | Full repository name | `your-org/your-repo` |
| `${{ github.repository_owner }}` | Repository owner | `your-org` |
| `${{ github.event.repository.name }}` | Repository name only | `your-repo` |
| `${{ secrets.* }}` | Configured secrets | `${{ secrets.NPM_TOKEN }}` |
| `${{ vars.* }}` | Repository variables | `${{ vars.NODE_VERSION }}` |

**These don't need manual editing** - they work automatically in any repository.

---

## Common Customization Points

### Matrix Testing (Language CIs)

Most language CI workflows use matrix testing. Edit the `strategy.matrix` to match your needs:

```yaml
strategy:
  matrix:
    # Customize these values:
    node-version: [18, 20, 22]  # Node.js versions to test
    os: [ubuntu-latest]         # Operating systems
```

### Package Managers

Node.js workflows detect package managers automatically, but you can force one:

```yaml
# Edit the package manager detection
- name: Setup Node.js
  uses: actions/setup-node@v4
  with:
    node-version: ${{ matrix.node-version }}
    cache: 'npm'  # Change to 'yarn' or 'pnpm'
```

### Branch Names

Default branch triggers typically use `main`. Change if your default is different:

```yaml
on:
  push:
    branches: [main]  # Change to 'master' or your default
  pull_request:
    branches: [main]
```

---

## Customization by Template Category

### CI Workflows

#### ci-nodejs.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| Node versions | `[18, 20, 22]` | Edit `matrix.node-version` array |
| OS matrix | `[ubuntu-latest]` | Add `macos-latest`, `windows-latest` |
| Package manager | Auto-detected | Edit cache option in setup-node |
| Test command | `npm test` | Edit the "Run tests" step |

#### ci-python.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| Python versions | `['3.10', '3.11', '3.12']` | Edit `matrix.python-version` |
| Package manager | Auto-detected | Edit install step for poetry/pip/uv |
| Test command | `pytest` | Edit the "Run tests" step |

#### ci-go.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| Go versions | `['1.21', '1.22']` | Edit `matrix.go-version` |
| Test flags | `-v -race ./...` | Edit the "Run tests" step |
| Linter | `golangci-lint` | Add/remove linting step |

#### ci-rust.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| Rust toolchain | `stable` | Change to `nightly` or specific version |
| Components | `clippy, rustfmt` | Edit rustup components |
| Target | Default | Add cross-compilation targets |

### Deployment Workflows

#### deploy-vercel.yml

| Variable | How to Set |
|----------|------------|
| `VERCEL_TOKEN` | Secret: Vercel API token |
| `VERCEL_ORG_ID` | Secret: From `vercel link` |
| `VERCEL_PROJECT_ID` | Secret: From `vercel link` |

#### deploy-aws-s3.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| `AWS_REGION` | Repository variable | Set `vars.AWS_REGION` or edit workflow |
| `S3_BUCKET` | Repository variable | Set `vars.S3_BUCKET` |
| Build output | `dist/` | Edit the sync source path |

#### deploy-kubernetes.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| Namespace | `default` | Edit `kubectl` commands |
| Manifest path | `k8s/` | Edit manifest file paths |
| Image tag | `${{ github.sha }}` | Edit tagging strategy |

### Publishing Workflows

#### publish-docker.yml / publish-docker-hub.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| Image name | `${{ github.repository }}` | Edit `docker/metadata-action` tags |
| Platforms | `linux/amd64` | Add `linux/arm64` to platforms |
| Build args | None | Add `build-args` to docker/build-push-action |

#### publish-npm.yml

| Variable | Default | How to Customize |
|----------|---------|------------------|
| Registry | `registry.npmjs.org` | Change to GitHub Packages or private |
| Access | `public` | Change to `restricted` for scoped packages |
| Provenance | `true` | Disable if not using npm provenance |

---

## Using Repository Variables

Instead of editing workflows, use GitHub repository variables for common customizations:

```yaml
# In your workflow
env:
  NODE_VERSION: ${{ vars.NODE_VERSION || '20' }}
  AWS_REGION: ${{ vars.AWS_REGION || 'us-east-1' }}
```

Set these in **Settings → Secrets and variables → Actions → Variables**.

---

## Environment-Specific Customization

For multi-environment deployments, use GitHub Environments:

1. Create environments in **Settings → Environments**
   - `development`
   - `staging`
   - `production`

2. Set environment-specific variables and secrets
3. Workflows reference them:

```yaml
jobs:
  deploy:
    environment: production
    steps:
      - name: Deploy
        env:
          API_URL: ${{ vars.API_URL }}  # Environment-specific
```

---

## Template Inheritance Patterns

### Extending a Workflow

To add steps to an existing workflow without modifying the original:

```yaml
# my-custom-ci.yml
name: Custom CI

on:
  push:
    branches: [main]

jobs:
  base-ci:
    uses: ./.github/workflows/ci-nodejs.yml  # Reuse existing

  custom-steps:
    needs: base-ci
    runs-on: ubuntu-latest
    steps:
      - name: Additional custom step
        run: echo "Custom logic here"
```

### Workflow Inputs

Some workflows support inputs for customization:

```yaml
jobs:
  call-workflow:
    uses: ./.github/workflows/reusable-workflow.yml
    with:
      node-version: '20'
      coverage-threshold: 80
    secrets: inherit
```

---

## Quick Reference

### Files That Usually Need Customization

| File | What to Customize |
|------|-------------------|
| `ci-*.yml` | Matrix versions, test commands |
| `deploy-*.yml` | Environment URLs, region settings |
| `publish-*.yml` | Registry URLs, package names |
| `release-please-config.json` | Package paths, release types |
| `dependabot.yml` | Ecosystems, directories, schedules |

### Files That Auto-Configure

| File | Auto-Configures |
|------|-----------------|
| `.editorconfig` | Works universally |
| `.gitignore-*` | Language-appropriate ignores |
| `CODEOWNERS` | Uses GitHub usernames from repo |
| Issue templates | Work universally |

---

## Troubleshooting

### "Secret not found" Errors

Ensure secrets are set in **Settings → Secrets and variables → Actions → Secrets**.

### Matrix Job Failures

If some matrix combinations fail:
- Check version compatibility
- Use `continue-on-error: true` for experimental versions
- Use `exclude` in matrix to skip known-bad combinations

### Workflow Not Triggering

Check:
- Branch protection rules aren't blocking
- `on:` triggers match your workflow
- File paths in `paths:` filter are correct

---

## Related Resources

- [Workflow Metadata](../../templates/workflows/workflow-metadata.yaml) - Full workflow documentation
- [Presets](../../templates/presets.yaml) - Preset definitions with templates
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
