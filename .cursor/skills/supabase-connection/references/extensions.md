# Extensões

## pg_trgm

Obrigatória para o catálogo (busca fuzzy).

Dashboard: Database → Extensions → `pg_trgm` → Enable

Ou SQL:

```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

Já incluída em `database/migrations/001_schema.sql` e `dev-reset.sql`.

## Verificar

```sql
SELECT * FROM pg_extension WHERE extname = 'pg_trgm';
```
