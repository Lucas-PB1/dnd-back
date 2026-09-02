# Inventário alvo — read models

SSOT: [`adr-read-model-layers.md`](./adr-read-model-layers.md).

---

## 1. Tabelas — leitura direta

- `phb_battle_master_maneuver`
- `phb_beastborne_aspect_benefit`
- `phb_dungeoneer_slayer_type`
- `phb_gunslinger_maneuver`
- `phb_cunning_strike_effect`
- `phb_subclass_table_action`
- `phb_persona_mask`
- `phb_class_panel_action`
- `phb_subclass_precaution_spell`
- `phb_class_feature`
- `phb_class_progression`

(+ restante `phb_*` / runtime)

---

## 2. Views VALUES

- `v_phb_feat_category`
- `v_phb_condition`
- `v_phb_weapon_proficiency`
- `v_phb_ability_generation_method`

---

## 3. Views join (sem MV — enriquecimento leve)

- `v_phb_class`
- `v_phb_subclass`
- `v_phb_spell`
- `v_phb_armor`
- `v_phb_class_equipment`
- `v_phb_background_equipment`
- `v_phb_background_skill`
- `v_phb_background_tool_option`
- `v_phb_background_language`
- `v_phb_class_skill_choice`
- `v_phb_subclass_mechanics`
- `v_phb_subclass_prepared_spell`
- `v_phb_subclass_spells_expected`
- `v_phb_heritage_traditional_build`
- `v_phb_heritage_passive_modifier`
- `v_phb_heritage_economy_action`
- `v_phb_high_elf_cantrip_options`
- `v_phb_andari_druid_cantrip_options`

View-mãe (definição; **não** ler na API):

- `v_spell_by_class`, `v_phb_feat`, `v_phb_background`, `v_phb_species_trait_choices`
- `v_phb_class_economy_action`, bundles, hp/unarmored, slots, granted spells, ability boost, heritage trait choices

---

## 4. Materialized views (consumo API — **17**)

| MV | View-mãe |
|----|----------|
| `mv_spell_by_class` | `v_spell_by_class` |
| `mv_phb_feat` | `v_phb_feat` |
| `mv_phb_background` | `v_phb_background` |
| `mv_phb_species_trait_choices` | `v_phb_species_trait_choices` |
| `mv_phb_class_economy_action` | `v_phb_class_economy_action` |
| `mv_phb_creature_template_bundle` | `v_phb_creature_template_bundle` |
| `mv_phb_vehicle_template_bundle` | `v_phb_vehicle_template_bundle` |
| `mv_phb_character_thread_bundle` | `v_phb_character_thread_bundle` |
| `mv_phb_hp_bonus_source` | `v_phb_hp_bonus_source` |
| `mv_phb_unarmored_defense` | `v_phb_unarmored_defense` |
| `mv_class_spell_slots` | `v_class_spell_slots` |
| `mv_subclass_spell_slots` | `v_subclass_spell_slots` |
| `mv_phb_class_ability_boost` | `v_phb_class_ability_boost` |
| `mv_phb_feat_granted_spell` | `v_phb_feat_granted_spell` |
| `mv_phb_class_granted_spell` | `v_phb_class_granted_spell` |
| `mv_phb_species_granted_spell` | `v_phb_species_granted_spell` |
| `mv_phb_heritage_trait_choices` | `v_phb_heritage_trait_choices` |

Refresh: `REFRESH … CONCURRENTLY` no fim de `db:seed`.

---

## 5. RPC JSONB

- `get_character_sheet_bundle`
- `get_character_combat_bundle`
- `get_game_actor_bundle`

---

## Contagem

| Tipo | Qtd. |
|------|------|
| Views VALUES | 4 |
| Views join (API) | ~18 |
| MV | **17** |
| RPC | 3 |
