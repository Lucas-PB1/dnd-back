# LEGAC-3 — Scripts `legacy*`

**Status:** aberto · **Pai:** [`legac-pattern-backlog.md`](legac-pattern-backlog.md) · **Dep:** LEGAC-1 · **Tam:** S

## Skills / rules

`typescript` / Node scripts · `dry` · `postgresql-sql` (se tocar validate) · `shell-scripting` se aplicável

## Escopo

| Arquivo | Ação sugerida |
|---------|----------------|
| `scripts/db/run-migrations.mjs` | `legacyBaselineDir` → dropar fallback se `database/baseline` não existe; ou renomear `deprecatedBaselineDir` |
| `scripts/db/validate-sql-sequences.mjs` | `legacyPacks` → `forbiddenFlatPacks` (ou similar) |
| `scripts/generate/seed-order.mjs` | Comentário “Basename legado” → “basename antigo / EXACT_MAP” |

Não quebrar guards anti-pack flat.

## DoD

- [ ] `rg 'legacy' scripts/` só com justificativa (ou zero)
- [ ] `npm run` validate/migrate paths usados no CI locais verdes
- [ ] Apagar este `.md`
