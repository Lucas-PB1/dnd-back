---
name: rpg-database
description: >-
  Gera e valida SQL (PostgreSQL) a partir do modelo JSON do PHB em data/phb/ e
  data/schema/. Use quando o usuário pedir banco de dados, schema SQL, migrations,
  seed, tabelas, FKs, ou migrar fichas/PHB para SQL.
---

# RPG Database (PostgreSQL v4)

Catálogo PHB normalizado: 58 tabelas `rpg.phb_*`, `id BIGINT` + `slug UNIQUE`.
Camada de fichas (`player_character`): **fase 5** — ver [plano-final.md](docs/plano-final.md).

## Arquivos

| Arquivo | Função |
|---------|--------|
| `database/schema.sql` | DDL catálogo v4 prod-safe (gerado) |
| `database/dev-reset.sql` | DROP SCHEMA — **somente dev** (gerado) |
| `database/migrations/` | Migrations incrementais (`001_initial_catalog.sql`) |
| `database/seed-phb.sql` | DML catálogo (gerado) |
| `database/seed-all.sql` | Bootstrap dev: schema + PHB (gerado) |
| `scripts/generate-sql-schema.mjs` | Regenera schema |
| `scripts/seed-phb.mjs` | PHB → `seed-phb.sql` |
| `scripts/generate-seed.mjs` | Combina em `seed-all.sql` |
| `scripts/validate-db-structure.mjs` | Valida schema |
| `scripts/run-migrations.mjs` | Aplica migrations pendentes |
| `scripts/run-seed-prod.mjs` | migrate + seed PHB (prod) |

## Workflow

```bash
npm run fichas:all       # JSON válido (PHB + fichas)
npm run db:all             # gera + valida schema + migrations
npm run seed:all           # gera + valida seed

# Dev local (reset completo)
npm run seed:run

# Produção/staging (sem DROP SCHEMA)
npm run migrate:run
npm run seed:prod
```

## Docs

- **[plano-final.md](docs/plano-final.md)** — roadmap completo (fases 0–5)
- [er-diagram.md](docs/er-diagram.md) — diagrama ER catálogo v4
- [entity-map.md](docs/entity-map.md) — mapa JSON → SQL
- [validation-rules.md](docs/validation-rules.md) — checklist
- [sql-conventions.md](docs/sql-conventions.md) — PostgreSQL

## v4 (atual)

- Catálogo only — sem `player_character` no schema
- PK `BIGSERIAL` + `slug UNIQUE` (API/JSON usa slug)
- Benefícios, slots, opções de espécie, propriedades de arma normalizados
- 12 views SQL, 6 ENUMs
- Validação anti-regressão em `validate-db-structure.mjs`

## Próximas fases

Ver [plano-final.md](docs/plano-final.md):

- **Fase 5:** `player_character` híbrido (sheet JSONB + projeções)
