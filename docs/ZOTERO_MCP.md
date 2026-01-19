# Zotero MCP: Research Library Integration

Zotero MCP connects your [Zotero](https://www.zotero.org/) research library with Claude Code, enabling AI-powered literature search, citation management, and PDF annotation extraction.

---

## Overview

| Feature | Description |
|---------|-------------|
| **Semantic Search** | AI-powered similarity search across your library |
| **BibTeX Export** | Export citations directly to `.bib` files |
| **PDF Annotations** | Extract highlights and notes from PDFs |
| **Collection Management** | Browse and search collections, tags |
| **Full-Text Search** | Search paper content, not just metadata |

---

## Installation

### Prerequisites

- Python 3.10+
- Zotero 7+ (for local API with full-text access)
- [Better BibTeX plugin](https://retorque.re/zotero-better-bibtex/installation/) (recommended)

### Install via uv (Recommended)

```bash
uv tool install "git+https://github.com/54yyyu/zotero-mcp.git"
zotero-mcp setup
```

### Install via pip

```bash
pip install git+https://github.com/54yyyu/zotero-mcp.git
zotero-mcp setup
```

### Install via Smithery

```bash
npx -y @smithery/cli install @54yyyu/zotero-mcp --client claude
```

---

## Configuration

### Claude Code Integration

Add to your Claude Code settings (`~/.claude/settings.json` or project `.claude/settings.json`):

```json
{
  "mcpServers": {
    "zotero": {
      "command": "zotero-mcp",
      "env": {
        "ZOTERO_LOCAL": "true"
      }
    }
  }
}
```

### Web API (Remote Access)

For accessing your library remotely:

```bash
zotero-mcp setup --no-local --api-key YOUR_API_KEY --library-id YOUR_LIBRARY_ID
```

Get your API key at: https://www.zotero.org/settings/keys

### Environment Variables

| Variable | Description |
|----------|-------------|
| `ZOTERO_LOCAL` | Use local Zotero API (default: false) |
| `ZOTERO_API_KEY` | API key for web access |
| `ZOTERO_LIBRARY_ID` | Library ID for web access |
| `ZOTERO_LIBRARY_TYPE` | `user` or `group` (default: user) |

---

## Semantic Search Setup

Enable AI-powered similarity search:

```bash
# Configure during setup
zotero-mcp setup

# Or configure separately
zotero-mcp setup --semantic-config-only
```

### Embedding Models

| Model | Cost | Quality | Notes |
|-------|------|---------|-------|
| **Default** (all-MiniLM-L6-v2) | Free | Good | Runs locally |
| **OpenAI** (text-embedding-3-small) | Paid | Better | Requires API key |
| **Gemini** (text-embedding-004) | Paid | Better | Requires API key |

### Build the Search Database

```bash
# Fast metadata-only indexing
zotero-mcp update-db

# Comprehensive full-text indexing (slower)
zotero-mcp update-db --fulltext

# Check database status
zotero-mcp db-status
```

### Update Frequency

- **Manual**: Run `zotero-mcp update-db` when needed
- **Auto on startup**: Updates every server start
- **Daily**: Automatic daily updates
- **Every N days**: Custom interval

---

## Available Tools

### Search Tools

| Tool | Description |
|------|-------------|
| `zotero_search_items` | Search by keywords |
| `zotero_advanced_search` | Complex multi-criteria search |
| `zotero_semantic_search` | AI similarity search |
| `zotero_search_by_tag` | Filter by tags |
| `zotero_get_recent` | Recently added items |

### Content Tools

| Tool | Description |
|------|-------------|
| `zotero_get_item_metadata` | Detailed metadata (supports BibTeX) |
| `zotero_get_item_fulltext` | Full text content |
| `zotero_get_item_children` | Attachments and notes |

### Annotation Tools

| Tool | Description |
|------|-------------|
| `zotero_get_annotations` | PDF annotations |
| `zotero_get_notes` | Retrieve notes |
| `zotero_search_notes` | Search in notes |
| `zotero_create_note` | Create new notes |

### Collection Tools

| Tool | Description |
|------|-------------|
| `zotero_get_collections` | List collections |
| `zotero_get_collection_items` | Items in collection |
| `zotero_get_tags` | List all tags |

---

## Common Workflows

### Export BibTeX Citation

```text
"Get the BibTeX citation for this paper on extended mind thesis"
```

Zotero MCP will search, find the item, and export:

```bibtex
@article{clark1998extended,
  author = {Clark, Andy and Chalmers, David},
  title = {The Extended Mind},
  journal = {Analysis},
  year = {1998}
}
```

### Find Related Papers

```text
"Find papers conceptually similar to distributed cognition"
```

Semantic search returns papers with similarity scores based on meaning, not just keywords.

### Extract PDF Annotations

```text
"Extract all my highlights from the Vygotsky paper"
```

Returns highlighted text, notes, and page numbers.

### Search by Tag Combinations

```text
"Show papers tagged #cognitive-science but not #neuroscience"
```

---

## Integration with Bibliography Files

### Syncing with references.bib

Manual workflow for academic projects:

1. **Search in Zotero MCP:**
   ```text
   "Find the Hutchins 1995 cognition in the wild paper"
   ```

2. **Export BibTeX:**
   ```text
   "Export this as BibTeX"
   ```

3. **Add to references.bib** — Copy the output to your `.bib` file

### Recommended Tagging Convention

Organize sources by topic:

| Tag | Purpose |
|-----|----------|
| `#cognitive-science` | Cognitive science sources |
| `#philosophy` | Philosophy sources |
| `#ai-research` | AI/ML papers |
| `#methodology` | Methodology/methods |
| `#to-read` | Reading queue |
| `#cited` | Already cited in your work |

---

## Troubleshooting

### "No results found"

**Cause:** Zotero not running or local API disabled.

**Fix:** 
1. Start Zotero desktop
2. Go to Preferences → Advanced
3. Enable "Allow other applications on this computer to communicate with Zotero"

### Semantic search returns no results

**Cause:** Database not initialized.

**Fix:**
```bash
zotero-mcp update-db
zotero-mcp db-status
```

### Full text not available

**Cause:** Using older Zotero version.

**Fix:** Upgrade to Zotero 7+ for local full-text access.

### BibTeX export missing fields

**Cause:** Better BibTeX plugin not installed.

**Fix:** Install [Better BibTeX](https://retorque.re/zotero-better-bibtex/installation/) for enhanced export.

### Slow database updates

**Cause:** Full-text indexing on large library.

**Fix:** 
- Use `--limit` for testing: `zotero-mcp update-db --limit 100`
- Use metadata-only for speed: `zotero-mcp update-db` (without `--fulltext`)

---

## Commands Reference

```bash
# Server
zotero-mcp serve                    # Run MCP server
zotero-mcp serve --transport stdio  # Specify transport

# Setup
zotero-mcp setup                    # Interactive configuration
zotero-mcp setup --semantic-config-only  # Configure semantic search only
zotero-mcp setup-info               # Show installation info

# Database
zotero-mcp update-db                # Update semantic DB (metadata)
zotero-mcp update-db --fulltext     # Update with full-text
zotero-mcp update-db --force-rebuild  # Force rebuild
zotero-mcp db-status                # Check DB status

# Maintenance
zotero-mcp update                   # Update to latest version
zotero-mcp update --check-only      # Check for updates
zotero-mcp version                  # Show version
```

---

## When to Use Zotero MCP

**Good fit:**
- Academic/research projects with citations
- Managing large literature collections
- Finding conceptually related papers
- Extracting annotations from PDFs

**Not needed:**
- Projects without bibliography requirements
- Small reference lists (manual BibTeX is fine)
- Non-academic documentation

---

## Resources

- [Zotero MCP GitHub](https://github.com/54yyyu/zotero-mcp)
- [Zotero MCP Documentation](https://stevenyuyy.us/zotero-mcp/)
- [Zotero](https://www.zotero.org/)
- [Better BibTeX](https://retorque.re/zotero-better-bibtex/)
