# 5-Minute GitHub Repository Setup

Get your GitHub repository configured with production-grade automation in minutes.

## Prerequisites

Before you begin, ensure you have:

- **GitHub CLI** (`gh`) installed and authenticated
  ```bash
  # Install (macOS)
  brew install gh

  # Or install (other platforms)
  # See: https://cli.github.com/

  # Authenticate
  gh auth login
  ```

- **Claude Code CLI** installed
  ```bash
  # Install
  npm install -g @anthropic-ai/claude-code
  ```

## Step 1: Run the Setup Wizard

Navigate to your repository and run:

```bash
/github-setup
```

This will:

1. **Detect your project type** (Node.js, Python, Go, Rust, etc.)
2. **Audit existing configuration** (what's missing vs. what exists)
3. **Guide you through setup** (category by category)

## Step 2: Choose Your Stack

### Quick Decision Tree

```text
What's your project type?
│
├─ Web Application
│  ├─ Node.js/TypeScript → /github-setup nodejs
│  ├─ Python/Django/Flask → /github-setup python
│  ├─ Go → /github-setup go
│  └─ Ruby/Rails → /github-setup ruby
│
├─ Mobile App
│  ├─ iOS (Swift) → /github-setup ios + /github-setup swift
│  ├─ Android (Kotlin) → /github-setup android + /github-setup kotlin
│  ├─ Flutter → /github-setup flutter
│  └─ React Native → /github-setup react-native
│
├─ Game Development
│  ├─ Godot → /github-setup godot
│  └─ Unity → /github-setup unity
│
├─ ML/AI Project
│  └─ Python + ML → /github-setup ml
│
├─ CLI Tool
│  ├─ Go binary → /github-setup go + /github-setup cli-tool
│  └─ Rust binary → /github-setup rust + /github-setup cli-tool
│
├─ Infrastructure
│  ├─ Terraform → /github-setup terraform
│  ├─ Kubernetes → /github-setup kubernetes
│  └─ Serverless → /github-setup serverless
│
└─ Documentation Only
   └─ /github-setup docs
```

### Common Preset Bundles

| Use Case | Recommended Presets |
|----------|---------------------|
| **Production Web App** | `nodejs` + `quality` + `security` + `deploy` + `releases` |
| **Open Source Library** | `{language}` + `docs` + `issues` + `releases` + `bots` |
| **Internal Tool** | `{language}` + `quality` + `notifications` |
| **Startup MVP** | `{language}` + `deploy` + `notifications` |
| **Enterprise Project** | `{language}` + `security` + `sonarcloud` + `snyk` + `multienv` |

## Step 3: Customize & Commit

After fetching templates, customize them for your project:

### Common Customizations

1. **Update workflow names**
   ```yaml
   # In .github/workflows/ci-*.yml
   name: CI  # Change to your preferred name
   ```

2. **Adjust branch protection**
   ```bash
   # Enable required reviews
   gh api repos/{owner}/{repo}/branches/main/protection -X PUT --input - <<'EOF'
   {
     "required_pull_request_reviews": {
       "required_approving_review_count": 1
     }
   }
   EOF
   ```

3. **Set up secrets**
   ```bash
   # Example: Add deployment secrets
   gh secret set DEPLOY_TOKEN --body "your-token"
   ```

4. **Configure Dependabot**
   ```yaml
   # Uncomment relevant package ecosystems in .github/dependabot.yml
   ```

### Commit Your Setup

```bash
git add .
git commit -m "chore: configure GitHub repository automation"
git push
```

## What's Next?

### Verify Your Setup

Run the checklist to confirm everything is configured:

```bash
/github-setup checklist
```

### Learn More

| Topic | Documentation |
|-------|---------------|
| Workflow templates | [templates/workflows/README.md](../../templates/workflows/README.md) |
| Branch protection | [docs/guides/BRANCHING_STRATEGIES.md](./BRANCHING_STRATEGIES.md) |
| Secret management | [docs/guides/SECRETS_MANAGEMENT.md](./SECRETS_MANAGEMENT.md) |
| Database testing | [docs/architecture/DATABASE_TESTING.md](../architecture/DATABASE_TESTING.md) |
| Monorepo patterns | [docs/architecture/MONOREPO_PATTERNS.md](../architecture/MONOREPO_PATTERNS.md) |
| Renovate vs Dependabot | [docs/workflows/RENOVATE_VS_DEPENDABOT.md](../workflows/RENOVATE_VS_DEPENDABOT.md) |

### Get Help

- **Full preset reference**: See [templates/commands/github-setup.md](../../templates/commands/github-setup.md)
- **Report issues**: [GitHub Discussions](https://github.com/domelic/github-repository-setup/discussions)
- **Contribute**: [CONTRIBUTING.md](../../CONTRIBUTING.md)

## Frequently Asked Questions

### Which preset should I use for a monorepo?

Start with your primary language preset, then add:

```bash
/github-setup monorepo  # Adds turbo.json and pnpm-workspace.yaml
```

### How do I set up notifications?

```bash
/github-setup notifications  # Slack + Discord
/github-setup teams          # Microsoft Teams
```

### How do I add security scanning?

```bash
/github-setup security   # CodeQL, Trivy, Scorecard
/github-setup snyk       # Snyk dependency scanning
/github-setup sonarcloud # Code quality analysis
```

### Can I use multiple presets together?

Yes! Presets are designed to be composable. Run them sequentially:

```bash
/github-setup nodejs
/github-setup quality
/github-setup security
/github-setup releases
```

### How do I update to newer templates?

Check the [releases page](https://github.com/domelic/github-repository-setup/releases) for updates. Update the version in your skill configuration and re-run the desired presets.
