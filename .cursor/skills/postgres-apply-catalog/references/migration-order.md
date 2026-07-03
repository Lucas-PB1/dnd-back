# Ordem das migrations

84 arquivos em ordem lexicográfica de path:

1. `001_schema.sql`
2. `010_types/002_types.sql`
3. `020_tables/T###_*.sql` (63 tabelas)
4. `040_functions/F001_set_updated_at.sql`
5. `050_triggers/TR001_audit.sql`
6. `060_views/V###_*.sql` (15 views)
7. `070_materialized/MV001_mv_spell_by_class.sql`
8. `080_indexes/IX001_catalog.sql`

## Registro

Tabela `rpg.schema_migration` (se aplicável via runner) ou aplicar todos via psql sort.

## DDL completo alternativo

`database/schema.sql` contém tudo em um arquivo (referência, não substituir migrations granulares).
