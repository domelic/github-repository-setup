# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project Overview

A comprehensive guide and Claude Code skill for setting up GitHub repositories with production-grade automation. This repository contains templates, workflows, and documentation for repository best practices.

## Build Commands

This is primarily a documentation and template repository. No build step is required.

```bash
# Validate markdown
npm install
npx markdownlint-cli2 "**/*.md"

# Check spelling
npx cspell "**/*.md"
```

## Git Workflow

### Branch Naming Convention

When creating branches, use prefixes that match the conventional commit type:

| Type | Branch Prefix | When to Use |
|------|---------------|-------------|
| `feat/` | `feat/description` | New features |
| `fix/` | `fix/description` | Bug fixes |
| `docs/` | `docs/description` | Documentation changes |
| `refactor/` | `refactor/description` | Code restructuring |
| `chore/` | `chore/description` | Maintenance tasks |
| `ci/` | `ci/description` | CI/CD changes |

**Rules:**

- Use lowercase
- Use hyphens to separate words (e.g., `feat/user-authentication`)
- Keep names concise but descriptive
- Do not include issue numbers in branch names

### Commit Message Convention

This project uses [Conventional Commits](https://www.conventionalcommits.org/):

```text
<type>: <description>

[optional body]

[optional footer]
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`

**Examples:**

```bash
feat: add user authentication
fix: resolve memory leak in parser
docs: update API documentation
chore: update dependencies
```

### Pull Request Guidelines

- PRs require review before merging (check CODEOWNERS)
- All status checks must pass
- Branches are automatically deleted after merge
- Squash merge is preferred for clean history

## Key Files

| File | Purpose |
|------|---------|
| `templates/` | Reusable templates for workflows, configs |
| `docs/` | Documentation files |
| `.github/` | GitHub-specific configs and workflows |
| `README.md` | Main project documentation |

## For Claude: Working Style

1. **Follow conventions**: Use the branch naming and commit conventions above
2. **Read before editing**: Always read files before modifying them
3. **Small commits**: Prefer focused commits over large changes
4. **Update docs**: Keep documentation in sync with code changes
5. **Template consistency**: When editing templates, maintain existing patterns
