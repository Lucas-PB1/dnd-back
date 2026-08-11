# Ordem das migrations

Baseline canônico em fases (lexicográfico por path):

1. `001_schema.sql`
2. `010_types/002_types.sql` + `003_combat_mechanical_enums.sql` — enums
3. `020_tables/T001`–`T089` — uma tabela por arquivo, CREATE no estado final
4. `040_functions/F001_set_updated_at.sql`
5. `050_triggers/TR001_audit.sql`
6. `060_views/V001`–`V040` — uma view = definição final
7. `070_materialized/MV001_mv_spell_by_class.sql`
8. `080_indexes/IX001_catalog.sql`
9. `090_player/P001`–… — tabelas de jogador + RLS + slots mágicos

Não há migrations de dados de catálogo — isso fica nos seeds (`database/seeds/`).  
Exceção: `090_player/P026` configura bucket/policies de storage (infra Supabase), não catálogo PHB.

## Registro

Tabela `rpg.schema_migration` via `npm run db:migrate` (versão = caminho relativo sem `.sql`).

## Setup

```bash
npm run db:setup   # reset → migrate → seed
```

Fonte de verdade: `database/migrations/` + `database/seeds/`.
