-- DEV ONLY — apaga todo o schema rpg. Nunca rodar em produção/staging.
-- Uso: psql -f database/dev-reset.sql (ou npm run seed:run)

DROP SCHEMA IF EXISTS rpg CASCADE;
CREATE SCHEMA rpg;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

