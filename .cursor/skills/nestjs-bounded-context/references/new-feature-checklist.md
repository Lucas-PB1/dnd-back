# Checklist — nova feature

## É catálogo PHB?

- [ ] Existe view `v_phb_*` ou criar migration SQL primeiro?
- [ ] Módulo em `src/catalog/<recurso>/`
- [ ] ViewEntity + DTO + GET por slug
- [ ] Sem pasta `domain/`
- [ ] Rule `catalog-thin-layer` respeitada

## É auth?

- [ ] Código em `src/identity/`
- [ ] Skill `supabase-auth`
- [ ] Catálogo permanece público?

## É ficha / campanha?

- [ ] Código em `src/game/<recurso>/`
- [ ] Migration TypeORM separada (não `database/seeds/phb/`)
- [ ] RLS + guard
- [ ] Agregado só se houver invariantes multi-campo
- [ ] Referência PHB via slug + CatalogLookupService
- [ ] Rule `game-domain` + skill `cqrs-catalog-vs-game`

## Qualquer BC

- [ ] Não viola [`dependency-rules.md`](dependency-rules.md)
- [ ] Testes unitários em domain (game) ou service (catalog)
