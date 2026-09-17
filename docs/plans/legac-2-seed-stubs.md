# LEGAC-2 — Seeds stub “Grants legado”

**Status:** aberto · **Pai:** [`legac-pattern-backlog.md`](legac-pattern-backlog.md) · **Dep:** LEGAC-1 · **Tam:** M

## Skills / rules

`postgresql-sql` · `catalog-sql-first` · `testing` (`db:seed` / validate)  
`catalog-sql-first.mdc` · `sql-layout.md`

## Escopo

Remover do `SEED_ORDER` e apagar (se só `SELECT 1` / comentário “legado aposentado”), candidatos conhecidos:

- `database/seeds/feat/**/phb_feat.resource-grant.sql` (e variantes valdas/steinhardt/northlands)
- `database/seeds/species/phb/phb_species.resource-grant.sql`
- `database/seeds/economy/grim-hollow/phb_resource.ghpg-cap4-feats.sql` (se stub)
- Outros achados no inventário LEGAC-1

Confirmar zero consumidores (views/MV/scripts).

## DoD

- [ ] `db:seed` / validate-sql verde
- [ ] Zero arquivo stub “Grants legado aposentado” no order
- [ ] Apagar este `.md`
