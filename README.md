# Dotfiles

Este repositório contém minhas configurações pessoais para diversas ferramentas utilizando GNU stow para facilitar o gerenciamento e setup em outros dispositivos.

## O que é GNU Stow?

GNU Stow é uma ferramenta de gerenciamento de pacotes symlink, que facilita a instalação de pacotes de software criando links simbólicos em diretórios de destino a partir de um diretório central. Isso permite manter os arquivos de configuração organizados em um único lugar e simplifica o processo de configuração em novos sistemas.

## E para instalar o Stow?

- **Arch distros**

   ```bash
   sudo pacman -S stow
   ```
   
- **Debian distros**

  ```bash
  sudo apt install stow
  ```
- Para outras formas de instalação, consultar a documentaçao: https://www.gnu.org/software/stow/

## Ferramentas Gerenciadas

- [**LazyVim**](https://www.lazyvim.org/): Em caso de dúvidas, acesse as [configurações](./nvim/.config/nvim/README.md).
- [**ZED**](https://zed.dev/): IDE.
- [**Fish**](https://fishshell.com/): clique [aqui](./fish/.config/fish/README.MD) para ver mais informações.
- [**Kitty**](https://sw.kovidgoyal.net/kitty/): Terminal.
- [**Yazi**](https://yazi-rs.github.io/): Explorador de arquivos.

## Instalação

Para instalar as configurações, siga estas etapas:

1. Clone este repositório para o seu diretório home:

   ```bash
   git clone https://github.com/Wallauerr/dotfiles.git ~/Dotfiles
   ```

2. Navegue até o diretório `Dotfiles`:

   ```bash
   cd ~/Dotfiles
   ```

3. Use o GNU Stow para criar links simbólicos para os arquivos de configuração desejados:
   ```bash
   stow nvim
   stow zed
   stow fish
   stow kitty
   stow yazi
   ```

## Desinstalação

Para remover as configurações, navegue até o diretório `Dotfiles` e use o comando `stow -D` seguido do nome do pacote:

```bash
cd ~/Dotfiles

stow -D nvim
stow -D zed
stow -D fish
stow -D kitty
stow -D yazi
```
