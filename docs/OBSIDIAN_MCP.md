# Obsidian MCP Integration

Connect your Obsidian vault to Claude Code for AI-assisted knowledge management.

## Why Use Obsidian MCP?

| Use Case | Benefit |
|----------|---------|
| **Research synthesis** | Claude can search and reference your notes while working |
| **Documentation** | Cross-reference vault notes with project documentation |
| **Concept exploration** | Ask Claude to find connections across your vault |
| **Note organization** | AI-assisted tagging, linking, and summarization |

## Options

Three main approaches exist, each with different trade-offs:

| Option | Setup Complexity | Features | Best For |
|--------|------------------|----------|----------|
| [obsidian-claude-code-mcp](#option-1-obsidian-claude-code-mcp) | Low | Auto-discovery, IDE features | Claude Code users |
| [mcp-obsidian (REST API)](#option-2-mcp-obsidian-rest-api) | Medium | Full CRUD, search | Power users |
| [mcp-obsidian (smithery)](#option-3-mcp-obsidian-smithery) | Low | Read/search only | Simple setups |

---

## Option 1: obsidian-claude-code-mcp

**Best for:** Claude Code CLI users who want automatic discovery.

### Installation

1. In Obsidian, go to **Settings > Community plugins > Browse**
2. Search for "Claude Code MCP"
3. Install and enable the plugin

### Configuration

Claude Code automatically discovers vaults via WebSocket. No manual config needed.

**Verify connection:**

```bash
claude
# Then use /ide and select "Obsidian"
```

**Custom port (if needed):**

In Obsidian plugin settings, change the port from default 22360 if you have conflicts.

### Available Tools

| Tool | Description |
|------|-------------|
| `view` | Read file contents |
| `str_replace` | Edit file content |
| `create` | Create new files |
| `insert` | Insert content at position |
| `get_current_file` | Get active file context |
| `get_workspace_files` | List open files |
| `obsidian_api` | Direct Obsidian API access |

### Claude Desktop Config

If using Claude Desktop instead of Claude Code CLI:

```json
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["mcp-remote", "http://localhost:22360/sse"]
    }
  }
}
```

---

## Option 2: mcp-obsidian (REST API)

**Best for:** Users who want full CRUD operations and advanced search.

### Prerequisites

1. Install [Obsidian Local REST API](https://github.com/coddingtonbear/obsidian-local-rest-api) plugin
2. Enable the plugin and generate an API key

### Installation

Add to your Claude Code MCP configuration (`~/.claude.json` or project config):

```json
{
  "mcpServers": {
    "obsidian": {
      "command": "uvx",
      "args": ["mcp-obsidian"],
      "env": {
        "OBSIDIAN_API_KEY": "your-api-key-here",
        "OBSIDIAN_HOST": "127.0.0.1",
        "OBSIDIAN_PORT": "27124"
      }
    }
  }
}
```

### Available Tools

| Tool | Description |
|------|-------------|
| `list_files_in_vault` | List all files in vault root |
| `list_files_in_dir` | List files in specific directory |
| `get_file_contents` | Read file content |
| `search` | Full-text search across vault |
| `patch_content` | Insert content relative to headings |
| `append_content` | Add content to files |
| `delete_file` | Remove files |

### Example Prompts

```text
"Search my vault for notes mentioning 'authentication' and summarize the key points"

"Get the contents of my 'Projects/my-project/notes.md' file"

"Append today's insights to my 'Daily/2026-01-19.md' note"
```

---

## Option 3: mcp-obsidian (smithery)

**Best for:** Simple read-only access without Obsidian plugins.

### Installation

```bash
npx -y @smithery/cli install mcp-obsidian --client claude
```

Or manually add to config:

```json
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["-y", "mcp-obsidian", "/path/to/your/vault"]
    }
  }
}
```

### Features

- Read markdown files from any directory
- Search across all files
- No Obsidian plugin required
- Works with any markdown folder (not just Obsidian)

---

## Combining with Other MCP Servers

Obsidian MCP works well alongside other integrations:

| Task | Tool |
|------|------|
| Find research notes | Obsidian MCP |
| Get citation details | Zotero MCP |
| Edit project code | Serena MCP |
| Search GitHub | GitHub MCP |

**Example workflow:**

```text
"Search my Obsidian vault for notes tagged #api-design, then help me
implement those patterns in the current codebase"
```

---

## Troubleshooting

### Claude Code doesn't see my vault

1. Ensure the Obsidian plugin is enabled
2. Check that Obsidian is running
3. Verify port 22360 isn't blocked
4. Try `/ide` in Claude Code to manually connect

### REST API connection fails

1. Verify the Obsidian REST API plugin is enabled
2. Check the API key is correct
3. Confirm the port matches (default: 27124)
4. Test the API directly: `curl http://127.0.0.1:27124/`

### Multiple vaults

Each vault needs a unique port. Configure in plugin settings:

- Vault 1: Port 22360
- Vault 2: Port 22361
- etc.

---

## Security Considerations

- **Local only:** All MCP servers run locally; no data leaves your machine
- **API keys:** Store REST API keys securely; don't commit to repos
- **File access:** MCP has full read/write access to your vault

---

## Resources

- [obsidian-claude-code-mcp](https://github.com/iansinnott/obsidian-claude-code-mcp)
- [mcp-obsidian (REST API)](https://github.com/MarkusPfundstein/mcp-obsidian)
- [mcp-obsidian (smithery)](https://github.com/smithery-ai/mcp-obsidian)
- [Obsidian Local REST API](https://github.com/coddingtonbear/obsidian-local-rest-api)
