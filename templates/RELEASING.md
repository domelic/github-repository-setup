# Release Process

This document describes how to create releases.

## Using Release Please (Automated)

If using Release Please, releases happen automatically:

1. **Commit with conventional format** (`feat:`, `fix:`, etc.)
2. **Push to main**
3. **Release Please creates a PR** with CHANGELOG updates
4. **Merge the release PR** when ready
5. **Release is created automatically**

### Commit Types and Version Bumps

| Commit | Version Change |
|--------|----------------|
| `feat:` | Minor (1.0.0 → 1.1.0) |
| `fix:` | Patch (1.0.0 → 1.0.1) |
| `feat!:` | Major (1.0.0 → 2.0.0) |
| `chore:` | No release |

## Manual Releases

If not using Release Please:

### 1. Update CHANGELOG.md

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New features

### Changed
- Changes to existing features

### Fixed
- Bug fixes
```

### 2. Commit and Tag

```bash
git add CHANGELOG.md
git commit -m "chore: prepare release vX.Y.Z"
git tag vX.Y.Z
git push origin main --tags
```

### 3. Verify Release

- Check the Releases page
- Verify assets are attached
- Verify release notes are correct

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** — Breaking changes
- **MINOR** — New features (backwards compatible)
- **PATCH** — Bug fixes (backwards compatible)
