# Mise (Runtime version manager)

## What it is

[**Mise**](https://mise.en.dev/) is a polyglot tool version manager that replaces `nvm`, `pyenv`, `asdf`, and others. It manages runtimes and tools from a single `config.toml` file.

## Prerequisites

- [Curl](https://curl.se/) — for installing mise

## Installation

```bash
curl https://mise.run | sh
```

Then activate it in your shell by adding to `~/.config/fish/config.fish`:

```fish
~/.local/bin/mise activate fish | source
```

## Config file

The global config defines the default versions for all tools:

```toml
[tools]
node = "24.18.0"
"npm:typescript" = "latest"
"npm:typescript-language-server" = "latest"
"npm:pnpm" = "latest"
bun = "latest"
elixir = "1.20.1-otp-29"
erlang = "29.0.2"
lua-language-server = "latest"
tree-sitter = "latest"
```

## Commands

| Command | Description |
|---|---|
| `mise ls` | List installed tools and versions |
| `mise install` | Install all tools from `config.toml` |
| `mise install node@22` | Install a specific version |
| `mise use node@22` | Use Node 22 in the current project (creates local `.mise.toml`) |
| `mise use -g node@22` | Set a global version in `config.toml` |
| `mise ls-remote node` | List available versions |
| `mise outdated` | Show outdated tools |
| `mise upgrade` | Update to the latest version |
| `mise prune` | Remove unused versions |

## Per-project config

Each project can have its own `.mise.toml` to override global versions:

```toml
[tools]
node = "20.11.0"
```

Mise automatically selects the correct version when you enter the directory.

## Important!

After editing `config.toml`, run `mise install` to download any new or updated tools.
