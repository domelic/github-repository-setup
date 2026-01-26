# Contributing to GitHub Repository Setup Guide

Thank you for your interest in contributing!

## How to Contribute

### Reporting Issues

- Use the issue templates for bugs and feature requests
- Check existing issues before creating a new one
- Provide clear descriptions and reproduction steps

### Submitting Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Make your changes
4. Commit with clear messages
5. Push to your fork
6. Open a Pull Request

### What We're Looking For

- **Corrections** — Fix errors or outdated information
- **Clarifications** — Improve unclear sections
- **New Commands** — Add useful CLI commands we missed
- **Platform Coverage** — Extend guides for different scenarios
- **Translations** — Help make this accessible in other languages

### Style Guidelines

- Use clear, concise language
- Include working code examples
- Test CLI commands before submitting
- Follow existing formatting patterns

### Pre-commit Hooks

This project uses pre-commit hooks. Install them after cloning:

```bash
pip install pre-commit
pre-commit install
pre-commit install --hook-type commit-msg
```

Hooks run automatically on commit and check:

- Code formatting (Prettier, Ruff)
- Commit message format (Conventional Commits)
- No secrets committed
- YAML/JSON validity

### Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md). Be respectful and constructive. We're all here to help each other build better repositories.

## Questions?

Start a discussion in [GitHub Discussions](https://github.com/domelic/github-repository-setup/discussions) for questions, ideas, or general conversations about the project.
