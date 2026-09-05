# Migrations forward

Schema greenfield: **`database/baseline/001_full_schema.sql`**.

Esta pasta está **vazia** de propósito (sem produção / sem histórico forward). Alterações de schema → editar o baseline + `npm run db:setup`.

Se no futuro precisar de forward-only, criar arquivos aqui (ordem lexicográfica). Ver skill `postgres-apply-catalog` → `migration-order.md`.
