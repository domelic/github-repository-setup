# Advanced CODEOWNERS Patterns

This guide covers advanced patterns and best practices for GitHub CODEOWNERS files.

## Overview

CODEOWNERS automatically requests reviews from the right people when pull requests modify specific files or directories.

## Syntax Basics

```text
# Comment
PATTERN OWNER1 OWNER2 ...
```

Owners can be:
- `@username` - GitHub username
- `@org/team-name` - GitHub team
- `email@example.com` - Email address

## Pattern Matching

### File Patterns

| Pattern | Matches |
|---------|---------|
| `*` | All files in root directory |
| `*.js` | All `.js` files anywhere |
| `/*.js` | `.js` files in root only |
| `**/*.js` | `.js` files in any subdirectory |
| `docs/*` | Files in `docs/` (one level) |
| `docs/**` | All files under `docs/` (recursive) |

### Directory Patterns

```text
# Match directory and all contents
/src/               @team

# Match specific subdirectory
/src/api/           @api-team

# Match pattern in any directory
**/migrations/      @dba-team
```

### Glob Patterns

```text
# Multiple extensions
*.{js,ts,jsx,tsx}   @frontend-team

# Character ranges
/config-[0-9].yml   @devops-team

# Single character wildcard
/src/?.ts           @team
```

## Order and Precedence

**Later rules override earlier ones.** This enables pattern layering:

```text
# Base rule: everything needs review
*                           @default-reviewers

# Specific overrides
/docs/                      @docs-team
/src/                       @dev-team
/src/security/              @security-team  # Most specific wins
```

## Common Patterns

### By File Type

```text
# Frontend
*.js                @frontend-team
*.jsx               @frontend-team
*.ts                @frontend-team
*.tsx               @frontend-team
*.css               @frontend-team
*.scss              @frontend-team

# Backend
*.py                @backend-team
*.go                @backend-team
*.rs                @backend-team
*.java              @backend-team

# DevOps
*.yml               @devops-team
*.yaml              @devops-team
Dockerfile          @devops-team
Makefile            @devops-team
```

### By Domain

```text
# Authentication
**/auth/**          @auth-team
**/login/**         @auth-team
**/oauth/**         @auth-team

# Payments
**/payment/**       @payments-team
**/billing/**       @payments-team
**/checkout/**      @payments-team

# Data layer
**/models/**        @data-team
**/repositories/**  @data-team
**/migrations/**    @data-team @dba-team
```

### Security-Sensitive Files

```text
# Security configurations
**/security/**              @security-team
SECURITY.md                 @security-team

# Secrets and credentials
*.env.example               @security-team
**/secrets/**               @security-team

# Authentication code
**/auth/**                  @security-team
**/crypto/**                @security-team

# Supply chain (dependency files)
package-lock.json           @security-team
yarn.lock                   @security-team
pnpm-lock.yaml              @security-team
requirements.txt            @security-team
Pipfile.lock                @security-team
poetry.lock                 @security-team
go.sum                      @security-team
Cargo.lock                  @security-team
Gemfile.lock                @security-team

# Repository settings
CODEOWNERS                  @security-team @admin-team
/.github/workflows/         @security-team
```

### Multiple Team Approvals

```text
# Critical infrastructure needs multiple teams
/infra/production/          @platform-team @security-team @sre-team

# API changes need frontend and backend
/openapi/                   @api-team @frontend-team

# Database changes need DBA approval
/migrations/                @backend-team @dba-team
```

## Team Structure Examples

### Monorepo with Multiple Apps

```text
# Shared code
/packages/shared/           @core-team

# App-specific
/apps/web/                  @web-team
/apps/mobile/               @mobile-team
/apps/api/                  @api-team

# Shared infrastructure
/infra/                     @platform-team
/.github/                   @devops-team
```

### Microservices

```text
# Per-service ownership
/services/user-service/     @user-team
/services/order-service/    @order-team
/services/payment-service/  @payment-team @security-team

# Shared libraries
/libs/                      @platform-team

# Service mesh config
/istio/                     @platform-team @security-team
```

### Frontend/Backend Split

```text
# Frontend
/frontend/                  @frontend-team
*.tsx                       @frontend-team
*.css                       @frontend-team

# Backend
/backend/                   @backend-team
*.py                        @backend-team

# Full-stack features
/features/                  @frontend-team @backend-team
```

## Best Practices

### 1. Start Broad, Get Specific

```text
# Default owner
*                           @default-team

# Then add specific patterns
/src/                       @dev-team
/docs/                      @docs-team
```

### 2. Use Teams, Not Individuals

```text
# Prefer teams over individuals
/src/                       @org/dev-team

# Avoid (creates bottlenecks)
/src/                       @individual-developer
```

### 3. Keep It Maintainable

```text
# Group related patterns
# === Frontend ===
/src/components/            @frontend-team
/src/pages/                 @frontend-team
/src/styles/                @frontend-team

# === Backend ===
/src/api/                   @backend-team
/src/services/              @backend-team
```

### 4. Document the Structure

Add comments explaining ownership decisions:

```text
# Security team must review all auth changes
# See: https://wiki.example.com/security-review-policy
**/auth/**                  @security-team
```

### 5. Consider Branch Protection

Combine CODEOWNERS with branch protection:

1. **Settings → Branches → Branch protection rules**
2. Enable "Require review from Code Owners"
3. Set minimum number of approving reviews

## Troubleshooting

### Pattern Not Matching

Check pattern specificity:

```text
# This won't match /src/app/test.js
/src/*.js           @team

# This will
/src/**/*.js        @team
```

### Multiple Owners Not Notified

Ensure teams have repository access and notification settings enabled.

### CODEOWNERS Not Working

1. File must be in `.github/`, root, or `docs/` directory
2. Check file permissions and syntax
3. Verify team/user exists and has repository access

## Validation

Validate your CODEOWNERS file:

```bash
# GitHub CLI
gh api repos/{owner}/{repo}/codeowners/errors

# Or check via UI
# Repository → Settings → Branches → View CODEOWNERS errors
```

## Related Resources

- [GitHub CODEOWNERS Documentation](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [`templates/CODEOWNERS`](../../templates/CODEOWNERS) - Template file
