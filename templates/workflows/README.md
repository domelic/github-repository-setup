# Workflow Templates

This directory contains 70 GitHub Actions workflow templates organized by category. Copy the workflows you need to your `.github/workflows/` directory.

## Quick Start

```bash
# Copy a single workflow
cp templates/workflows/ci-nodejs.yml .github/workflows/

# Copy multiple workflows
cp templates/workflows/{ci-nodejs,release-please,deploy-vercel}.yml .github/workflows/
```

---

## Categories

- [CI/Testing](#citesting) — Continuous integration for various languages
- [Deployment](#deployment) — Deploy to cloud platforms and services
- [Publishing](#publishing) — Publish packages to registries
- [Security](#security) — Security scanning and analysis
- [Release Management](#release-management) — Automated releases and changelogs
- [Documentation](#documentation) — Docs, linting, and link checking
- [Community](#community) — Contributor engagement
- [Notifications](#notifications) — Alerts to Slack, Discord, etc.

---

## CI/Testing

Continuous integration workflows for building, testing, and validating code.

| Workflow | File | Description |
|----------|------|-------------|
| **CI (Generic)** | `ci.yml` | Basic CI template |
| **CI (Cross-Platform)** | `ci-cross-os.yml` | Test on Linux, macOS, Windows |
| **Node.js** | `ci-nodejs.yml` | Node.js with npm/yarn/pnpm |
| **Python** | `ci-python.yml` | Python with pip/poetry |
| **Go** | `ci-go.yml` | Go modules |
| **Rust** | `ci-rust.yml` | Cargo build and test |
| **Java** | `ci-java.yml` | Maven/Gradle |
| **Kotlin** | `ci-kotlin.yml` | Kotlin with Gradle |
| **Scala** | `ci-scala.yml` | sbt build |
| **.NET** | `ci-dotnet.yml` | .NET Core/5/6/7 |
| **Ruby** | `ci-ruby.yml` | Ruby with Bundler |
| **PHP** | `ci-php.yml` | PHP with Composer |
| **Elixir** | `ci-elixir.yml` | Mix build and test |
| **Swift** | `ci-swift.yml` | Swift Package Manager |
| **C/C++** | `ci-cpp.yml` | CMake/Make builds |
| **Terraform** | `ci-terraform.yml` | Terraform validate and plan |
| **Android** | `ci-android.yml` | Gradle for Android |
| **iOS** | `ci-ios.yml` | Xcode builds |
| **Flutter** | `ci-flutter.yml` | Flutter build and test |
| **React Native** | `ci-react-native.yml` | React Native CI |
| **E2E (Cypress)** | `e2e-cypress.yml` | Cypress end-to-end tests |
| **E2E (Playwright)** | `e2e-playwright.yml` | Playwright end-to-end tests |
| **Coverage** | `coverage.yml` | Code coverage reporting |
| **Format Check** | `format-check.yml` | Code formatting validation |

---

## Deployment

Deploy applications to cloud platforms and hosting services.

| Workflow | File | Description |
|----------|------|-------------|
| **GitHub Pages** | `deploy-github-pages.yml` | Static site to GitHub Pages |
| **Vercel** | `deploy-vercel.yml` | Deploy to Vercel |
| **Netlify** | `deploy-netlify.yml` | Deploy to Netlify |
| **Render** | `deploy-render.yml` | Deploy to Render |
| **Railway** | `deploy-railway.yml` | Deploy to Railway |
| **Fly.io** | `deploy-fly.yml` | Deploy to Fly.io |
| **DigitalOcean** | `deploy-digitalocean.yml` | Deploy to DO App Platform |
| **AWS S3** | `deploy-aws-s3.yml` | Static files to S3 |
| **AWS Lambda** | `deploy-aws-lambda.yml` | Serverless functions |
| **Azure App Service** | `deploy-azure-webapp.yml` | Azure Web Apps |
| **Azure Functions** | `deploy-azure-functions.yml` | Azure serverless |
| **Azure Container Apps** | `deploy-azure-container.yml` | Azure containers |
| **GCP Cloud Run** | `deploy-gcp-cloudrun.yml` | Google Cloud Run |
| **GCP Functions** | `deploy-gcp-functions.yml` | Google Cloud Functions |
| **GCP GKE** | `deploy-gcp-gke.yml` | Google Kubernetes Engine |
| **Kubernetes** | `deploy-kubernetes.yml` | Generic K8s deployment |

---

## Publishing

Publish packages to registries and marketplaces.

| Workflow | File | Description |
|----------|------|-------------|
| **npm** | `publish-npm.yml` | Publish to npm registry |
| **PyPI** | `publish-pypi.yml` | Publish Python packages |
| **crates.io** | `publish-crates.yml` | Publish Rust crates |
| **RubyGems** | `publish-rubygems.yml` | Publish Ruby gems |
| **NuGet** | `publish-nuget.yml` | Publish .NET packages |
| **Maven Central** | `publish-maven.yml` | Publish Java artifacts |
| **Docker Hub** | `publish-docker.yml` | Build and push Docker images |
| **Amazon KDP** | `amazon-kdp-publish.yml` | Kindle Direct Publishing |

---

## Security

Security scanning, vulnerability detection, and compliance.

| Workflow | File | Description |
|----------|------|-------------|
| **CodeQL** | `codeql.yml` | GitHub code scanning |
| **Dependency Review** | `dependency-review.yml` | PR dependency audit |
| **Trivy** | `trivy.yml` | Container/IaC vulnerability scan |
| **OpenSSF Scorecard** | `scorecard.yml` | Security health metrics |
| **SBOM Generation** | `sbom.yml` | Software Bill of Materials |

---

## Release Management

Automate versioning, changelogs, and releases.

| Workflow | File | Description |
|----------|------|-------------|
| **Release Please** | `release-please.yml` | Automated releases via conventional commits |
| **Release Drafter** | `release-drafter.yml` | Draft releases from PR labels |
| **Manual Release** | `release-manual.yml` | Workflow dispatch for releases |

---

## Documentation

Documentation generation, linting, and validation.

| Workflow | File | Description |
|----------|------|-------------|
| **API Docs** | `docs-api.yml` | Generate API documentation |
| **Markdown Lint** | `markdown-lint.yml` | Lint markdown files |
| **Spell Check** | `spell-check.yml` | Check spelling in docs |
| **Link Checker** | `link-checker.yml` | Validate URLs in docs |
| **Super-Linter** | `super-linter.yml` | Multi-language linter |
| **Commitlint** | `commitlint.yml` | Validate commit messages |
| **Lighthouse** | `lighthouse.yml` | Performance audits |

---

## Community

Contributor engagement and issue management.

| Workflow | File | Description |
|----------|------|-------------|
| **Welcome** | `welcome.yml` | Greet new contributors |
| **Stale** | `stale.yml` | Mark inactive issues/PRs |
| **All Contributors** | `all-contributors.yml` | Recognize contributors |
| **Auto Labeler** | `auto-labeler.yml` | Auto-label PRs by files changed |
| **Artifact Preview** | `artifact-preview.yml` | PR preview deployments |

---

## Notifications

Send alerts to external services.

| Workflow | File | Description |
|----------|------|-------------|
| **Slack** | `notify-slack.yml` | Post to Slack channels |
| **Discord** | `notify-discord.yml` | Post to Discord webhooks |

---

## Usage Tips

### Combining Workflows

Most projects need a combination of workflows. Common stacks:

**Node.js Web App:**
```bash
cp templates/workflows/{ci-nodejs,release-please,deploy-vercel,dependency-review}.yml .github/workflows/
```

**Python Package:**
```bash
cp templates/workflows/{ci-python,publish-pypi,release-please,codeql}.yml .github/workflows/
```

**Full-Stack with Docker:**
```bash
cp templates/workflows/{ci-nodejs,e2e-playwright,publish-docker,deploy-kubernetes}.yml .github/workflows/
```

### Customization

Each workflow includes comments explaining configuration options. Key things to customize:

1. **Triggers** — Adjust `on:` to match your branching strategy
2. **Versions** — Update language/tool versions for your project
3. **Secrets** — Add required secrets in repository settings
4. **Environments** — Configure deployment environments if needed

### Secrets Reference

Common secrets needed across workflows:

| Secret | Used By |
|--------|---------|
| `NPM_TOKEN` | publish-npm |
| `PYPI_API_TOKEN` | publish-pypi |
| `DOCKER_USERNAME`, `DOCKER_PASSWORD` | publish-docker |
| `VERCEL_TOKEN` | deploy-vercel |
| `NETLIFY_AUTH_TOKEN` | deploy-netlify |
| `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | deploy-aws-* |
| `AZURE_CREDENTIALS` | deploy-azure-* |
| `GCP_CREDENTIALS` | deploy-gcp-* |
| `SLACK_WEBHOOK_URL` | notify-slack |
| `DISCORD_WEBHOOK_URL` | notify-discord |

---

## See Also

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [/github-setup skill](../commands/github-setup.md) — Interactive setup wizard
