# Endpoints read-only (Catalog)

## Padrão atual (queries + mapper)

```
src/catalog/classes/
├── classes.module.ts
├── classes.controller.ts
├── classes.mapper.ts
├── queries/
│   ├── find-classes.query.ts
│   └── find-class-by-slug.query.ts
└── dto/
```

Controller injeta queries; cada `*Query` tem `execute()`. Sem `ClassesService` monolítico.

## Endpoints

- `GET /<recurso>` — lista (paginação)
- `GET /<recurso>/:slug` — detalhe

Sem POST/PATCH/DELETE em catálogo `phb_*` sem aprovação explícita.

## Views preferidas

| Recurso | View |
|---------|------|
| Classes | `v_phb_class` |
| Magias | `v_phb_spell` |
| Subclasses | `v_phb_subclass` |
| Antecedentes | `v_phb_background` |
| Equip. classe | `v_phb_class_equipment` |
| Magias×classe | `v_spell_by_class` |

Lançar `NotFoundException` se slug não existir.
