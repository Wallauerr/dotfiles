# Dotfiles

This repository contains my personal configurations for various tools using GNU Stow to facilitate management and setup on other devices.

## What is GNU Stow?

GNU Stow is a symlink package manager that facilitates software package installation by creating symbolic links in target directories from a central directory. This allows keeping configuration files organized in a single place and simplifies the setup process on new systems.

## How to install Stow?

- **Arch distros**

   ```bash
   sudo pacman -S stow
   ```

- **Debian distros**

  ```bash
  sudo apt install stow
  ```

- For other installation methods, check the documentation: <https://www.gnu.org/software/stow/>

## Managed Tools

- [**Hyprland**](https://hypr.land/): Window manager with custom keybinds, animations, gaps/rounding, groupbar, and window rules.
- [**Waybar**](https://github.com/Alexays/Waybar): Status bar with themed modules (clock, weather, window-info, workspace, audio, network, bluetooth, battery). Clock shows calendar tooltip on hover. Tray icons always visible. Weather uses local script with emoji icons.
- [**Omarchy**](https://omarchy.sh): Theme system managed by **aether**. Distributed across three packages that are safe to stow:
  - **`omarchy-shell`**: the Omarchy Quickshell config (`shell.json` — bar plugins, disabled stock plugins, and `cloneSourceRestores`). The Quickshell reload watcher debounces changes (150 ms), so symlinking is safe.
  - **`omarchy-plugins`**: the custom lock screen plugin `wallauer.lock` ("My Lock Screen") — a port of the hyprlock "Dashboard Edition" to the Omarchy/Quickshell lock screen, with music via MPRIS (no `playerctl` needed).
  - **`omarchy`**: custom themes, currently `ayu-dark` (colors, icons, lock screen palette, and its Neovim colorscheme). See [Neovim theming under Omarchy](#neovim-theming-under-omarchy).

  > **Note:** Theme files under `~/.config/omarchy/current/` are written directly by aether after `omarchy theme set` — they are not tracked here anymore.

  > **Setup:** Place a `profile.jpg` photo in `~/.config/omarchy/plugins/wallauer.lock/` (the plugin's own directory) for the lock screen to display it.

- [**LazyVim**](https://www.lazyvim.org/): In case of questions, check the [configurations](./nvim/.config/nvim/README.md).
- [**ZED**](https://zed.dev/): IDE.
- [**Fish**](https://fishshell.com/): click [here](./fish/.config/fish/README.MD) for more information.
- [**Ghostty**](https://ghostty.org/): Terminal (default via `xdg-terminals.list`, font ligatures support).
- [**Yazi**](https://yazi-rs.github.io/): File explorer.
- [**Mise**](https://mise.en.dev/): Runtime version manager; also manages opencode, codex, gh and ollama.
- [**Opencode**](https://opencode.ai): AI coding agent — config, commands and skills (installed by mise from npm). Click [here](./opencode/.config/opencode/README.md) for more information.
- [**Zellij**](https://zellij.dev/): Terminal Workspace.

## Neovim theming under Omarchy

Omarchy stages the active theme into `~/.local/state/omarchy/current/theme/` and links
`~/.config/nvim/lua/plugins/theme.lua` to that staged `neovim.lua`. The theme's `neovim.lua`
therefore owns the Neovim colorscheme: `ayu-dark` ships the `Shatur/neovim-ayu` setup in
`omarchy/.config/omarchy/themes/ayu-dark/neovim.lua`.

An empty `return {}` is **not** neutral. Omarchy sees that the theme already ships a
`neovim.lua` and skips rendering its built-in `aether` template from `colors.toml`, so
Neovim ends up with no colorscheme and falls back to whatever LazyVim loads. Every theme
that should color Neovim needs a real `neovim.lua`.

### Stow caveat: fold the theme directory

`omarchy theme set` copies the theme with `cp -r`, which preserves symbolic links. Stow
creates links relative to their location, so per-file links inside a theme directory break
as soon as they are copied into `~/.local/state/omarchy/current/theme/`. The theme directory
must be stowed as a single folded link:

```bash
cd ~/dotfiles
rm -rf ~/.config/omarchy/themes/ayu-dark   # links only; the real files live in this repo
stow omarchy                               # one link: ayu-dark -> repo
```

Confirm it stayed folded (the target is a directory, not a file):

```bash
ls -ld ~/.config/omarchy/themes/ayu-dark
# ... ayu-dark -> ../../../dotfiles/omarchy/.config/omarchy/themes/ayu-dark
```

Never use `stow --adopt omarchy` for themes. It leaves the target as a real directory, so
Stow falls back to linking each file individually — the broken layout. If that happens,
remove the target directory and run `stow omarchy` again. On a fresh machine the theme
directory does not exist yet, so a plain `stow omarchy` folds it correctly.

### Changing the theme

1. Edit the file in this repo, e.g. `omarchy/.config/omarchy/themes/ayu-dark/neovim.lua`.
2. Restage it with `omarchy theme set ayu-dark`. Neovim's hot-reload watches the staged file
   under `~/.local/state/omarchy/`, not the copy in this repo.
3. Commit the change.

Verify the result with:

```bash
nvim --headless "+sleep 2" "+lua print(vim.g.colors_name)" +qa
# ayu
```

## Installation

To install the configurations, follow these steps:

1. Clone this repository to your home directory:

   ```bash
   git clone https://github.com/Wallauerr/dotfiles.git ~/Dotfiles
   ```

2. Navigate to the `Dotfiles` directory:

   ```bash
   cd ~/Dotfiles
   ```

3. Use GNU Stow to create symbolic links for the desired configuration files:

   ```bash
   stow nvim
   ```

   > **Note:** `omarchy-shell`, `omarchy-plugins`, and `omarchy` can be stowed normally — the shell's reload watcher coalesces file events. On a machine where Omarchy already created `~/.config/omarchy/themes/ayu-dark`, remove that directory before `stow omarchy`; see [Stow caveat](#stow-caveat-fold-the-theme-directory).

## Uninstallation

To remove the configurations, navigate to the `Dotfiles` directory and use the `stow -D` command followed by the package name:

```bash
cd ~/Dotfiles
stow -D nvim
```
