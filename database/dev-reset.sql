-- DEV ONLY — apaga todo o schema rpg. Nunca rodar em produção/staging.
-- Uso: composto em seed-all.sql ou psql -f database/dev-reset.sql

DROP SCHEMA IF EXISTS rpg CASCADE;
CREATE SCHEMA rpg;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

