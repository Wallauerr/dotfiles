# Opencode (AI coding agent)

## What it is

[**Opencode**](https://opencode.ai) is a terminal-based AI coding agent. This package holds its configuration, custom commands and skills. The binary itself is **not** part of this repo — it is installed by [mise](../../../mise/.config/mise/README.md) from npm (`npm:opencode-ai`).

## Files

| Path | Description |
|---|---|
| `opencode.json` | Main config: MCP servers, extra skill paths, update check |
| `command/ticket.md` | `/ticket` — creates a Jira ticket in the DEV project following the NORMUS pattern (PT-BR) |
| `command/en-review.md` | `/en-review` — analyzes the stored English mistakes and suggests study topics |
| `skills/jira-ticket/SKILL.md` | NORMUS ticket template and conventions (sections, labels, issue type) |
| `skills/en/SKILL.md` | English practice: vocabulary bridge, corrections and error history |

## Installation

The binary comes from mise (see the [mise readme](../../../mise/.config/mise/README.md)):

```toml
"npm:opencode-ai" = { version = "latest", allow_builds = ["opencode-ai"] }
```

`allow_builds` is required — without it mise skips the `postinstall` script and leaves a broken stub instead of the real binary.

To link the config into place:

```bash
cd ~/Dotfiles
stow opencode
```

`opencode.json`, `command` and `skills` end up symlinked inside `~/.config/opencode`; the remaining files there (see [local state](#local-state-not-tracked)) are ignored.

## Config

```json
{
  "$schema": "https://opencode.ai/config.json",
  "autoupdate": false,
  "skills": {
    "paths": ["~/.config/opencode/skills"]
  },
  "mcp": {
    "atlassian": {
      "type": "remote",
      "url": "https://mcp.atlassian.com/v1/mcp/authv2",
      "enabled": true,
      "timeout": 30000
    }
  }
}
```

- `autoupdate: false` disables opencode's own update check: [mise](../../../mise/.config/mise/README.md) owns the version, and the two would fight over it.
- `skills.paths` points to the skills tracked in this repo.

## MCP: Atlassian

The Atlassian remote server gives access to Jira, Confluence and Compass.

- `timeout` **must** be raised from the default (5000 ms): the server needs longer for the OAuth discovery and the initialize handshake. With the default timeout opencode falls back to the legacy SSE transport, which the server rejects with HTTP 400 and which masks the real error.
- Authentication is OAuth. After the first login the tokens are stored in `~/.local/share/opencode/mcp-auth.json`.

| Command | Description |
|---|---|
| `opencode mcp list` | Show the servers and their status |
| `opencode mcp auth atlassian` | Authenticate (or re-authenticate) the Atlassian server |
| `opencode mcp logout atlassian` | Remove the stored credentials |
| `opencode mcp debug atlassian` | Debug the OAuth connection |

## Local state (not tracked)

Some files live only in `~/.config/opencode` and are ignored by the local `.gitignore`:

| Path | Description |
|---|---|
| `en-errors.json` | English error history written by the `en` skill (used by `/en-review`) |
| `node_modules/`, `package.json`, `bun.lock` | Local plugin dependencies |
