# ViewEntity para API

Preferir views para endpoints read-only — evitam joins manuais.

## Mapeamento

| View | Entity | Endpoint |
|------|--------|----------|
| `v_phb_class` | `VPhbClass` | `/classes` |
| `v_phb_spell` | `VPhbSpell` | `/spells` |
| `v_phb_subclass` | `VPhbSubclass` | `/subclasses` |
| `v_phb_background` | `VPhbBackground` | `/backgrounds` |

## Registro

```typescript
TypeOrmModule.forFeature([VPhbClass])
```

Views são read-only — sem `save()` ou `remove()`.

## SQL source

Definições em `database/migrations/060_views/`
