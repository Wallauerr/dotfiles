# Fish shell + Starship prompt

## What it is

`Fish` is an intelligent shell that can be combined with some other **optional** tools:

- [**Starship**](https://starship.rs/): Customizes the prompt with useful information and a modern look.
- [**EZA**](https://github.com/eza-community/eza): A modern alternative to `ls` with:
  - Better file visualization
  - Icon support
  - Tree display
  - Enhanced colors and formatting
- [**Yazi**](https://yazi-rs.github.io/): Terminal file manager with:
  - Fast and asynchronous navigation
  - File preview
  - `vim` command usage

Useful aliases have been created:
- `l = eza --icons` (compact list with icons)
- `lt = eza --tree --icons` (detailed tree list)
- `ll = yazi` (file explorer)
- `lg = lazygit` (lazygit)

Feel free to modify them by editing the [configuration](config.fish) file.

## Important!

Make `fish` your default shell:

```bash
chsh -s $(which fish)
```
Restart your terminal to apply the changes.