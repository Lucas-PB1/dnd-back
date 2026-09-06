-- Baseline schema `rpg` â€” greenfield DDL (schema + runtime)

-- Schema rpg + extensÃ£o pg_trgm

CREATE SCHEMA IF NOT EXISTS rpg;

CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- ENUMs do catÃ¡logo PHB (baseline canÃ´nico)

CREATE EXTENSION IF NOT EXISTS pgcrypto;
