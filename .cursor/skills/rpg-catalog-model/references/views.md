# Views do catálogo

SSOT camadas: [`adr-read-model-layers.md`](../../../../docs/architecture/adr-read-model-layers.md).

## Quando usar o quê

| Mecanismo | Usar quando |
|-----------|-------------|
| **Tabela `phb_*`** | Espelho 1:1, combat mecânico, join mínimo (slug via relation) |
| **View VALUES** | Label/ordem de enum |
| **View join** | Enriquecimento multi-FK (`v_phb_armor`, `v_phb_spell`) |
| **View agregado** | 1 root + filhos JSONB (`v_phb_feat`) → MV se list lenta |
| **MV `mv_*`** | Consumo em API/listagem; refresh pós-seed |

**Não** criar view espelho. Refactor em curso: [`read-model-mirror-refactor.md`](../../../../docs/plans/read-model-mirror-refactor.md).

## Views ativas (pós refactor espelho)

| View | Tipo | Descrição |
|------|------|-----------|
| `v_phb_feat_category` | VALUES | Categorias de talento |
| `v_phb_condition` | VALUES | Condições |
| `v_phb_weapon_proficiency` | VALUES | Labels proficiência |
| `v_phb_ability_generation_method` | VALUES | Métodos de geração |
| `v_phb_class` | join | Classes enriquecidas |
| `v_phb_spell` | join | Magias + escola |
| `v_phb_subclass` | join | Subclasses + edition |
| `v_phb_armor` | join | Armaduras + item |
| `v_phb_background` | agregado | Antecedentes + arrays |
| `v_phb_feat` | agregado | Talentos + JSONB filhos |
| `v_phb_class_equipment` | join | Pacote inicial classe |
| `v_phb_background_equipment` | join | Pacote inicial antecedente |
| `v_phb_species_trait_choices` | união | Linhagens / choices |
| `v_phb_class_economy_action` | união | Economy multi-owner |
| `v_phb_creature_template_bundle` | bundle | Bestiário |
| `v_phb_vehicle_template_bundle` | bundle | Veículos |
| `v_phb_character_thread_bundle` | bundle | Threads Northlands |
| `mv_spell_by_class` | MV | Magias por classe |

Lista completa SQL: `database/baseline/001_full_schema.sql`.

Magias concedidas → [`granted-spells-read-model.md`](granted-spells-read-model.md).

## Removidas (ler tabela)

`v_phb_battle_master_maneuver`, `v_phb_gunslinger_maneuver`, `v_phb_class_panel_action`, `v_phb_class_feature`, … — ver plano mirror refactor.
