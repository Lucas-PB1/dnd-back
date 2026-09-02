# Baseline schema `rpg`

Snapshot **greenfield** do DDL (~225 KiB, ~5,2k linhas). Substitui 239 migrations granulares (histórico no git).

| Arquivo | Conteúdo |
|---------|----------|
| `001_full_schema.sql` | Schema completo: types, tables, functions, triggers, views, indexes, player + RLS condicional |

## Aplicar

```bash
npm run db:migrate          # baseline + forward pendentes
npm run db:setup            # reset + migrate + seed
```

Ordem: `database/baseline/` → `database/migrations/` (forward-only).

Registro: `rpg.schema_migration` — versão baseline = `baseline/001_full_schema`.

**Pré-prod:** bancos com migrations granulares antigas precisam de **reset** antes do baseline — `npm run db:setup` ou `db:setup:all`.

## Alterações futuras

| Situação | Onde |
|----------|------|
| DDL incremental (pós-baseline) | `database/migrations/` — ver [`../migrations/README.md`](../migrations/README.md) |
| Ajuste estrutural amplo (pré-prod) | Editar `001_full_schema.sql` diretamente — manter ordem de FKs e enums completos no `CREATE TYPE` |

Não regerar a partir de migrations granulares — pasta removida; histórico só no git.
