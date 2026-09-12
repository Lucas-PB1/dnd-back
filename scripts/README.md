# Scripts — dnd-api

Só o essencial: banco, smokes, measure e geradores Cap.6/`SEED_ORDER`. One-offs vivem no **histórico git** — não reacumular na raiz.

## Comandos npm

| Script | Arquivo | Uso |
|--------|---------|-----|
| `npm run db:setup` | validate + reset + migrate + seed | Dev fresh (local) |
| `npm run db:reset` | `db/dev-reset.mjs` | Limpa schema `rpg` (dev) |
| `npm run db:migrate` | `db/run-migrations.mjs` | Baseline + forward |
| `npm run db:seed` | `db/run-seeds.mjs` | Aplica seeds |
| `npm run db:validate:sequences` | `db/validate-sql-sequences.mjs` | FK-safe antes de seed |
| `npm run db:migrate:supabase` / `:all` | idem `--target` | Prod / ambos |
| `npm run db:seed:supabase` / `:all` | idem | Prod / ambos |
| `npm run db:setup:all` | local + supabase | Setup completo |
| `npm run smoke:health` | `ops/smoke-health.mjs` | GET `/health` |
| `npm run vercel:smoke` | `ops/vercel-local-smoke.mjs` | Smoke Vercel dev |
| `npm run measure:latency` | `ops/measure-latency.mjs` | Latência — [`docs/deploy/measure-latency.md`](../docs/deploy/measure-latency.md) |
| `npm run measure:character` | `ops/measure-character-once.mjs` | Benchmark ficha |
| `npm run start:dev` | `ops/clean-dist-shadows.mjs` + nest | Dev API |

## Estrutura

```
scripts/
├── README.md
├── lib/                 # load-env, pg-client, sql-files, assert-local-db
├── db/                  # reset / migrate / seed / validate
├── generate/            # regeneradores SSOT (Cap.6 + SEED_ORDER)
└── ops/                 # smoke, measure, clean-dist
```

## Geradores (exceção documentada)

Regeneram seeds a partir de extracts/TS — não são one-offs de migrate:

| Comando | Saída |
|---------|--------|
| `node scripts/generate/seed-order.mjs` | `database/seeds/SEED_ORDER.txt` |
| `node scripts/generate/cap6-economy-seeds.mjs` | defs + grants + economy Cap.6 |
| `node scripts/generate/cap6-choice-rules-seed.mjs` | `phb_transformation_choice_rules.all.sql` |
| `node scripts/generate/cap6-boon-combat-notes-seed.mjs` | `phb_transformation_boon_combat_note.all.sql` |

## Env

Scripts de DB leem `.env` via `lib/load-env.mjs` (`DATABASE_URL`, etc.). Ver [`docs/deploy/DEPLOY.md`](../docs/deploy/DEPLOY.md).
