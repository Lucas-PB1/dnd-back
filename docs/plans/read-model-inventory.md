# Inventário alvo — read models

SSOT conceitual: [`adr-read-model-layers.md`](../architecture/adr-read-model-layers.md).  
Fase 2 (espelho → tabela): em execução.

---

## 1. Tabelas — leitura direta (sem view)

Fase 2 — consumer TypeORM na tabela:

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

(+ restante `phb_*` / runtime já tabela)

---

## 2. Views VALUES (labels de enum)

- `v_phb_feat_category`
- `v_phb_condition`
- `v_phb_weapon_proficiency`
- `v_phb_ability_generation_method`

---

## 3. Views join / enriquecimento (permanecem)

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
- `v_phb_feat_granted_spell`
- `v_phb_class_granted_spell`
- `v_phb_species_granted_spell`
- `v_phb_hp_bonus_source`
- `v_phb_unarmored_defense`
- `v_phb_class_ability_boost`
- `v_class_spell_slots`
- `v_subclass_spell_slots`
- `v_phb_heritage_traditional_build`
- `v_phb_heritage_passive_modifier`
- `v_phb_heritage_economy_action`
- `v_phb_heritage_trait_choices`
- `v_phb_high_elf_cantrip_options`
- `v_phb_andari_druid_cantrip_options`
- `v_spell_by_class` *(definição; consumo = MV)*

---

## 4. Materialized views

Já existe:

- `mv_spell_by_class`

Fase 4.1c (ainda não):

- `mv_phb_feat` ← `v_phb_feat`
- `mv_phb_background` ← `v_phb_background`
- `mv_phb_species_trait_choices` ← `v_phb_species_trait_choices`
- `mv_phb_class_economy_action` ← `v_phb_class_economy_action`
- `mv_phb_creature_template_bundle` ← `v_phb_creature_template_bundle`
- `mv_phb_vehicle_template_bundle` ← `v_phb_vehicle_template_bundle`
- `mv_phb_character_thread_bundle` ← `v_phb_character_thread_bundle`

View-mãe das MVs futuras permanece no baseline até a fase MV.

---

## 5. RPC JSONB (runtime)

- `get_character_sheet_bundle`
- `get_character_combat_bundle`
- `get_game_actor_bundle`

---

## 6. Views removidas (fase 2)

- `v_phb_battle_master_maneuver`
- `v_phb_beastborne_aspect_benefit`
- `v_phb_dungeoneer_slayer_type`
- `v_phb_gunslinger_maneuver`
- `v_phb_cunning_strike_effect`
- `v_phb_subclass_table_action`
- `v_phb_persona_mask`
- `v_phb_class_panel_action`
- `v_phb_subclass_precaution_spell`
- `v_phb_class_feature`
- `v_phb_class_progression`

---

## Contagem alvo

| Tipo | Qtd. |
|------|------|
| Views VALUES | 4 |
| Views join (+ view-mãe MV) | ~35 |
| MV | 1 → 8 (fase 4.1c) |
| Views removidas | 11 |
| RPC | 3 |
