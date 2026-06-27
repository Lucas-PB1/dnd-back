# Mapa JSON → PostgreSQL v3

Schema: `rpg` | SGBD: **PostgreSQL 14+**

Diagrama completo: [er-diagram.md](er-diagram.md)

## Camadas

| Camada | JSON | SQL |
|--------|------|-----|
| Catálogo | `data/phb/**` | `rpg.phb_*` |
| Ficha | `data/characters/*.json` | `rpg.player_character` + filhas |
| Canônico round-trip | ficha inteira | `player_character.sheet` JSONB |

## Ficha híbrida

| JSON | SQL v2 |
|------|--------|
| (documento inteiro) | `player_character.sheet` JSONB NOT NULL |
| `id`, `name`, `level` | colunas + FKs indexadas |
| `abilities` | `forca` … `carisma` |
| `hp` | `hp_current`, `hp_max`, `hp_temp` |
| `armorClass` | `ac_total` + `ac_detail` JSONB |
| `resources` | `player_character_resource` (key, max, remaining) |
| `speciesChoices` | `player_character_species_option` (key, value) |
| `classChoices` | `player_character_class_option` (key, value) |
| `languageIds` | `player_character_language` |
| `skillProficiencies` | `player_character_skill` (ENUM source) |
| `savingThrowProficiencies` | `player_character_saving_throw` |
| `feats` | `player_character_feat` + `options` JSONB |
| `spellcasting` | `player_character_spell_list` + `player_character_spell_slot` |
| `equipment` | `player_character_equipment` |
| `weaponMasteryWeaponIds` | `player_character_weapon_mastery` → `phb_weapon` |
| `expertise` | `player_character_expertise` |

## Catálogo extra (v2)

| Tabela | PHB |
|--------|-----|
| `phb_edition` | versionamento regras |
| `phb_fighting_style` | `classes/fighting-styles.json` |
| `phb_weapon_property` | `weapons/properties.json` |
| `phb_tool` | tools / kits (`kit-de-sacerdote`, etc.) |

## Tipos PostgreSQL

- `rpg.ability_id`, `rpg.skill_source`, `rpg.feat_source`
- `rpg.equipment_source`, `rpg.equipment_slot`, `rpg.spell_list_type`, `rpg.item_type`

## Views

- `rpg.v_spell_by_class` — listas por classe
- `rpg.v_player_character_summary` — UI / relatórios

## Removido (v1 → v2)

| v1 | v2 |
|----|-----|
| `character` | `player_character` |
| `resources` JSONB | `player_character_resource` |
| `species_choices` JSONB | `player_character_species_option` |
| `class_choices` JSONB | `player_character_class_option` |
| `hp` / `armor_class` JSONB | colunas tipadas |
