# Modelo de dados — catálogo PHB 2024

Schema PostgreSQL `rpg` — 63 tabelas, 9 ENUMs, 15 views, 1 materialized view.

Fonte: [`database/schema.sql`](../database/schema.sql) · Contagens: [`database/seed-manifest.json`](../database/seed-manifest.json)

## Convenções

| Regra | Detalhe |
|-------|---------|
| Identidade | `BIGSERIAL id` interno + `slug TEXT UNIQUE` para API/contratos |
| Prefixo | Todas as tabelas `phb_*` |
| Audit | `created_at`, `updated_at` em entidades principais (spell, class, subclass, species, background, item) |
| API | URLs e DTOs usam **slug**; joins SQL usam **id** |
| Catálogo | **Read-only** na aplicação — dados vêm dos seeds em `database/seeds/` |

## ENUMs (`010_types/`)

| Tipo | Valores |
|------|---------|
| `item_type` | weapon, armor, gear, tool, focus, other |
| `resource_scope` | species, class, subclass |
| `subclass_feature_kind` | passive, resource, choice, always_prepared, spellcasting, spellbook_bonus |
| `resource_max_formula` | fixed, proficiency_bonus, charisma_mod, … |
| `spell_source_origin` | class_list, subclass, species, feat |
| `option_value_type` | catalog, skill, ability, fighting_style, terrain, skill_list, json |
| `species_choice_kind` | elf_lineage, infernal_legacy, dragon_ancestry |
| `weapon_category` | simple, martial |
| `casting_type` | full, half, pact, none |

## Clusters (7 domínios)

### 1. Core

- `phb_edition` — edição do livro (PHB 2024 PT-BR)
- `phb_source_citation` → edition
- `phb_ability`, `phb_alignment`, `phb_language`, `phb_skill` → ability
- `phb_fighting_style`, `phb_weapon_property`, `phb_weapon_mastery`
- `phb_character_level` — níveis 1–20, proficiency bonus, XP

### 2. Spells

- `phb_spell_school`, `phb_spell` → school, source_citation
- `phb_spell_class` — M:N spell ↔ class
- `phb_spell_slot_pattern`, `phb_spell_slot_by_level`
- `phb_spell_source` — origem polimórfica (class/species/feat/subclass)

### 3. Classes

- `phb_hit_die`, `phb_weapon_proficiency`
- `phb_class` → hit_die, spell_slot_pattern, source_citation
- `phb_subclass` → class (FK composta `class_id + id`)
- `phb_subclass_feature`, `phb_class_progression`, `phb_class_feature`
- `phb_class_skill_pool`, `phb_class_saving_throw`, `phb_class_primary_ability`
- `phb_class_armor_training`, `phb_class_weapon_proficiency`
- `phb_class_spellcasting`, `phb_class_fighting_style`
- `phb_class_starting_package` → `phb_class_starting_item`

### 4. Species

- `phb_species`
- `phb_species_trait`, `phb_species_option_def` → `phb_species_option_value`
- `phb_elf_lineage`, `phb_infernal_legacy`, `phb_dragon_ancestry` (catálogos de escolha)

### 5. Equipment (herança table-per-type)

- `phb_item` — base (name, slug, item_type, cost, weight)
- `phb_weapon` → item_id PK, mastery, damage
- `phb_armor` → item_id PK, category, AC
- `phb_tool` → item_id PK, category
- `phb_weapon_property_link` — M:N weapon ↔ property
- `phb_armor_category`, `phb_tool_category`

### 6. Backgrounds

- `phb_background` → feat, tool_item, tool_category, source_citation
- `phb_background_skill`, `phb_background_ability_option`
- `phb_background_starting_package` → `phb_background_starting_item`
- `phb_background_boost_option`, `phb_ability_generation_method`

### 7. Subclass mechanics

- `phb_resource_definition` — polimórfico via `resource_scope` + species/class/subclass_id
- `phb_subclass_option_def` → `phb_subclass_option_value`
- `phb_subclass_resource`, `phb_subclass_prepared_spell`
- `phb_druid_land_terrain`, `phb_divine_order`

### Feats

- `phb_feat_category`, `phb_feat` → category, source_citation
- `phb_feat_benefit` → feat

## FKs compostas

| Tabela | Chave |
|--------|-------|
| `phb_subclass` | `(class_id, id)` — subclass id único por classe |
| `phb_subclass_option_def` | `(subclass_id, option_key)` |
| `phb_subclass_option_value` | FK para `(subclass_id, option_key)` |
| `phb_spell_source` | `(class_id, subclass_id)` → subclass |

## Views (read models para API)

| View | Uso |
|------|-----|
| `v_phb_class` | Lista/detalhe de classes com hit die e primary abilities |
| `v_phb_spell` | Magias com escola e edição |
| `v_phb_subclass` | Subclasses com classe pai |
| `v_spell_by_class` | Magias por classe e nível |
| `v_phb_background` | Antecedentes enriquecidos |
| `v_phb_background_equipment` | Equipamento inicial de antecedente |
| `v_phb_class_equipment` | Equipamento inicial de classe |
| `v_phb_feat` | Talentos com benefícios |
| `v_phb_armor` | Armaduras com categoria |
| `v_class_spell_slots` | Slots de magia por classe/nível |
| `v_phb_class_skill_choice` | Pool de perícias por classe |
| `v_phb_species_trait_choices` | Escolhas de traço de espécie |
| `v_phb_subclass_mechanics` | Mecânicas de subclasse |
| `v_phb_subclass_prepared_spell` | Magias preparadas de subclasse |
| `v_phb_subclass_spells_expected` | Magias esperadas por subclasse |
| `mv_spell_by_class` | Materialized — refresh manual ou cron |

## Polimorfismo

**`phb_resource_definition`:** exatamente um de `species_id`, `class_id`, `subclass_id` conforme `resource_scope`.

**`phb_spell_source`:** origem via `origin` enum + FKs opcionais (class, species, feat, subclass).

**Itens:** subtipo determinado por existência em `phb_weapon` / `phb_armor` / `phb_tool`.
