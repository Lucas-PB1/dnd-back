# Mapa de FKs

## Hierarquia principal

```
phb_edition ← phb_source_citation
phb_ability ← phb_skill, phb_class_saving_throw, phb_class_primary_ability
phb_hit_die ← phb_class
phb_class ← phb_subclass (class_id)
phb_subclass ← phb_subclass_feature, phb_subclass_prepared_spell
phb_item ← phb_weapon, phb_armor, phb_tool
phb_background ← phb_background_skill, phb_background_starting_package
```

## FKs compostas

| Tabela | Colunas | Referencia |
|--------|---------|------------|
| `phb_subclass` | `(class_id, id)` | subclass único por classe |
| `phb_subclass_option_def` | `(subclass_id, option_key)` | PK composta |
| `phb_subclass_option_value` | `(subclass_id, option_key)` | → option_def |
| `phb_spell_source` | `(class_id, subclass_id)` | → phb_subclass |

## Junction (M:N)

- `phb_spell_class` — spell_id + class_id
- `phb_class_skill_pool` — class_id + skill_id
- `phb_background_skill` — background_id + skill_id
- `phb_weapon_property_link` — weapon_id + property_id
- `phb_class_fighting_style` — class_id + fighting_style_id

## Polimorfismo

**phb_resource_definition:** `resource_scope` determina qual FK preencher (species_id | class_id | subclass_id).

**phb_spell_source:** `origin` enum + FKs opcionais.
