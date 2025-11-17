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

- [**LazyVim**](https://www.lazyvim.org/): In case of questions, check the [configurations](./nvim/.config/nvim/README.md).
- [**ZED**](https://zed.dev/): IDE.
- [**Fish**](https://fishshell.com/): click [here](./fish/.config/fish/README.MD) for more information.
- [**Kitty**](https://sw.kovidgoyal.net/kitty/): Terminal.
- [**Yazi**](https://yazi-rs.github.io/): File explorer.

## Installation

To install the configurations, follow these steps:

1. Clone this repository to your home directory:

   ```bash
   git clone https://github.com/Wallauerr/dotfiles.git ~/dotfiles
   ```

2. Navigate to the `dotfiles` directory:

   ```bash
   cd ~/dotfiles
   ```

3. Use GNU Stow to create symbolic links for the desired configuration files:

   ```bash
   stow nvim
   ```

## Uninstallation

To remove the configurations, navigate to the `dotfiles` directory and use the `stow -D` command followed by the package name:

```bash
cd ~/dotfiles
stow -D nvim
```
