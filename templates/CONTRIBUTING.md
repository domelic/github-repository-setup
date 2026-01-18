# Contributing

Thank you for your interest in contributing!

## How to Contribute

### Reporting Issues

- Use the issue templates for bugs and feature requests
- Check existing issues before creating a new one
- Provide clear descriptions and reproduction steps

### Submitting Changes

1. Fork the repository
2. Create a branch following the naming convention (see below)
3. Make your changes
4. Commit with conventional format (see below)
5. Push to your fork
6. Open a Pull Request

## Branch Naming Convention

Branch names should match the conventional commit type:

| Type | Branch Prefix | Example |
|------|---------------|---------|
| `feat` | `feat/` | `feat/user-authentication` |
| `fix` | `fix/` | `fix/memory-leak` |
| `docs` | `docs/` | `docs/api-guide` |
| `style` | `style/` | `style/formatting` |
| `refactor` | `refactor/` | `refactor/parser-logic` |
| `perf` | `perf/` | `perf/query-optimization` |
| `test` | `test/` | `test/auth-coverage` |
| `chore` | `chore/` | `chore/update-deps` |
| `ci` | `ci/` | `ci/add-workflow` |

**Rules:**
- Use lowercase
- Use hyphens to separate words
- Keep names concise but descriptive
- Branches are auto-deleted after PR merge

## Commit Message Convention

This project uses [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <description>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | Formatting, whitespace |
| `refactor` | Code restructuring |
| `perf` | Performance improvement |
| `test` | Adding tests |
| `chore` | Maintenance tasks |

### Examples

```bash
feat: add user authentication
fix: resolve memory leak in parser
docs: update installation guide
```

## Code of Conduct

Be respectful and constructive. We're all here to help each other.

## Questions?

Open an issue or start a discussion.
