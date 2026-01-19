# Serena Memories

This directory contains persistent markdown notes that provide context across Claude Code sessions.

## Recommended Memory Files

| File | Purpose |
|------|----------|
| `ARCHITECTURE.md` | High-level system design, component relationships |
| `CONVENTIONS.md` | Coding standards, naming patterns, file organization |
| `DOMAIN.md` | Business logic, key concepts, terminology |
| `COMMANDS.md` | Common build/test/deploy commands |
| `EDITING_GUIDE.md` | Document-specific guidance (for non-code projects) |

## Creating Memories

Use Claude Code with Serena:

```
Serena: write_memory
  memory_file_name: "ARCHITECTURE.md"
  content: "# Project Architecture\n\n..."
```

## Best Practices

1. **Keep memories focused** — One topic per file
2. **Update regularly** — Memories should reflect current state
3. **Use markdown** — Structure with headings, tables, code blocks
4. **Commit to git** — Memories are part of project knowledge
