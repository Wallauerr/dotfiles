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
- [**Omarchy**](https://opencode.ai): Theme system managed by **aether**. Distributed across two packages that are safe to stow:
  - **`omarchy-shell`**: the Omarchy Quickshell config (`shell.json` — bar plugins, disabled stock plugins, and `cloneSourceRestores`). The Quickshell reload watcher debounces changes (150 ms), so symlinking is safe.
  - **`omarchy-plugins`**: the custom lock screen plugin `wallauer.lock` ("My Lock Screen") — a port of the hyprlock "Dashboard Edition" to the Omarchy/Quickshell lock screen, with music via MPRIS (no `playerctl` needed).

  > **Note:** Theme files under `~/.config/omarchy/current/` are written directly by aether after `omarchy theme set` — they are not tracked here anymore.

  > **Setup:** Place a `profile.jpg` photo in `~/.config/omarchy/plugins/wallauer.lock/` (the plugin's own directory) for the lock screen to display it.
- [**LazyVim**](https://www.lazyvim.org/): In case of questions, check the [configurations](./nvim/.config/nvim/README.md).
- [**ZED**](https://zed.dev/): IDE.
- [**Fish**](https://fishshell.com/): click [here](./fish/.config/fish/README.MD) for more information.
- [**Ghostty**](https://ghostty.org/): Terminal (default via `xdg-terminals.list`, font ligatures support).
- [**Yazi**](https://yazi-rs.github.io/): File explorer.
- [**Mise**](https://mise.en.dev/): Runtime version manager.
- [**Zellij**](https://zellij.dev/): Terminal Workspace.

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

   > **Note:** Both `omarchy-shell` and `omarchy-plugins` can be stowed normally — the shell's reload watcher coalesces file events.

## Uninstallation

To remove the configurations, navigate to the `Dotfiles` directory and use the `stow -D` command followed by the package name:

```bash
cd ~/Dotfiles
stow -D nvim
```
