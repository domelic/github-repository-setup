# Serena: Code Intelligence MCP Server

Serena is an MCP (Model Context Protocol) server that provides semantic code understanding for Claude Code. It enables symbol-level navigation, intelligent code editing, and persistent project memory.

---

## Overview

| Feature | Description |
|---------|-------------|
| **Symbolic Navigation** | Find symbols by name, navigate class hierarchies, trace references |
| **Intelligent Editing** | Replace symbol bodies, insert before/after symbols, regex-based edits |
| **Memory System** | Persistent markdown notes that survive across sessions |
| **Multi-Language** | Supports TypeScript, Python, Go, Java, C/C++, and more via LSP |
| **Project Context** | Automatic project configuration and language detection |

---

## Installation

### Via Claude Code Settings

Add to your Claude Code MCP configuration (`~/.claude/settings.json` or project `.claude/settings.json`):

```json
{
  "mcpServers": {
    "serena": {
      "command": "uvx",
      "args": ["--from", "serena-mcp", "serena"],
      "env": {}
    }
  }
}
```

### Prerequisites

- Python 3.10+ with `uv` or `uvx` installed
- Language servers for your project languages (auto-detected)

---

## Project Setup

### Initial Activation

When you first use Serena in a project, activate it:

```
Serena: activate_project /path/to/your/project
```

This creates a `.serena/` directory in your project:

```
.serena/
├── .gitignore      # Ignores /cache
├── project.yml     # Project configuration
├── cache/          # LSP cache (gitignored)
└── memories/       # Persistent notes (tracked in git)
```

### Project Configuration

The `project.yml` file contains:

```yaml
name: your-project
path: /path/to/your/project
programming_languages:
  - typescript
  - python
file_encoding: utf-8
```

### Onboarding Check

After activation, run the onboarding check:

```
Serena: check_onboarding_performed
```

If onboarding hasn't been done, run:

```
Serena: onboarding
```

This guides you through creating project-specific memories.

---

## Memory System

Serena's memory system provides persistent context across sessions.

### Creating Memories

```text
Serena: write_memory
  memory_file_name: "ARCHITECTURE.md"
  content: "# Project Architecture\n\n## Overview\n..."
```

Memories are stored in `.serena/memories/` as markdown files.

### Reading Memories

```text
Serena: list_memories
```

Returns available memory files. Then read specific ones:

```text
Serena: read_memory
  memory_file_name: "ARCHITECTURE.md"
```

### Memory Types by Project Type

#### For Code Projects

| Memory | Purpose | When to Create |
|--------|---------|----------------|
| `ARCHITECTURE.md` | System design, component relationships | Project setup |
| `CONVENTIONS.md` | Coding standards, naming patterns | Project setup |
| `DOMAIN.md` | Business logic, terminology | When domain complexity grows |
| `COMMANDS.md` | Build/test/deploy commands | Project setup |

#### For Documentation Projects (LaTeX, Technical Writing)

| Memory | Purpose | When to Create |
|--------|---------|----------------|
| `EDITING_GUIDE.md` | Document structure, line ranges, editing patterns | After initial document structure |
| `STYLE_GUIDE.md` | Writing conventions, tone, terminology | When consistency matters |
| `CROSS_REFERENCES.md` | Concept dependencies, term definitions | For interconnected documents |
| `BIBLIOGRAPHY_SOURCES.md` | Annotated citations, source relationships | For academic/research work |
| `REVISION_DECISIONS.md` | Editorial decision log, style precedents | For long-term projects |

#### For Framework/Methodology Projects

| Memory | Purpose | When to Create |
|--------|---------|----------------|
| `CONCEPTS.md` | Key terms, relationships, quick reference | After core concepts defined |
| `PATTERNS.md` | Common patterns, anti-patterns, workflows | When patterns emerge |

### Memory Design Principles

1. **One concern per memory** — Don't mix architecture with style guide
2. **Quick reference format** — Tables, bullet points over prose
3. **Include "when to use"** — Help future sessions know when to read
4. **Update the memory** — Log decisions in REVISION_DECISIONS.md
5. **Cross-reference** — Link related memories in content

