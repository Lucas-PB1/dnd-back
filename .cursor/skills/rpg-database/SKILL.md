---
name: rpg-database
description: >-
  Gera e valida SQL (PostgreSQL) a partir do modelo JSON do PHB em data/phb/ e
  data/schema/. Use quando o usuário pedir banco de dados, schema SQL, migrations,
  seed, tabelas, FKs, ou migrar fichas/PHB para SQL.
---

# RPG Database (PostgreSQL v4/v5)

Catálogo PHB normalizado: 58 tabelas `rpg.phb_*`, `id BIGINT` + `slug UNIQUE`.
Camada de fichas: 12 tabelas `player_character_*` + `sheet JSONB` — ver [plano-final.md](docs/plano-final.md).
Atributos: `player_character_ability` → `phb_ability` (6 linhas por personagem).

## Arquivos

| Arquivo | Função |
|---------|--------|
| `database/schema.sql` | DDL catálogo v4 prod-safe (gerado) |
| `database/dev-reset.sql` | DROP SCHEMA — **somente dev** (gerado) |
| `database/migrations/` | Migrations incrementais (`001_initial_catalog.sql`) |
| `database/seed-phb.sql` | DML catálogo (gerado) |
| `database/seed-all.sql` | Bootstrap dev: schema + PHB (gerado) |
| `database/seed-characters.sql` | DML fichas (gerado) |
| `scripts/generate-sql-schema.mjs` | Regenera schema |
| `scripts/seed-phb.mjs` | PHB → `seed-phb.sql` |
| `scripts/generate-seed.mjs` | Combina em `seed-all.sql` |
| `scripts/import-characters.mjs` | Fichas JSON → `seed-characters.sql` |
| `scripts/validate-db-structure.mjs` | Valida schema |
| `scripts/run-migrations.mjs` | Aplica migrations pendentes |
| `scripts/run-seed-prod.mjs` | migrate + seed PHB (prod) |
| `scripts/run-seed-characters.mjs` | Aplica seed de fichas |
| `scripts/validate-characters-db.mjs` | Valida fichas no PostgreSQL |

## Workflow

```bash
npm run fichas:all       # valida JSON do PHB (sem fichas em disco)
npm run db:all             # gera + valida schema + migrations
npm run seed:all           # gera + valida seed

# Dev local (reset completo)
npm run seed:run
npm run characters:all   # 300 fichas no PostgreSQL

# Produção/staging (sem DROP SCHEMA)
npm run migrate:run
npm run seed:prod
npm run generate:seed-characters && npm run seed:characters
```

## Docs

- **[plano-final.md](docs/plano-final.md)** — roadmap completo (fases 0–5)
- [er-diagram.md](docs/er-diagram.md) — diagrama ER catálogo v4
- [entity-map.md](docs/entity-map.md) — mapa JSON → SQL
- [validation-rules.md](docs/validation-rules.md) — checklist
- [sql-conventions.md](docs/sql-conventions.md) — PostgreSQL

## v4/v5 (atual)

- Catálogo `phb_*` + fichas `player_character_*` (73 tabelas no schema completo)
- PK `BIGSERIAL` + `slug UNIQUE` no catálogo; `player_character.id` = slug da ficha
- Benefícios, slots, opções de espécie, propriedades de arma normalizados
- 15 views SQL (12 catálogo + 3 ficha), 11 ENUMs
- Validação anti-regressão em `validate-db-structure.mjs` e `validate-characters-db.mjs`

## Próximas fases

Ver [plano-final.md](docs/plano-final.md):

- **Fase 4:** unificar opções de classe (opcional)
- **Sync bidirecional** `sheet ↔ projeções` (triggers; fora do MVP da fase 5)
