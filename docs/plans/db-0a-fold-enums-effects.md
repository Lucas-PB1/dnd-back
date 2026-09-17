# DB-0a — Auditoria + fold enums / effects

**Status:** aberto · **Pai:** [`db-0-reorg-migrations.md`](db-0-reorg-migrations.md) · **Dep:** — · **Tam:** M

## Skills / rules

`postgresql-sql` · `catalog-sql-first` · `typeorm` · `dry`  
`catalog-sql-first.mdc` · `effect-dictionary.md` (kinds no ENUM)

## Escopo

- Inventariar migrations `20260911_phb_effect_*`, `*_kinds`, formulas, owner_kind spell, etc.
- Fold `ALTER TYPE` / novos `effect_kind` / satélites no `database/schema/010_enums/` e `020_tables/`.
- Confirmar que seeds em `database/seeds/effect/` já cobrem DML das migrations (senão mover).

## Fora

- Runtime skirmish/wild_shape (→ DB-0b)
- Apagar pasta migrations (→ DB-0c)

## DoD

- [ ] Lista migration → destino schema (tabela no PR ou anexo)
- [ ] Enums/kinds de effect só no CREATE
- [ ] Nenhuma migration de effect ainda necessária para `db:setup` fresco (schema+seed bastam para esses objetos)
