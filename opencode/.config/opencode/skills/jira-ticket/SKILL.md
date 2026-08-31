---
name: jira-ticket
description: Criação e edição de tickets Jira no padrão NORMUS (projeto DEV). Use when criando, editando ou planejando um ticket/card Jira do projeto DEV — garante o template canônico (Missão, Contexto, Mapa de arquivos, Plano, Armadilhas, Decisões, Critérios de aceite, Verificação, Cross-repo, Referências) e as convenções de labels, issue type, commit, branch e PR.
---

# Template de ticket Jira — NORMUS

Padrão de descrição para os cards do projeto **DEV**. Serve tanto para planejamento de sprint quanto como base de implementação (humano ou agente de IA). A regra é: **detalhado em escopo e arquivos, enxuto em prosa e código**. Não cole código novo — descreva o que muda e onde.

Nem todo card precisa de todas as seções. Use o que fizer sentido; corte o resto. As seções de ouro, que quase sempre valem a pena, estão marcadas com ⭐.

Fonte canônica: `norm-core/docs/guides/jira-ticket.md`. Se houver divergência, siga o arquivo-fonte.

---

## Seções do padrão

| Seção | Pra que serve |
|---|---|
| 🎯 **Missão** | A entrega em 1–2 frases. O "o quê" e o "pra quê". |
| 🧭 **Contexto** | Estado atual + por que a mudança é necessária. Bullets diretos. |
| 🗺️ **Estado atual → alvo** | Diagrama ASCII (`{noformat}`) do antes/depois. Só quando há mudança estrutural. |
| 🗂️ **Mapa de arquivos** ⭐ | Cada arquivo afetado + o que muda nele. O coração do card. Sem código. |
| 🧩 **Plano (ordem)** | Passos numerados na sequência de execução. |
| ⚠️ **Armadilhas** | Casos de borda e erros típicos. O que costuma quebrar. |
| 🔧 **Decisões (com recomendação)** | Pontos ambíguos já resolvidos com um caminho recomendado. |
| ✅ **Critérios de aceite** ⭐ | Checkboxes verificáveis. Define "pronto". |
| 🔍 **Verificação** | Comandos exatos para validar (build, test, lint, checagem manual). |
| 🔗 **Cross-repo / follow-up** | Dependências que viram outros cards. |
| 📎 **Referências** | Cards relacionados, repo, estimativa, risco. |

---

## Esqueleto (copiar e preencher)

~~~markdown
## 🎯 Missão

<Uma a duas frases: o que entregar e por quê.>

## 🧭 Contexto

- <Estado atual relevante.>
- <Restrição / fato técnico que importa.>
- <Por que agora / qual problema resolve.>
- Abordagem escolhida: <decisão de alto nível e a alternativa descartada>.

## 🗺️ Estado atual → alvo

```
ATUAL
  <diagrama>

ALVO
  <diagrama>
```

## 🗂️ Mapa de arquivos

**`caminho/da/pasta/`**
- `arquivo.ext` — <o que muda>.
- `arquivo_novo.ext` *(novo)* — <responsabilidade>.

## 🧩 Plano (ordem)

1. <Passo.>
2. <Passo.>

## ⚠️ Armadilhas

- **<Título curto>.** <O risco e como evitar.>

## 🔧 Decisões (com recomendação)

- **<Tema>** → <recomendação>.

## ✅ Critérios de aceite

- [ ] <Resultado verificável.>
- [ ] <Build/test/lint passam.>

## 🔍 Verificação

```
<comandos>
```
<Checagens manuais, se houver.>

## 🔗 Cross-repo / follow-up

- **<repo>**: <o que precisa mudar lá> (vira outro card).

## 📎 Referências

- Relacionado: <KEY>.
- Repo: <repo>.
- Estimativa: <n pts> · Risco: <baixo|médio|alto> (<motivo>).
~~~

---

## Convenções

- **Idioma:** português.
- **Tipo:** `Story` para entregas; `Task`/`Bug` conforme o caso.
- **Labels:** categorizam (ex.: `backend`, `seguranca`, `arquitetura`, repo alvo como `norm-core`).
- **Markdown → Jira:** o Jira renderiza Markdown. Use `##` para seções, `- [ ]` para checkboxes, blocos com crases para `{noformat}`. Caminhos e identificadores em `code` viram `{{monospace}}`.
- **Exemplo vivo:** DEV-57 segue este padrão na íntegra.

---

## Fluxo de tickets (commit / branch / PR)

Convenções adjacentes usadas no ciclo de vida de um ticket (ver `norm-core/.claude/`):

- **Commit:** `DEV-XX: description` (inglês, imperativo, sem prefixo convencional) ou `NO-TICKET: description`.
- **Branch:** `DEV-XX-short-description` ou `no-ticket/short-description`.
- **PR title:** `[DEV-XX] description` (colchetes, não dois-pontos).
- **PR body:** "O que foi feito", "Contexto", "Mudanças", "Critérios de aceite".

---

## Como criar um ticket DEV via MCP Jira

Ao criar um ticket no Jira (ferramentas `atlassian_*` / servidor MCP `atlassian`):

1. Peça/confirme os dados essenciais se não estiverem no pedido: resumo, repo alvo, estimativa em pts, epic/relacionados, labels.
2. Preencha a **description** com o esqueleto completo, no idioma português.
3. Defina **issuetype**: `Story` (entrega), `Task` ou `Bug`.
4. Adicione **labels**: área + repo alvo (ex.: `frontend`, `norm-store-management`).
5. Defina **parent**/epic quando fizer parte de um épico existente.
6. Se o padrão mudar no arquivo-fonte (`norm-core/docs/guides/jira-ticket.md`), atualize esta skill para manter a paridade.
