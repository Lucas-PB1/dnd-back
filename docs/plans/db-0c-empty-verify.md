# DB-0c — Esvaziar migrations + docs + verify

**Status:** aberto · **Pai:** [`db-0-reorg-migrations.md`](db-0-reorg-migrations.md) · **Dep:** DB-0b · **Tam:** S

## Skills / rules

`postgresql-sql` · `testing` · `okf` (se log)  
Docs: `sql-layout.md` · `infrastructure.md` · este índice

## Escopo

1. Apagar `database/migrations/*.sql`
2. `database/migrations/README.md`: *Forward-only só com prod + dados; até lá = schema CREATE + `db:setup`.*
3. `npm run db:setup` local verde
4. Atualizar [`sql-layout.md`](../architecture/sql-layout.md) (migrations = vazio)
5. Atualizar [`infrastructure.md`](../architecture/infrastructure.md) fase forward
6. Remover [`db-0-reorg-migrations.md`](db-0-reorg-migrations.md) + 0a/0b/0c do índice quando feito

## DoD

- [ ] Pasta migrations sem SQL de schema
- [ ] `db:setup` completa sem aplicar forward
- [ ] Docs + índice atualizados
- [ ] Apagar este pacote e pais DB-0* do índice
