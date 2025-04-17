# Fish shell + Starship prompt

## O que é

`Fish` é um shell inteligente que pode ser combinado com algumas outras ferramentas **opcionais**:

- [**Starship**](https://starship.rs/): Personaliza o prompt com informações úteis e um visual moderno.
- [**EZA**](https://github.com/eza-community/eza): Uma alternativa moderna ao `ls` com:
  - Melhor visualização de arquivos
  - Suporte a ícones
  - Exibição em árvore
  - Cores e formatação aprimoradas

Foram criados aliases úteis:
- `l = eza --icons` (lista compacta com ícones)
- `ll = eza --tree --icons` (lista detalhada em árvore)

Fique à vontade para alterá-los editando o arquivo de [configuração](config.fish).

## Importante!

Torne o `fish` seu shell padrão:

```bash
chsh -s $(which fish)
```
Reinicie seu terminal para aplicar as mudanças.
