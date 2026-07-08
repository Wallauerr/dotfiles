---
name: en
description: Use when the user includes /en in their message OR writes English with Portuguese words mixed in. Provides vocabulary translations, English corrections, stores mistakes, and suggests improvements.
---

# EN - English Practice Skill

## Dual behavior

### 1. Auto vocab bridge (always active, no trigger needed)

When the user writes an English sentence with **Portuguese words embedded**:
- Automatically provide the correct English word + PT-BR translation
- Do this inline in your normal response, **very concise** — 1 line max
- Don't do full grammar analysis here, just the vocabulary swap

Example:
> User: `I dont know "oque" write here`
> You: (answer the question first, then at the end:)
> `✏️ "oque" → "what" 🇧🇷 oque = what`

Detection rule: if the message is mostly English but has 1-3 isolated Portuguese words, flag just those words. If the message is entirely Portuguese, skip.

### 2. Full /en analysis (triggered by /en)

Two modes:

**Inline** — user writes text + `/en` in the same message
→ Answer their question first, then do full English analysis.

**Standalone** — user sends just `/en` alone
→ Analyze the **previous user message** (their last message before `/en`).

## Full analysis task

1. **Answer the user's question first** — don't ignore their actual request.
2. **Identify English errors** (grammar, spelling, word choice, punctuation, awkward phrasing).
3. **Correct them concisely**.
4. **Store each error** in `~/.config/opencode/en-errors.json` (if mode allows writing).
5. **Translate unfamiliar words** to PT-BR.
6. **Suggest improvements** for natural, everyday English.

## Plan Mode handling

If Plan Mode prevents writing to disk:
- Still do the full analysis in your response
- Say `(⚠️ não salvo — Plan Mode read-only)` at the end

## Error storage format

Append to `~/.config/opencode/en-errors.json`.

```json
{
  "errors": [
    {
      "date": "2026-07-07T10:30:00Z",
      "original": "text with the error",
      "corrected": "corrected version",
      "type": "grammar | spelling | vocabulary | word_order | preposition | article | punctuation | awkward_phrasing | semantic",
      "details": "brief explanation",
      "topic": "grammar topic to study"
    }
  ]
}
```

## Error types
- `grammar` — verb tense, subject-verb agreement, pluralization
- `spelling` — misspelled words
- `vocabulary` — wrong word choice, false cognate
- `word_order` — incorrect word sequence
- `preposition` — wrong/missing preposition
- `article` — wrong/missing/extra article (a/an/the)
- `punctuation` — comma, period, apostrophe, etc.
- `awkward_phrasing` — grammatically correct but unnatural
- `semantic` — meaning is unclear or wrong

## Response format for /en

**Step 1:** Answer the user's actual question.

**Step 2:** Concise English analysis.

```
📝 <text>
✅ <corrected>
❌ <error> → <fix> [type]
└ 🇧🇷 <translation>
📚 <topic>
```

If no errors: `✅ Tudo certo!` + 1 vocabulary tip.

## Important notes
- Be concise. Detailed review is for `/en-review`.
- Be encouraging. Progress over perfection.
- Everyday conversational English.
- Translate unfamiliar words automatically.
- If storage fails (Plan Mode), still do the analysis.
