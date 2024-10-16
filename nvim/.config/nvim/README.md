# Neovim

![Nvim cover](./.git_images/nvim-menu.png)

## Índice

- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Comandos](#comandos)

## Pré-requisitos

- [Neovim](https://neovim.io/)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [NerdFont](https://www.nerdfonts.com/font-downloads): Para melhor experiência, recomenda-se o uso de uma Nerd Font, como a `JetBrainsMono Nerd Font`, para conseguir visualizar os ícones corretamente

## Instalação

1. Instale o `lazygit` e configure um `alias` nas configurações do seu terminal:

![Lazygit alias](./.git_images/alias-lazygit.png)

2. Dentro do neovim instale o `eslint_d` e o `prettier` via Mason:

![Mason-cover](./.git_images/mason-configuration.png)

## Comandos

### Procurar arquivos:
- Abrir tree files: `ctrl + n`
- Abrir telescope: `ctrl + p`
### Navegação de janelas:
- Abrir lazygit `space + lg`
- Abrir ou fechar terminal `space + ot`
- Navegar entre janelas `ctrl + h,j,k,l`
### Ações
- Hover mouse: `space + ci`
- Abrir code actions: `space + ca`
- Abrir definições: `space + cd`
### Navegação em código
- Navegar: `h,j,k,l`
- Desfazer: `u`
- Scroll up: `ctrl + b`
- Scroll down: `ctrl + f`
- Próxima palavra: `ctrl + space`
### Formatar
- Rodar o linting: `space + gf`
