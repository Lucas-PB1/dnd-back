# Scripts — dnd-api

Utilitários de banco, catálogo, extração de fontes e smoke tests. Comandos expostos no `package.json` são a interface canônica; demais `.mjs` na raiz são pipelines pontuais (GHPG, DMG, Northlands, …).

## Comandos npm

| Script | Comando | Uso |
|--------|---------|-----|
| `npm run db:setup` | reset + migrate + seed (local) | Dev fresh |
| `npm run db:reset` | `dev-reset.mjs` | Limpa schema `rpg` (dev) |
| `npm run db:migrate` | `run-migrations.mjs` | Baseline + forward migrations |
| `npm run db:seed` | `run-seeds.mjs` | Aplica seeds |
| `npm run db:validate:sequences` | `validate-sql-sequences.mjs` | FK-safe antes de seed |
| `npm run db:migrate:supabase` / `:all` | idem com `--target` | Prod / ambos |
| `npm run db:seed:supabase` / `:all` | idem | Prod / ambos |
| `npm run db:setup:all` | local + supabase | Setup completo |
| `npm run smoke:health` | `smoke-health.mjs` | GET `/health` |
| `npm run vercel:smoke` | `vercel-local-smoke.mjs` | Smoke Vercel dev |
| `npm run measure:latency` | `measure-latency.mjs` | Latência API — ver [`docs/deploy/measure-latency.md`](../docs/deploy/measure-latency.md) |
| `npm run measure:character` | `measure-character-once.mjs` | Benchmark ficha |
| `npm run catalog:audit` | `audit-combat-catalog.mjs` | Gaps catálogo combate |
| `npm run sheets:l20` | `generate-l20-sheets.mjs` | Payloads L20 |
| `npm run sheets:review` | `create-review-l20.mjs` | Review L20 |

## Estrutura

```
scripts/
├── lib/           # Helpers compartilhados (ghpg-html-utils, docs-source, pg-client, …)
├── archive/       # One-offs de auditoria (_*.mjs) — não entram em pipeline CI
├── extract-*.mjs  # HTML → JSON em docs/source/extracts/
├── generate-*.mjs # JSON → SQL seeds
├── verify-*.mjs   # Checagens pós-seed / compendium
└── audit-*.mjs    # Relatórios de cobertura
```

## Archive

Scripts em `archive/` são investigações pontuais (prefixo `_`). Imports usam `../lib/`. Exemplo:

```bash
node scripts/archive/_audit-gh-mesa-state.mjs
```

Não adicionar novos `_*.mjs` na raiz — criar direto em `archive/` ou apagar após uso.

## GHPG / catálogo (fora do npm)

Fluxo típico Grim Hollow:

1. HTML em `docs/source/scrap/` ou `_scrapes/grim-hollow/`
2. `node scripts/extract-ghpg-capN.mjs` → `docs/source/extracts/`
3. `node scripts/generate-ghpg-capN-seeds.mjs` → `database/seeds/`
4. `node scripts/verify-ghpg-capN-*.mjs` — validação

Utilitário HTML: `lib/ghpg-html-utils.mjs` (`findGhpgChapterHtml(chapter, …dirs)`).

## Env

Scripts de DB leem `.env` via `lib/load-env.mjs` (`DATABASE_URL`, etc.). Ver [`docs/deploy/DEPLOY.md`](../docs/deploy/DEPLOY.md).
