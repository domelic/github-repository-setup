# Build & Lint Commands

Commands for this repository (github-repository-setup).

## Prerequisites

```bash
# Install Node.js dependencies
npm install

# Install pre-commit (optional, for hooks)
pip install pre-commit
pre-commit install
pre-commit install --hook-type commit-msg
```

## Linting

```bash
# Run all linters (markdown + spelling)
npm run lint

# Markdown lint only
npm run lint:md

# Markdown lint with auto-fix
npm run lint:md:fix

# Spell check only
npm run lint:spell

# Validate last commit message
npm run lint:commit
```

## Pre-commit Hooks

```bash
# Run all hooks on staged files
pre-commit run

# Run all hooks on all files
pre-commit run --all-files

# Update hooks to latest versions
pre-commit autoupdate
```

## Git Workflow

```bash
# Create feature branch
git checkout -b feat/description

# Create fix branch
git checkout -b fix/description

# Create docs branch
git checkout -b docs/description
```

## Validation Checklist

Before committing:
1. `npm run lint` - Ensure no lint errors
2. `pre-commit run` - Pre-commit hooks pass
3. Use conventional commit format

## CI Equivalents

| Local Command | CI Workflow |
|---------------|-------------|
| `npm run lint:md` | `.github/workflows/markdown-lint.yml` |
| `npm run lint:spell` | `.github/workflows/spell-check.yml` |
| `npm run lint:commit` | `.github/workflows/commitlint.yml` |

## Node.js Version

This project requires Node.js >= 18.0.0 (see `engines` in package.json).
