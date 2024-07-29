# Dotfiles

Este repositório contém minhas configurações pessoais para diversas ferramentas utilizando GNU stow para facilitar o gerenciamento e setup em outros dispositivos.

## O que é GNU Stow?

GNU Stow é uma ferramenta de gerenciamento de pacotes symlink, que facilita a instalação de pacotes de software criando links simbólicos em diretórios de destino a partir de um diretório central. Isso permite manter os arquivos de configuração organizados em um único lugar e simplifica o processo de configuração em novos sistemas.

## Ferramentas Gerenciadas

- **nvim (Neovim)**: Editor de texto
- **ZED**: Editor de texto

## Instalação

Para instalar as configurações, siga estas etapas:

1. Clone este repositório para o seu diretório home:

   ```bash
   git clone https://github.com/Wallauerr/dotfiles.git ~/Dotfiles
   ```

2. Navegue até o diretório `dotfiles`:

   ```bash
   cd ~/dotfiles
   ```

3. Use o GNU Stow para criar links simbólicos para os arquivos de configuração desejados:
   ```bash
   stow nvim
   stow zed
   ```

## Desinstalação

Para remover as configurações, navegue até o diretório `dotfiles` e use o comando `stow -D` seguido do nome do pacote:

```bash
cd ~/dotfiles
stow -D nvim
stow -D zed
```