### Example: Documentation Project Memory Suite

For a large documentation project (e.g., LaTeX treatise), create this memory suite:

```text
.serena/memories/
├── EDITING_GUIDE.md       # WHERE to edit (line ranges, structure)
├── STYLE_GUIDE.md         # HOW to write (tone, terminology)
├── CROSS_REFERENCES.md    # WHAT depends on what
├── BIBLIOGRAPHY_SOURCES.md # WHY cite each source
└── REVISION_DECISIONS.md  # WHAT was decided and why
```

**Workflow:**
1. Before editing → Read `EDITING_GUIDE.md` for structure
2. While writing → Consult `STYLE_GUIDE.md` for consistency
3. When referencing → Check `CROSS_REFERENCES.md` for dependencies
4. When citing → Use `BIBLIOGRAPHY_SOURCES.md` for context
5. After deciding → Log in `REVISION_DECISIONS.md`

### Editing Memories

```
Serena: edit_memory
  memory_file_name: "ARCHITECTURE.md"
  needle: "## Old Section"
  repl: "## Updated Section"
  mode: "literal"  # or "regex"
```

---

## Symbolic Code Tools

### Finding Symbols

```
Serena: find_symbol
  name_path_pattern: "MyClass/myMethod"
  include_body: true
  depth: 1  # Include immediate children
```

**Name path patterns:**
- `myMethod` — Find any symbol named `myMethod`
- `MyClass/myMethod` — Find `myMethod` inside `MyClass`
- `/MyClass/myMethod` — Exact path (absolute)
- `MyClass/get*` — Substring matching with `substring_matching: true`

### Getting Symbol Overview

```
Serena: get_symbols_overview
  relative_path: "src/components/Button.tsx"
  depth: 1
```

Returns all symbols in a file grouped by kind (classes, functions, variables).

### Finding References

```
Serena: find_referencing_symbols
  name_path: "MyClass/myMethod"
  relative_path: "src/MyClass.ts"
```

Finds all places where a symbol is used.

### Replacing Symbol Bodies

```
Serena: replace_symbol_body
  name_path: "MyClass/myMethod"
  relative_path: "src/MyClass.ts"
  body: "function myMethod() {\n  return 42;\n}"
```

**Important:** The body includes the full definition (signature + implementation), NOT docstrings or imports.

### Inserting Code

```
Serena: insert_after_symbol
  name_path: "MyClass"
  relative_path: "src/MyClass.ts"
  body: "\n\nexport class NewClass {\n  // ...\n}"
```

```
Serena: insert_before_symbol
  name_path: "MyClass"
  relative_path: "src/MyClass.ts"
  body: "import { Dependency } from './dep';\n\n"
```

### Renaming Symbols

```
Serena: rename_symbol
  name_path: "oldName"
  relative_path: "src/file.ts"
  new_name: "newName"
```

Renames across the entire codebase.

---

## File Operations

### Pattern Search

```
Serena: search_for_pattern
  substring_pattern: "TODO|FIXME"
  paths_include_glob: "**/*.ts"
  context_lines_before: 2
  context_lines_after: 2
```

### Content Replacement

```
Serena: replace_content
  relative_path: "src/config.ts"
  needle: "version: \".*?\""
  repl: "version: \"2.0.0\""
  mode: "regex"
```

**Pro tip:** Use regex with wildcards to avoid quoting large sections:

```
Serena: replace_content
  needle: "function oldFunc.*?^}"  # DOTALL + MULTILINE enabled
  repl: "function newFunc() {\n  // new implementation\n}"
  mode: "regex"
```

### Reading Files

```
Serena: read_file
  relative_path: "src/index.ts"
  start_line: 0
  end_line: 50
```

### Creating Files

```
Serena: create_text_file
  relative_path: "src/newFile.ts"
  content: "export const value = 42;"
```

---

## Thinking Tools

Serena includes metacognitive checkpoints:

