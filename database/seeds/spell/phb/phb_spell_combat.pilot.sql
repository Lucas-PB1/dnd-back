INSERT INTO rpg.phb_spell_combat (
  spell_slug,
  resolution,
  label,
  damage_die,
  flat_per_die,
  auto_unit_base,
  auto_unit_per_slot_above_base,
  dice_count_base,
  dice_per_slot_above_base,
  spell_level,
  cantrip_scale,
  per_die_attack,
  include_spellcasting_mod,
  save_success_outcome,
  save_ability_slug,
  damage_type_slug
) VALUES
  (
    'misseis-magicos',
    'auto_damage',
    'Mísseis Mágicos',
    4, 1, 3, 1, NULL, NULL, 1,
    FALSE, FALSE, FALSE, NULL, NULL, 'force'
  ),
  (
    'raio-de-fogo',
    'spell_attack',
    'Raio de Fogo',
    10, 0, NULL, NULL, NULL, NULL, 0,
    TRUE, FALSE, FALSE, NULL, NULL, 'fire'
  ),
  (
    'escuridao',
    'arena_darkness',
    'Escuridão',
    NULL, 0, NULL, NULL, NULL, NULL, 2,
    FALSE, FALSE, FALSE, NULL, NULL, NULL
  )
ON CONFLICT (spell_slug) DO UPDATE SET
  resolution = EXCLUDED.resolution,
  label = EXCLUDED.label,
  damage_die = EXCLUDED.damage_die,
  flat_per_die = EXCLUDED.flat_per_die,
  auto_unit_base = EXCLUDED.auto_unit_base,
  auto_unit_per_slot_above_base = EXCLUDED.auto_unit_per_slot_above_base,
  dice_count_base = EXCLUDED.dice_count_base,
  dice_per_slot_above_base = EXCLUDED.dice_per_slot_above_base,
  spell_level = EXCLUDED.spell_level,
  cantrip_scale = EXCLUDED.cantrip_scale,
  per_die_attack = EXCLUDED.per_die_attack,
  include_spellcasting_mod = EXCLUDED.include_spellcasting_mod,
  save_success_outcome = EXCLUDED.save_success_outcome,
  save_ability_slug = EXCLUDED.save_ability_slug,
  damage_type_slug = EXCLUDED.damage_type_slug;
