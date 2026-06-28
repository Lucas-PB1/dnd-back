# Migrations PostgreSQL

Migrations incrementais do schema `rpg`. **Nunca** use `DROP SCHEMA` aqui.

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `001_initial_catalog.sql` | Baseline v4 (gerado junto com `schema.sql`) |
| `002_*.sql` | Alterações futuras (manual ou gerado) |

Registro de versões: `rpg.schema_migration`.

## Comandos

```bash
# Gerar baseline + schema prod-safe
npm run generate:sql-schema

# Aplicar migrations pendentes
npm run migrate:run

# Produção/staging: migrations + seed PHB (sem DROP)
npm run seed:prod

# Dev local: reset completo
npm run seed:all && npm run seed:run
```

## Regras

1. **Produção:** `migrate:run` → `seed:prod` (ou só seed se schema já existir)
2. **Dev:** `seed:run` usa `dev-reset.sql` + schema + seed (via `seed-all.sql`)
3. Nova alteração de schema → criar `00N_descricao.sql` incremental; não editar `001` após deploy
4. `database/schema.sql` espelha sempre o estado completo atual (referência + migration 001)

## Multi-edição (fase 2.4 — pendente)

Decisão adiada: adicionar `edition_id` nas entidades principais quando houver segundo livro de regras.
Ver [plano-final.md](../../.cursor/skills/rpg-database/docs/plano-final.md).