| Tool | When to Use |
|------|-------------|
| `think_about_collected_information` | After a sequence of searches/reads |
| `think_about_task_adherence` | Before making code changes |
| `think_about_whether_you_are_done` | When you believe the task is complete |

These help maintain focus during complex multi-step tasks.

---

## Shell Commands

```
Serena: execute_shell_command
  command: "npm test"
  cwd: "packages/core"  # Optional working directory
  capture_stderr: true
```

**Limitations:**
- Do not use for long-running processes (servers)
- Do not use for interactive commands

---

## Git Integration

The `.serena/` directory structure:

```gitignore
# .serena/.gitignore
/cache
```

**Track in git:**
- `.serena/project.yml` — Project configuration
- `.serena/memories/*.md` — Persistent knowledge

**Ignore:**
- `.serena/cache/` — LSP cache, regenerated automatically

---

## Integration with Claude Code

### Complementary Tools

| Task | Use Serena | Use Claude Code Native |
|------|------------|------------------------|
| Find symbol by name | ✅ `find_symbol` | |
| Find file by pattern | | ✅ `Glob` |
| Search file content | ✅ `search_for_pattern` | ✅ `Grep` |
| Edit specific symbol | ✅ `replace_symbol_body` | |
| Edit by line content | | ✅ `Edit` |
| Run shell commands | ✅ `execute_shell_command` | ✅ `Bash` |
| Persistent notes | ✅ Memories | ✅ `CLAUDE.md` |

### When to Use Serena vs Native Tools

**Use Serena when:**
- Working with code symbols (classes, functions, methods)
- Need to trace references across codebase
- Want persistent memories specific to code understanding
- Performing semantic refactoring

**Use Native Claude Code when:**
- Simple text search/replace
- File operations by path
- Git commands
- General shell operations

---

## Modes

Serena supports different operational modes:

```
Serena: switch_modes
  modes: ["editing", "interactive"]
```

| Mode | Description |
|------|-------------|
| `editing` | Full read/write access to code |
| `planning` | Read-only, for analysis |
| `interactive` | Engage with user throughout |
| `one-shot` | Complete task without interaction |

---

## Troubleshooting

### "No active project" Error

**Problem:** Tools fail with "No active project" message.

**Fix:** Activate the project first:

```
Serena: activate_project /path/to/project
```

### Symbol Not Found

**Problem:** `find_symbol` returns no results for a known symbol.

**Causes:**
1. Language server not running/configured
2. File not yet indexed
3. Incorrect name path pattern

**Fix:**
1. Check project.yml has correct `programming_languages`
2. Use `get_symbols_overview` on the file first
3. Try broader pattern with `substring_matching: true`

### Memory Not Persisting

**Problem:** Memories disappear between sessions.

**Cause:** `.serena/` directory not committed to git.

**Fix:** Ensure `.serena/memories/` is tracked:

```bash
git add .serena/project.yml .serena/memories/
git commit -m "chore: add Serena project configuration"
```

### Slow Symbol Resolution

**Problem:** Symbol operations are slow.

**Cause:** Large codebase without path restriction.

**Fix:** Always provide `relative_path` to narrow the search:

```
Serena: find_symbol
  name_path_pattern: "myFunction"
  relative_path: "src/utils/"  # Restrict to directory
```

---

## Example: Setting Up a New Project

```bash
# 1. Start Claude Code in your project
cd /path/to/my-project
claude

# 2. Activate Serena (Claude will do this)
> Serena: activate_project /path/to/my-project

# 3. Check onboarding
> Serena: check_onboarding_performed

# 4. Create initial memories
> Serena: write_memory
    memory_file_name: "ARCHITECTURE.md"
    content: "# Project Architecture\n\n## Components\n..."

# 5. Commit Serena config
git add .serena/
git commit -m "chore: add Serena project configuration"
```

---

## Resources

- [Serena GitHub Repository](https://github.com/serena-ai/serena)
- [MCP Protocol Specification](https://modelcontextprotocol.io/)
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
