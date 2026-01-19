# Markdown Lint Guide

Common markdown lint rules and how to fix violations.

## Quick Reference

| Rule | Issue | Fix |
|------|-------|-----|
| MD026 | Trailing punctuation in heading | Remove `:`, `.`, `;` from heading end |
| MD040 | Code block without language | Add language after opening ``` |
| MD058 | Table without blank lines | Add blank line before and after table |

## Most Common Issues

### MD040: Fenced Code Blocks Need Language

Every fenced code block needs a language specifier.

**Wrong:**

````markdown
```
some content here
```
````

**Correct:**

````markdown
```text
some content here
```
````

**Common language specifiers:**

- `text` - Plain text, diagrams, generic content
- `bash` or `shell` - Shell commands
- `json` - JSON configuration
- `yaml` - YAML configuration
- `javascript` or `js` - JavaScript
- `typescript` or `ts` - TypeScript
- `python` - Python
- `markdown` or `md` - Markdown examples

### MD058: Tables Need Blank Lines

Tables must have blank lines before and after them.

**Wrong:**

```markdown
### Pricing Tiers
| Price | Rate |
|-------|------|
| $1.00 | 35%  |
```

**Correct:**

```markdown
### Pricing Tiers

| Price | Rate |
|-------|------|
| $1.00 | 35%  |
```

### MD026: No Trailing Punctuation in Headings

Headings should not end with punctuation marks.

**Wrong:**

```markdown
### When referencing concepts:
### Adding new items:
```

**Correct:**

```markdown
### When Referencing Concepts
### Adding New Items
```

## Configuration

The `.markdownlint.json` template includes these key settings:

```json
{
  "MD026": { "punctuation": ".,;:!" },
  "MD040": true,
  "MD058": true
}
```

### Rules Disabled by Default

Some rules are disabled in the template for flexibility:

| Rule | Why Disabled |
|------|--------------|
| MD013 | Line length - too restrictive for documentation |
| MD022 | Blank lines around headings - conflicts with some patterns |
| MD033 | Inline HTML - sometimes necessary |
| MD041 | First line heading - not always applicable |

## Running Lint Locally

```bash
# Install
npm install -g markdownlint-cli2

# Run on all markdown files
markdownlint-cli2 "**/*.md" --config .markdownlint.json

# Exclude specific files
markdownlint-cli2 "**/*.md" "!CHANGELOG.md" --config .markdownlint.json
```

## CI Integration

The `markdown-lint.yml` workflow template runs on all PRs:

```yaml
- name: Lint markdown files
  uses: DavidAnson/markdownlint-cli2-action@v22
  with:
    config: '.markdownlint.json'
    globs: |
      **/*.md
      !CHANGELOG.md
```

## Common Patterns

### Tables in Memory Files

When documenting in Serena memories or similar structured docs:

```markdown
## Section Title

### Category Name

| Column 1 | Column 2 |
|----------|----------|
| Value    | Value    |

### Next Category
```

Note the blank lines:
- After the section heading
- After the subsection heading (before table)
- After the table (before next heading)

### Code Examples in Documentation

````markdown
### Example Usage

```bash
npm install package-name
```

### Configuration

```json
{
  "key": "value"
}
```
````

## Fixing Bulk Violations

When you have many violations of the same rule:

1. **MD040 (code language)**: Search for ` ``` ` followed by newline, add `text`
2. **MD058 (table spacing)**: Search for `|\n###` or `###\n|`, add blank line
3. **MD026 (trailing punctuation)**: Search headings ending with `:` and remove

## See Also

- [markdownlint rules documentation](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md)
- [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
