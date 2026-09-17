# database/migrations

**Política greenfield (sem prod com dados):** pasta **vazia** de SQL.

- Schema SSOT: `database/schema/**` (`CREATE` only) + `npm run db:setup`
- Seeds: `database/seeds/**` — nunca DML de catálogo aqui
- Forward-only `.sql` nesta pasta: **só** quando existir produção com dados a preservar

Ver: [`docs/architecture/sql-layout.md`](../../docs/architecture/sql-layout.md) · log OKF 2026-09-17 DB-0
