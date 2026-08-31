---
description: Cria um ticket Jira no projeto DEV seguindo o padrão NORMUS. Use quando o usuário digitar /ticket.
---

# Criar ticket Jira — NORMUS (projeto DEV)

Você vai criar um ticket no Jira (projeto **DEV**) seguindo o padrão NORMUS. **Nunca crie no Jira sem antes apresentar a proposta completa e receber confirmação explícita do usuário.**

## $ARGUMENTS

O que vier depois de `/ticket` é o pedido inicial do usuário (resumo/caminho do que criar). Use como ponto de partida; complete o restante com perguntas quando necessário.

## Passo 1 — Carregar o padrão

Carregue a skill `jira-ticket` para obter o template canônico (seções e convenções). Se ela não estiver disponível, use `norm-core/docs/guides/jira-ticket.md` como fonte canônica.

## Passo 2 — Coletar os dados essenciais

Reúna (pergunte o que não estiver claro, em linguagem natural, PT-BR):

- **Resumo (summary)** — título curto e direto.
- **Issue type** — `Story` (entrega), `Task` ou `Bug`.
- **Repo alvo** — `norm-core`, `norm-store-frontend`, `norm-store-management`, etc.
- **Estimativa (pts)** e **Risco** (baixo/médio/alto + motivo).
- **Épico / relacionados** (ex.: DEV-178) se fizer parte de um épico.
- **Labels** — área (ex.: `backend`, `seguranca`, `frontend`, `ux`) + repo alvo.

## Passo 3 — Montar a description

Escreva a description **em português**, no template NORMUS, usando apenas as seções que fizerem sentido (corte o resto). Seções de ouro (quase sempre inclua): **🗂️ Mapa de arquivos** e **✅ Critérios de aceite**. Regra: detalhado em escopo/arquivos, enxuto em prosa/código — descreva o que muda e onde, sem colar código novo.

## Passo 4 — Apresentar a proposta para revisão

Antes de criar, apresente claramente:
- Resumo.
- Tipo (Story/Task/Bug).
- Labels.
- Épico/parent (se houver).
- A description completa (ou um resumo bem detalhado dela).

Aguarde a confirmação explícita do usuário antes de seguir.

## Passo 5 — Criar no Jira (somente após aprovação)

Use as ferramentas do MCP do Jira (servidor `atlassian`) para criar a issue:

- `projectKey`: `DEV`
- `issueTypeName`: conforme definido
- `summary`: o resumo
- `description`: a description no padrão NORMUS (markdown)
- `additional_fields`: `labels` (área + repo), e `parent`/epic se aplicável.

Depois de criada, retorne o **KEY** (ex.: DEV-184) e o link da issue.
