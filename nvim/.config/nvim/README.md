# 💤 LazyVim

![Nvim cover](./.git_images/nvim-menu.png)

## Prerequisites

- [NeoVim](https://neovim.io/)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [NerdFont](https://www.nerdfonts.com/font-downloads): For the best experience, it's recommended to use a Nerd Font, such as `JetBrainsMono Nerd Font`, to properly display icons
- [RipGrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation): Optional, but highly recommended, `ripgrep` removes directories like `node_modules` from the `Find Files (space + space)` function within neovim.
- [Xclip](https://terminalroot.com.br/2020/10/copie-e-cole-via-linha-de-comando-do-linux-com-xclip.html): Optional, but highly recommended, `xclip` allows copying and pasting content via command line.

## Installation

1. Install `lazygit` and configure an `alias` (optional) in your terminal settings:

![Lazygit alias](./.git_images/alias-lazygit.png)

## Commands

- [Key Maps](https://www.lazyvim.org/keymaps)

## Theming

This standalone config uses [Shatur/neovim-ayu](https://github.com/Shatur/neovim-ayu) through
`lua/plugins/ayu-theme.lua`.

> **On Omarchy:** the active Omarchy theme supplies the Neovim colorscheme. Its `neovim.lua`
> is staged at `~/.local/state/omarchy/current/theme/neovim.lua` and linked to
> `~/.config/nvim/lua/plugins/theme.lua`, so on a themed machine the colorscheme comes from
> the `omarchy` Stow package, not from this one. See
> [Neovim theming under Omarchy](../../../README.md#neovim-theming-under-omarchy) for the
> Stow folding caveat.