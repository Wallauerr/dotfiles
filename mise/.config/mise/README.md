# Mise (Runtime version manager)

## What it is

[**Mise**](https://mise.en.dev/) is a polyglot tool version manager that replaces `nvm`, `pyenv`, `asdf`, and others. It manages runtimes **and** apps (opencode, codex, gh, ollama) from a single `config.toml` file.

## Prerequisites

- [Curl](https://curl.se/) — for installing mise
- **mise >= 2026.10.17** — required by the npm backend to run the `postinstall` script of the packages listed in `allow_builds` (see [opencode](#opencode-and-the-npm-backend))

## Installation

```bash
curl https://mise.run | sh
```

Activation is already part of the [fish config](../../../fish/.config/fish/config.fish):

```fish
# mise
# outside the interactive block to also apply to non-interactive shells
if command -qv mise
    mise activate fish | source
end
```

> **Note:** the block must stay at the **end** of `config.fish`: mise prepends its tool dirs to `PATH` when it activates, so it has to run after any other prepend to win over `~/.local/bin` and `/snap/bin`.

## Config file

`~/.config/mise/config.toml` (tracked in this repo) defines the default versions for all tools:

```toml
[tools]
node = "24.18.0"
"npm:typescript" = "latest"
"npm:typescript-language-server" = "latest"
"npm:pnpm" = "latest"
"npm:opencode-ai" = { version = "latest", allow_builds = ["opencode-ai"] }
bun = "latest"
elixir = "1.20.4-otp-29"
erlang = "29.0.6"
lua-language-server = "latest"
tree-sitter = "latest"
codex = "latest"
gh = "latest"
ollama = "latest"

[settings]
self_update.auto = true
self_update.check_duration = "7d"
minimum_release_age = "7d"
```

### Settings

| Setting | Description |
|---|---|
| `self_update.auto` | mise updates itself automatically |
| `self_update.check_duration` | how often mise checks for its own updates (every 7 days) |
| `minimum_release_age` | releases published less than 7 days ago are ignored, so `latest` means the newest **settled** release |

Consequences:

- `mise upgrade` reports newer releases (e.g. opencode 1.19.3) as *ignored* while they are younger than 7 days — that is expected.
- Pinned versions (`node`, `elixir`, `erlang`) are not touched by `mise upgrade`; use `mise upgrade --bump` to move them to the newest release and rewrite the config.
- The version upgraded away from is removed after the `upgrade.prune_after` grace period (24h by default), since `upgrade.auto_prune` defaults to `true`.

## opencode and the npm backend

opencode is installed by mise from npm — not from snap, bun or aqua:

```toml
"npm:opencode-ai" = { version = "latest", allow_builds = ["opencode-ai"] }
```

- `allow_builds` is **required**: without it mise skips the `postinstall` script and leaves a broken ~479 byte stub instead of the real binary.
- The npm backend needs mise >= 2026.10.17 to run that build script with any npm version.
- Never install opencode from another source: the mise one must be the only one in `PATH` (`which opencode` → `~/.local/share/mise/installs/npm-opencode-ai/latest/node_modules/.bin/opencode`).
- The opencode config disables its own update check (`autoupdate`), since mise owns the version.

## Commands

| Command | Description |
|---|---|
| `mise ls` | List installed tools and versions |
| `mise ls --prunable` | List installed versions that nothing uses anymore |
| `mise install` | Install all tools from `config.toml` |
| `mise install node@22` | Install a specific version |
| `mise use node@22` | Use Node 22 in the current project (creates local `.mise.toml`) |
| `mise use -g node@22` | Set a global version in `config.toml` |
| `mise ls-remote node` | List available versions |
| `mise outdated` | Show outdated tools |
| `mise upgrade` | Update to the newest version inside the configured range |
| `mise upgrade --bump` | Update to the newest release (even outside the range) and rewrite the config |
| `mise prune` | Remove installed versions that no config selects |
| `mise self-update` | Update mise itself |
| `mise settings` | Show the effective settings and where they come from |

## Auto-install

mise creates shims for every tool, so a missing version is installed **on first use**:

```toml
# .mise.toml in a project
[tools]
node = "23"
```

Running any command in that directory installs Node 23 automatically. mise does **not** install anything just because you `cd` into a directory.

## Per-project config

Each project can have its own `.mise.toml` to override the global versions:

```toml
[tools]
node = "20.11.0"
```

## Important!

After editing `config.toml`, run `mise install` to download any new or updated tools.
