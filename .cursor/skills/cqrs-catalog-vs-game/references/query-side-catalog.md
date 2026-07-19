# Query side — Catalog

## Fluxo

```
GET /spells/:slug
  → SpellsController
  → FindSpellBySlugQuery.execute()
  → Repository(VPhbSpell) + mapper
  → rpg.v_phb_spell
  → SpellResponseDto
```

## Características

- Idempotente, cacheável
- Sem transação multi-tabela no Nest — view já faz join
- Paginação via query params (`page`, `limit`)
- Filtros no QueryBuilder da query

## Não fazer

- Command handler para catálogo
- `save()` em ViewEntity
- Recomputar spell slots em TS — usar view `v_class_spell_slots`

## SQL como read model

Mudança no contrato de leitura = migration de **view**, não lógica no Nest.
