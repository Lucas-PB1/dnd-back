---
name: rpg-database
description: >-
  Gera e valida SQL (PostgreSQL) a partir do modelo JSON do PHB em data/phb/ e
  data/schema/. Use quando o usuário pedir banco de dados, schema SQL, migrations,
  seed, tabelas, FKs, ou migrar fichas/PHB para SQL.
---

# RPG Database (PostgreSQL v3)

Modelo **híbrido PostgreSQL**: catálogo `rpg.phb_*` + ficha `rpg.player_character` com **`sheet JSONB` canônico** e projeções normalizadas. Classe única — sem multiclasse.

## Arquivos

| Arquivo | Função |
|---------|--------|
| `database/schema.sql` | DDL PostgreSQL v2 (ENUMs, triggers, views) |
| `scripts/generate-sql-schema.mjs` | Regenera schema |
| `scripts/seed-phb.mjs` | PHB → `seed-phb.sql` |
| `scripts/import-characters.mjs` | Fichas → `seed-characters.sql` |
| `scripts/generate-seed.mjs` | Combina em `seed-all.sql` |
| `scripts/validate-seed.mjs` | Valida seed gerado |

## Workflow

```bash
npm run fichas:all          # JSON válido
npm run seed:all              # gera + valida SQL
psql -U postgres -d rpg -f database/schema.sql
psql -U postgres -d rpg -f database/seed-all.sql
# ou com pg: DATABASE_URL=... npm run seed:run
```

## Docs

- [er-diagram.md](docs/er-diagram.md) — diagrama ER v3
- [validation-rules.md](docs/validation-rules.md) — checklist
- [sql-conventions.md](docs/sql-conventions.md) — PostgreSQL

## v2 vs v1

- `player_character` (não `character`)
- `sheet JSONB` obrigatório
- `hp_*`, `ac_total` tipados
- `player_character_resource` (rage, sopro, etc.)
- Opções espécie/classe em tabelas EAV
- ENUMs PostgreSQL, trigger `updated_at`, GIN indexes
