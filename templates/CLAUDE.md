# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project Overview

<!-- Brief description of what this project does -->

## Build Commands

```bash
# Install dependencies
npm install

# Run tests
npm test

# Build
npm run build
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
| `test/` | `test/description` | Adding tests |
| `perf/` | `perf/description` | Performance improvements |

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
| `src/` | Source code |
| `tests/` | Test files |
| `docs/` | Documentation |

## Pre-commit Hooks

If this project uses pre-commit hooks:

```bash
# Install hooks after cloning
pre-commit install
pre-commit install --hook-type commit-msg

# Run manually
pre-commit run --all-files
```

## For Claude: Working Style

1. **Follow conventions**: Use the branch naming and commit conventions above
2. **Read before editing**: Always read files before modifying them
3. **Small commits**: Prefer focused commits over large changes
4. **Update docs**: Keep documentation in sync with code changes
