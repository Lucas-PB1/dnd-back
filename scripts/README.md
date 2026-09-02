# Scripts — dnd-api

Só o essencial: banco, smokes e measure. Seeds/extracts já vivem no git (`database/seeds/`, `docs/source/extracts/`). **Não** acumular geradores extract/generate/verify — histórico do git se precisar reabrir um one-off.

## Comandos npm

| Script | Arquivo | Uso |
|--------|---------|-----|
| `npm run db:setup` | validate + reset + migrate + seed | Dev fresh (local) |
| `npm run db:reset` | `dev-reset.mjs` | Limpa schema `rpg` (dev) |
| `npm run db:migrate` | `run-migrations.mjs` | Baseline + forward |
| `npm run db:seed` | `run-seeds.mjs` | Aplica seeds |
| `npm run db:validate:sequences` | `validate-sql-sequences.mjs` | FK-safe antes de seed |
| `npm run db:migrate:supabase` / `:all` | idem `--target` | Prod / ambos |
| `npm run db:seed:supabase` / `:all` | idem | Prod / ambos |
| `npm run db:setup:all` | local + supabase | Setup completo |
| `npm run smoke:health` | `smoke-health.mjs` | GET `/health` |
| `npm run vercel:smoke` | `vercel-local-smoke.mjs` | Smoke Vercel dev |
| `npm run measure:latency` | `measure-latency.mjs` | Latência — [`docs/deploy/measure-latency.md`](../docs/deploy/measure-latency.md) |
| `npm run measure:character` | `measure-character-once.mjs` | Benchmark ficha |

## Estrutura

```
scripts/
├── README.md
├── lib/
│   ├── load-env.mjs
│   ├── pg-client.mjs
│   └── sql-files.mjs
├── dev-reset.mjs
├── run-migrations.mjs
├── run-seeds.mjs
├── validate-sql-sequences.mjs
├── smoke-health.mjs
├── vercel-local-smoke.mjs
├── measure-latency.mjs
└── measure-character-once.mjs
```

**12 arquivos** no total (8 scripts + 3 lib + este README).

## Env

Scripts de DB leem `.env` via `lib/load-env.mjs` (`DATABASE_URL`, etc.). Ver [`docs/deploy/DEPLOY.md`](../docs/deploy/DEPLOY.md).
