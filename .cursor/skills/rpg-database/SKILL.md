---
name: rpg-database
description: >-
  Gera e valida SQL (PostgreSQL) a partir do modelo JSON do PHB em data/phb/.
  Use para schema, migrations granulares, seeds de catálogo.
---

# RPG Database — catálogo PHB (test bed)

Repositório focado em **testar o schema PostgreSQL** do catálogo PHB 2024 — sem camada de fichas/API.

## Layout

| Caminho | Função |
|---------|--------|
| `database/schema.sql` | DDL concatenado (referência) |
| `database/migrations/` | **1 migration por tabela/view** (gerado) |
| `database/seeds/` | DML do catálogo (`001_phb`, `002_subclass_mechanics`) |
| `data/phb/` | Fonte JSON |
| `scripts/generate-sql-schema.mjs` | Gera schema + migrations |
| `scripts/generate-seed.mjs` | Gera seeds |

## Workflow

```bash
npm run db:all        # gera + valida schema/migrations
npm run seed:all      # gera + valida seeds
npm run seed:run      # dev: reset + migrate + seed
npm run seed:prod     # prod: migrate + seed
```

Docs: [database/migrations/README.md](../../database/migrations/README.md), [database/seeds/README.md](../../database/seeds/README.md)
