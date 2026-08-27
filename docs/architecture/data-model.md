# Modelo de dados — catálogo PHB 2024

Schema PostgreSQL `rpg` — **~81 tabelas base** (65 `phb_*` + runtime + `schema_migration`), views `v_phb_*`, 1 materialized view.

Fonte: [`database/migrations/`](../database/migrations/) · Consolidação: [`adr-schema-consolidation.md`](adr-schema-consolidation.md) · [`schema-equivalence-map.md`](schema-equivalence-map.md)

Padrões DRY: [`catalog-patterns.md`](catalog-patterns.md)

## Convenções

| Regra | Detalhe |
|-------|---------|
| Identidade | `BIGSERIAL id` interno + `slug TEXT UNIQUE` para API/contratos |
| Prefixo | Catálogo `phb_*`; runtime `player_character_*` / `campaign_*` |
| Audit | `created_at`, `updated_at` em entidades principais |
| API | URLs/DTOs usam **slug**; joins SQL usam **id** |
| Catálogo | **Read-only** na aplicação — seeds em `database/seeds/` |

## ENUMs (amostra — `010_types/`)

| Tipo | Uso |
|------|-----|
| `option_scope` | subclass, species, feat, class |
| `option_value_type` | catalog, skill, ability, spell, … |
| `starting_package_source` | class, background |
| `spell_grant_origin` | feat, species, class |
| `class_proficiency_kind` | saving_throw, primary_ability, armor_training, weapon, fighting_style |
| `resource_owner_kind` | class, subclass |
| `combat_modifier_kind` | hp_bonus, unarmored_defense |
| `hit_die`, `feat_category`, `condition_slug`, … | Lote A (lookups → ENUM) |
| `actor_kind`, `innate_spell_usage`, `actor_action_bucket` | Fichas de mesa (`game_actor*`) — `011_actor_types.sql` |

## Clusters

### 1. Core

- `phb_edition`, `phb_source_citation`
- `phb_ability`, `phb_alignment`, `phb_language`, `phb_skill`
- `phb_fighting_style`, `phb_weapon_property`, `phb_weapon_mastery`
- `phb_character_level`

### 2. Spells

- `phb_spell_school`, `phb_spell`, `phb_spell_class`
- `phb_spell_slot_pattern`, `phb_spell_slot_by_level`
- `phb_spell_source` — metadado de origem (listas/subclass)
- `phb_spell_grant` — magias concedidas (feat/species/class); views `v_phb_*_granted_spell`

### 3. Classes

- `phb_class` (`hit_die` ENUM), `phb_subclass` (FK composta)
- `phb_class_feature`, `phb_class_progression`, `phb_subclass_feature`, `phb_subclass_progression`
- `phb_class_skill_pool`, `phb_class_spellcasting`, `phb_subclass_spellcasting`
- `phb_class_proficiency` — unifica saving throw, primary ability, armor, weapon, fighting style
- `phb_class_ability_boost`
- `phb_starting_package` / `phb_starting_item` (`source` class|background)

### 4. Species

- `phb_species`, `phb_species_trait`
- Escolhas (incl. lineages): `phb_option_def` / `phb_option_value` com `scope='species'`
- Views: `v_phb_species_trait_choices`, `v_phb_species_granted_spell`

### 5. Equipment

- `phb_item` + `phb_weapon` / `phb_armor` / `phb_tool`
- `phb_weapon_property_link`, `phb_armor_category`, `phb_tool_category`

### 6. Backgrounds

- `phb_background` + skill / ability_option / language / tool_option / boost_option
- Packages via `phb_starting_*` com `source='background'`

### 7. Options / resources / modifiers

- `phb_option_def` / `phb_option_value` — scope unificado
- `phb_resource_definition` + `phb_resource_grant`
- `phb_combat_modifier` — HP bonus + unarmored defense (views `v_phb_hp_bonus_source`, `v_phb_unarmored_defense`)

### 8. Combat mechanical catalog

- Maneuvers, table actions, masks, aspect benefits, economy/panel actions, etc.
- Views `v_phb_*` + seeds `database/seeds/combat/`

### 9. Feats

- `phb_feat` (`category` ENUM), `phb_feat_benefit`, `phb_feat_requirement` (+ ability)
- Opções via `phb_option_*` (`scope='feat'`)

### 10. Creature / vehicle templates (catálogo read-only)

- `phb_creature_template` + filhos (`_speed`, `_action`, `_spell`)
- `phb_vehicle_template` + filhos (`_speed`, `_action`)
- Views: `v_phb_creature_template_bundle`, `v_phb_vehicle_template_bundle` (`V061`)

### 11. Character Threads (Northlands)

- Catálogo: `phb_character_thread` + `_goal` + `_milestone` + `_milestone_benefit` (`T085`)
- View: `v_phb_character_thread_bundle` (`V063`)
- Estado: `player_character_thread` + `_milestone` (`P039`) — no máx. 1 `active` por personagem
- Seed: `N036`
- Seed: `database/seeds/creatures/` (ex.: Primal Companion Terra)
- Spawn runtime: `rpg.spawn_game_actor_from_template(template_slug, …)`

## Runtime (ficha / campanha / actors)

- `player_character` (+ skill, spell, language, feat, item, equipment, state, species_choice, option)
- **`game_actor`** (+ speed, action, spell, state) — criaturas, montarias, navios, companions; **separado** de `player_character`
- `campaign`, `campaign_member`, `campaign_character`, `campaign_encounter`, `campaign_encounter_combatant`
- Criticals: FKs ownership, subclass∈class, XOR combatant (`pc` ↔ `character_id` **ou** `actor` ↔ `actor_id`), UNIQUEs de membership

Combatente de encontro: `kind IN ('pc','actor')`. Criaturas manuais viram `game_actor` linkado por `actor_id` (sem colunas duplicadas de PV/CA/nome no combatente).

## Views (read models)

Contratos estáveis para a API — ver pasta `060_views/` e skill `phb-query-views`. Principais: `v_phb_class_equipment`, `v_phb_background_equipment`, `v_phb_species_trait_choices`, `v_phb_species_granted_spell`, `v_phb_feat_granted_spell`, `mv_spell_by_class`.

Ficha do jogador (GET): `rpg.get_character_sheet_bundle` (P030/P032 — filhos + PB + boosts de classe + size da espécie) + `rpg.get_character_combat_bundle` (P031 — inventário/itens/armadura/defesa sem armadura).

Ficha de actor (GET): `rpg.get_game_actor_bundle` (P035 — actor + speeds + actions + spells + state).

Magias por classe (API): entity `VSpellByClass` lê **`mv_spell_by_class`** (não a view viva). `REFRESH … CONCURRENTLY` no fim de `npm run db:seed`.

## Contagem vs meta 45–60

Após lotes A–G o schema ficou em **~81** tabelas base (não 45–60). Justificativa no ADR: pacote de combate tipado + runtime completo + cobertura PHB/Valdas mantidos de propósito; a consolidação removeu fragmentação (lookups, lineages, options, packages, grants, afinidades, modifiers), não o domínio mecânico.
