# Ordem das migrations

Baseline canônico em fases (lexicográfico por path):

1. `001_schema.sql`
2. `010_types/002_types.sql` — enums finais (sem `ADD VALUE`)
3. `020_tables/T001`–`T077` — uma tabela por arquivo, CREATE no estado final
4. `040_functions/F001_set_updated_at.sql`
5. `050_triggers/TR001_audit.sql`
6. `060_views/V001`–`V030` — uma view = definição final
7. `070_materialized/MV001_mv_spell_by_class.sql`
8. `080_indexes/IX001_catalog.sql`
9. `090_player/P001`–`P014` — tabelas de jogador + RLS + slots mágicos

Não há migrations de dados corretivos — isso fica nos seeds.

## Registro

Tabela `rpg.schema_migration` via `npm run db:migrate` (versão = caminho relativo sem `.sql`).

## Setup

```bash
npm run db:setup   # reset → migrate → seed
```

Fonte de verdade: `database/migrations/` + `database/seeds/`.
