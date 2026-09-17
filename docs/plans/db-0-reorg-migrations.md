# DB-0 — Reorganizar migrations (greenfield)

**Status:** aberto · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)  
**Fases filhas:** [`db-0a`](db-0a-fold-enums-effects.md) · [`db-0b`](db-0b-fold-runtime.md) · [`db-0c`](db-0c-empty-verify.md)

## Premissa

Nada em prod. **Não** manter histórico de ALTER. Schema declarative = SSOT; `db:setup` = caminho único.

## Skills / rules

`postgresql-sql` · `catalog-sql-first` · `typeorm` · `dry` · `testing`  
Rules: `catalog-sql-first.mdc` · `nestjs-project.mdc`  
Docs: [`sql-layout.md`](../architecture/sql-layout.md) · [`infrastructure.md`](../architecture/infrastructure.md)

## Problema

- Doc já diz migrations “vazio até haver prod”.
- Há ~53 files em `database/migrations/` com drift (ex. `sacred_weapon_active` só na migration).

## Escopo (visão)

1. Auditar cada migration vs `database/schema/**`
2. Fold DDL no CREATE; seeds disfarçados → `seeds/` ou dropar
3. Alinhar entities
4. Esvaziar `migrations/*.sql` + README política
5. `npm run db:setup` verde
6. Atualizar docs

## Política pós-DB-0

| Situação | Ação |
|----------|------|
| Sem prod | Editar `database/schema/**` + `db:setup`. **Não** criar migration. |
| Com prod + dados | Forward-only em `migrations/` |
| Seed | Só `database/seeds/**` |

## DoD

- Ver DoD das fases 0a–0c; este doc sai do índice quando 0c fechar.
