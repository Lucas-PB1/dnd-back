# Ordem dos seeds

66 arquivos:

1. `000_truncate.sql` — TRUNCATE FK-safe
2. `phb/S010_*.sql` … `S067_*.sql` (58 tabelas)
3. `subclass/S010_*.sql` … `S016_*.sql` (7 tabelas)

## Truncate

Limpa todas as tabelas do catálogo antes dos INSERTs.

## Metadados

Contagens em `database/seed-manifest.json` (391 magias, 12 classes, …)

## Prod

Seeds são idempotentes via truncate + insert. Em prod com dados existentes, avaliar antes de truncar.
