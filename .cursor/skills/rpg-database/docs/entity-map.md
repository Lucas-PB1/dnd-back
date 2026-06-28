# Mapa JSON → PostgreSQL v4

Schema: `rpg` | SGBD: **PostgreSQL 14+**

Diagrama: [er-diagram.md](er-diagram.md) | Roadmap: [plano-final.md](plano-final.md)

## Camadas

| Camada | JSON | SQL |
|--------|------|-----|
| Catálogo | `data/phb/**` | `rpg.phb_*` (58 tabelas) |
| Ficha | — (PostgreSQL) | `rpg.player_character` + filhas — seed `pc-001…pc-300` |
| Regras PHB | `data/schema/*.schema.json` | Validação Node (`npm run fichas:all`) |

## Catálogo PHB

| JSON / domínio | Tabela(s) SQL |
|----------------|---------------|
| `classes/*.json` | `phb_class`, `phb_class_progression`, `phb_class_feature`, `phb_class_skill_pool`, `phb_class_spellcasting`, `phb_class_saving_throw`, `phb_class_primary_ability`, `phb_class_armor_training`, `phb_class_weapon_proficiency`, `phb_class_fighting_style`, `phb_class_starting_*` |
| `subclasses/*.json` | `phb_subclass`, `phb_subclass_feature`, `phb_subclass_prepared_spell` |
| `species/*.json` | `phb_species`, `phb_species_trait`, `phb_species_option_def`, `phb_species_option_value` |
| `backgrounds/*.json` | `phb_background`, `phb_background_skill`, `phb_background_ability_option`, `phb_background_starting_*` |
| `spells/*.json` | `phb_spell`, `phb_spell_school`, `phb_spell_class` |
| `feats/*.json` | `phb_feat`, `phb_feat_category`, `phb_feat_benefit` |
| `weapons/*.json` | `phb_weapon`, `phb_weapon_property`, `phb_weapon_property_link` |
| `phb_weapon_mastery` | `weapons/rules.json` → masteryProperties |
| `armor/*.json` | `phb_armor`, `phb_armor_category` |
| `tools/*.json` | `phb_tool`, `phb_tool_category` |
| `items/*.json` | `phb_item` (supertipo) |
| Slots de magia | `phb_spell_slot_pattern`, `phb_spell_slot_by_level` |
| Recursos | `phb_resource_definition` |
| Fontes de magia | `phb_spell_source` |
| Linhagens | `phb_elf_lineage`, `phb_infernal_legacy`, `phb_dragon_ancestry` |
| Criação | `phb_alignment`, `phb_language`, `phb_ability`, `phb_skill`, `phb_ability_generation_method`, `phb_background_boost_option` |

## Identidade v4

| Conceito | JSON | SQL |
|----------|------|-----|
| ID público | `"id": "fireball"` | `slug TEXT UNIQUE` |
| ID interno | — | `id BIGSERIAL PRIMARY KEY` |
| FKs | slug no JSON | `*_id BIGINT REFERENCES ...` |

## Ficha de personagem

| JSON | SQL |
|------|-----|
| (documento inteiro) | `player_character.sheet` JSONB NOT NULL |
| `id`, `name`, `level` | colunas + FKs indexadas |
| `abilities` | `player_character_ability` → `phb_ability` (PK composta) |
| `hp` | `hp_current`, `hp_max`, `hp_temp` — **mutável em jogo** |
| `armorClass` | `ac_total` + `ac_detail` — **recalcula** ao equipar/desequipar |
| `resources.*.remaining` | `player_character_resource.remaining` |
| `spellcasting.slotsUsed` | `player_character_spell_slot.slots_used` |

**UI / API:** ler combate de `v_player_character_runtime`, não de `sheet->hp` ou `sheet->armorClass`. O `sheet` JSON espelha o runtime via triggers após cada UPDATE.
| `resources` | `player_character_resource` |
| `speciesChoices` | `player_character_species_option` |
| `classChoices` | `player_character_class_option` |
| `languageIds` | `player_character_language` |
| `skillProficiencies` | `player_character_skill` |
| `savingThrowProficiencies` | `player_character_saving_throw` |
| `feats` | `player_character_feat` — PK `(character_id, feat_id, source)` |
| `spellcasting` | `player_character_spell_list` + `_spell_slot` |
| `equipment` | `player_character_equipment` |
| `weaponMasteryWeaponIds` | `player_character_weapon_mastery` |
| `expertise` | `player_character_expertise` |

## ENUMs PostgreSQL (v4)

- `rpg.item_type` — weapon, armor, gear, tool, focus, other
- `rpg.resource_scope` — species, class
- `rpg.spell_source_origin` — class_list, subclass, species, feat
- `rpg.weapon_category` — simple, martial
- `rpg.casting_type` — full, half, pact, none
- `rpg.option_value_type` — catalog, skill, ability, fighting_style, terrain, skill_list, json
- `rpg.species_choice_kind` — elf_lineage, infernal_legacy, dragon_ancestry

ENUMs da ficha: `skill_source`, `feat_source`, `equipment_source`, `equipment_slot`, `spell_list_type`.

## Removido (legado)

| v1/v2 | v4 |
|-------|-----|
| `character` | `player_character` |
| `benefits JSONB` em feat | `phb_feat_benefit` |
| `property_ids TEXT[]` | `phb_weapon_property_link` |
| `skill_choices JSONB` em class | `phb_class_skill_pool` |
| `spell_slots JSONB` em progression | `phb_spell_slot_by_level` |
| Multiclasse | Fora de escopo |
