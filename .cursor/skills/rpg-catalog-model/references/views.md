# Views do catálogo

Preferir views para endpoints read-only da API.

| View | Descrição |
|------|-----------|
| `v_phb_class` | Classes com hit die, primary abilities, source |
| `v_phb_spell` | Magias com escola e edição |
| `v_phb_subclass` | Subclasses com classe pai |
| `v_spell_by_class` | Magias por classe e nível |
| `v_phb_background` | Antecedentes enriquecidos |
| `v_phb_background_equipment` | Equipamento de antecedente |
| `v_phb_class_equipment` | Equipamento inicial de classe |
| `v_phb_feat` | Talentos com benefícios |
| `v_phb_armor` | Armaduras com categoria |
| `v_class_spell_slots` | Slots por classe/nível |
| `v_phb_class_skill_choice` | Pool de perícias |
| `v_phb_species_trait_choices` | Escolhas de traço |
| `v_phb_subclass_mechanics` | Mecânicas de subclasse |
| `v_phb_subclass_prepared_spell` | Magias preparadas |
| `v_phb_subclass_spells_expected` | Magias esperadas |
| `mv_spell_by_class` | Materialized — refresh manual/cron |

Definições SQL: `database/migrations/060_views/` e `070_materialized/`
