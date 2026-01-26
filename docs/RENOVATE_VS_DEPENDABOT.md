# Renovate vs Dependabot: Comparison Guide

Both Renovate and Dependabot automate dependency updates, but they have different strengths. This guide helps you choose the right tool for your project.

## Quick Comparison

| Feature | Dependabot | Renovate |
|---------|------------|----------|
| Built into GitHub | Yes | No (GitHub App) |
| Configuration complexity | Simple | Advanced |
| Grouping updates | Limited | Extensive |
| Auto-merge | Via Actions | Built-in |
| Scheduling | Basic | Granular |
| Monorepo support | Basic | Excellent |
| Custom registries | Yes | Yes |
| Free tier | Unlimited | Unlimited |

## When to Use Dependabot

**Choose Dependabot if:**

- You want zero setup beyond a YAML file
- Your project is straightforward with few dependencies
- You prefer GitHub-native solutions
- You don't need advanced grouping or scheduling

**Dependabot strengths:**

- Native GitHub integration
- Security alerts integration
- Simple configuration
- No external app needed

### Dependabot Example

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    labels:
      - "dependencies"
    open-pull-requests-limit: 10
```

## When to Use Renovate

**Choose Renovate if:**

- You have a monorepo
- You want fine-grained control over updates
- You need advanced grouping (e.g., all React packages together)
- You want auto-merge with conditions
- You need to manage many repositories

**Renovate strengths:**

- Powerful grouping and scheduling
- Built-in auto-merge
- Dependency Dashboard
- Regex managers for custom versioning
- Preset configurations

### Renovate Example

```json
{
  "extends": ["config:recommended"],
  "automerge": true,
  "packageRules": [
    {
      "matchPackagePatterns": ["^react"],
      "groupName": "React"
    }
  ]
}
```

## Feature Deep Dive

### Grouping Dependencies

**Dependabot:**
- Groups updates by ecosystem only
- Each package gets a separate PR

**Renovate:**
- Group by package name patterns
- Group by update type (major, minor, patch)
- Group all non-major updates together

```json
// Renovate: Group all non-major updates
{
  "extends": ["group:allNonMajor"]
}
```

### Auto-Merge

**Dependabot:**
- Requires GitHub Actions workflow
- More setup required

```yaml
# .github/workflows/dependabot-automerge.yml
name: Dependabot auto-merge
on: pull_request
permissions:
  contents: write
  pull-requests: write
jobs:
  automerge:
    runs-on: ubuntu-latest
    if: github.actor == 'dependabot[bot]'
    steps:
      - uses: dependabot/fetch-metadata@v2
        id: metadata
      - if: steps.metadata.outputs.update-type == 'version-update:semver-patch'
        run: gh pr merge --auto --squash "$PR_URL"
        env:
          PR_URL: ${{ github.event.pull_request.html_url }}
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Renovate:**
- Built-in auto-merge
- Configurable per package

```json
{
  "automerge": true,
  "automergeType": "pr",
  "packageRules": [
    {
      "matchUpdateTypes": ["patch"],
      "automerge": true
    }
  ]
}
```

### Scheduling

**Dependabot:**
- `daily`, `weekly`, `monthly`
- Specific day/time

**Renovate:**
- Cron-like scheduling
- Timezone support
- Presets like `schedule:weekends`

```json
{
  "schedule": ["after 10pm and before 5am every weekday", "every weekend"]
}
```

### Monorepo Support

**Dependabot:**
- Configure each directory separately
- No cross-directory grouping

**Renovate:**
- Automatic detection
- Cross-package grouping
- Workspace support

```json
{
  "packageRules": [
    {
      "matchPaths": ["packages/**"],
      "groupName": "Workspace packages"
    }
  ]
}
```

## Migration Guide

### From Dependabot to Renovate

1. Install Renovate GitHub App
2. Create `renovate.json`:

```json
{
  "extends": ["config:recommended"],
  "labels": ["dependencies"],
  "schedule": ["every weekend"]
}
```

3. Optionally keep `.github/dependabot.yml` for security alerts
4. Disable Dependabot PRs:

```yaml
# .github/dependabot.yml
version: 2
updates: []  # Empty to disable
```

### From Renovate to Dependabot

1. Remove `renovate.json`
2. Disable Renovate in repository settings
3. Create `.github/dependabot.yml`
4. Set up auto-merge workflow if needed

## Recommendations by Project Type

### Small Projects (< 20 dependencies)

**Recommendation: Dependabot**

Simple setup, works well for straightforward projects.

### Large Projects / Monorepos

**Recommendation: Renovate**

Better grouping, scheduling, and monorepo support.

### Enterprise / Many Repositories

**Recommendation: Renovate**

Shareable presets, Dependency Dashboard, better scalability.

### Security-Focused Projects

**Recommendation: Both**

Use Dependabot for security alerts, Renovate for updates.

```yaml
# .github/dependabot.yml
version: 2
updates: []  # Disable regular updates
registries:
  npm:
    type: npm-registry
    url: https://registry.npmjs.org
```

## Templates

- [`dependabot.yml`](../templates/dependabot.yml) - Basic Dependabot config
- [`dependabot-full.yml`](../templates/dependabot-full.yml) - Full Dependabot config
- [`renovate.json`](../templates/renovate.json) - Renovate config

## Resources

- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)
- [Renovate Documentation](https://docs.renovatebot.com/)
- [Renovate Presets](https://docs.renovatebot.com/presets-default/)
- [Renovate GitHub App](https://github.com/apps/renovate)
