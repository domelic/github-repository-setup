---
layout: default
title: Home
---

# GitHub Repository Setup Guide

Welcome to the documentation for the GitHub Repository Setup Guide.

## Quick Links

- [Main README](https://github.com/domelic/github-repository-setup#readme)
- [Quick Start Guide](guides/QUICK_START.md)

## Documentation

### Guides

Step-by-step tutorials and how-to documentation.

| Guide | Description |
|-------|-------------|
| [Quick Start](guides/QUICK_START.md) | Get started with repository setup |
| [Branching Strategies](guides/BRANCHING_STRATEGIES.md) | Git branching workflows |
| [CODEOWNERS Patterns](guides/CODEOWNERS_PATTERNS.md) | Code ownership configuration |
| [Secrets Management](guides/SECRETS_MANAGEMENT.md) | Secure credential handling |
| [Template Customization](guides/TEMPLATE_CUSTOMIZATION.md) | Customize templates for your needs |
| [Markdown Lint](guides/MARKDOWN_LINT.md) | Markdown linting configuration |

### Workflows

CI/CD and automation documentation.

| Document | Description |
|----------|-------------|
| [Workflow Diagrams](workflows/WORKFLOW_DIAGRAMS.md) | Visual workflow documentation |
| [Workflow Changelog](workflows/WORKFLOW_CHANGELOG.md) | Workflow version history |
| [Release Drafter](workflows/RELEASE_DRAFTER.md) | Automated release notes |
| [Renovate vs Dependabot](workflows/RENOVATE_VS_DEPENDABOT.md) | Dependency update comparison |

### Architecture

Design patterns and architectural decisions.

| Document | Description |
|----------|-------------|
| [Monorepo Patterns](architecture/MONOREPO_PATTERNS.md) | Monorepo setup and tooling |
| [Feature Flags](architecture/FEATURE_FLAGS.md) | Feature flag implementation |
| [Database Testing](architecture/DATABASE_TESTING.md) | Database testing strategies |
| [ML Projects](architecture/ML_PROJECTS.md) | Machine learning project setup |

### Integrations

External tools and MCP server integrations.

| Integration | Description |
|-------------|-------------|
| [Serena](integrations/SERENA.md) | Code intelligence MCP server |
| [Obsidian](integrations/OBSIDIAN_MCP.md) | Knowledge base integration |
| [Zotero](integrations/ZOTERO_MCP.md) | Research library integration |

### Reference

Reference documentation and compatibility information.

| Document | Description |
|----------|-------------|
| [Compatibility Matrix](reference/COMPATIBILITY_MATRIX.md) | Tool compatibility reference |

### Migrations

Guides for migrating from other CI/CD platforms.

| From | Guide |
|------|-------|
| Travis CI | [FROM_TRAVIS_CI.md](migrations/FROM_TRAVIS_CI.md) |
| Jenkins | [FROM_JENKINS.md](migrations/FROM_JENKINS.md) |
| CircleCI | [FROM_CIRCLECI.md](migrations/FROM_CIRCLECI.md) |
| GitLab CI | [FROM_GITLAB_CI.md](migrations/FROM_GITLAB_CI.md) |

### Project

Internal project documentation.

| Document | Description |
|----------|-------------|
| [Implementation Plan](project/IMPLEMENTATION_PLAN.md) | Project implementation details |
| [Future Improvements](project/FUTURE_IMPROVEMENTS.md) | Roadmap and planned features |

## Getting Started

Use the Claude Code skill:

```bash
/github-setup              # Full setup wizard
/github-setup checklist    # Show what's missing
```

Or copy templates from the [templates/](https://github.com/domelic/github-repository-setup/tree/main/templates) directory.
