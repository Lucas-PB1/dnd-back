-- Baseline schema `rpg` — greenfield DDL (schema + runtime)

-- Schema rpg + extensão pg_trgm

CREATE SCHEMA IF NOT EXISTS rpg;

CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- ENUMs do catálogo PHB (baseline canônico)

CREATE EXTENSION IF NOT EXISTS pgcrypto;
