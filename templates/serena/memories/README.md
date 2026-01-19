# Serena Memories

This directory contains persistent markdown notes that provide context across Claude Code sessions.

## Memory Types by Project Type

### For Code Projects

| File | Purpose |
|------|----------|
| `ARCHITECTURE.md` | High-level system design, component relationships |
| `CONVENTIONS.md` | Coding standards, naming patterns, file organization |
| `DOMAIN.md` | Business logic, key concepts, terminology |
| `COMMANDS.md` | Common build/test/deploy commands |

### For Documentation Projects

| File | Purpose |
|------|----------|
| `EDITING_GUIDE.md` | Document structure, line ranges, editing patterns |
| `STYLE_GUIDE.md` | Writing conventions, tone, terminology preferences |
| `CROSS_REFERENCES.md` | Concept dependencies, term definition locations |
| `BIBLIOGRAPHY_SOURCES.md` | Annotated citations, source relationships |
| `REVISION_DECISIONS.md` | Editorial decision log, style precedents |

### For Framework/Methodology Projects

| File | Purpose |
|------|----------|
| `CONCEPTS.md` | Key terms, relationships, quick reference |
| `PATTERNS.md` | Common patterns, anti-patterns, workflows |

## Creating Memories

Use Claude Code with Serena:

```text
Serena: write_memory
  memory_file_name: "ARCHITECTURE.md"
  content: "# Project Architecture\n\n..."
```

## Best Practices

1. **One concern per memory** — Don't mix architecture with style guide
2. **Quick reference format** — Use tables, bullet points over prose
3. **Include "when to use"** — Help future sessions know when to read
4. **Update regularly** — Memories should reflect current state
5. **Commit to git** — Memories are part of project knowledge

## Memory Design Template

Each memory should include:

```markdown
# Memory Title

Brief description of what this memory contains.

## Quick Reference

[Tables or bullet points for fast lookup]

## Details

[Expanded information organized by topic]

## When to Use This Memory

- Before doing X, read section Y
- When encountering Z, check the table above
```
