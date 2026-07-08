---
description: Reviews the user's stored English errors from /en practice and suggests personalized study topics. Use when the user types /en-review.
---

# EN Review - Error Analysis & Study Suggestions

Read the error history from `~/.config/opencode/en-errors.json` and analyze it.

## What to do

1. **Read** the error file at `~/.config/opencode/en-errors.json`.
2. **Count and categorize** all errors by type (grammar, spelling, vocabulary, etc.).
3. **Identify patterns** — what does the user most frequently get wrong?
4. **Suggest study topics** — 3-5 specific grammar/vocabulary topics to focus on.
5. **Recommend vocabulary** related to their most common topics of conversation.

## Response format

```
📊 **Resumo dos Erros** (total: X erros)

| Tipo | Quantidade | % |
|------|-----------|----|
| grammar | X | X% |
| spelling | X | X% |
| ...

🎯 **Padrões Detectados**
- <pattern 1>
- <pattern 2>

📚 **Tópicos Recomendados para Estudar**
1. <topic> — <why this matters>
2. <topic> — <why this matters>
3. ...

📖 **Vocabulário para Praticar**
- <word/phrase> → 🇧🇷 <translation>
- <word/phrase> → 🇧🇷 <translation>

💪 **Exemplos Corrigidos**
<show 2-3 past errors with corrections as reminders>
```

If the error file doesn't exist or is empty, say "Nenhum erro registrado ainda! Pratique usando /en nos seus prompts."
