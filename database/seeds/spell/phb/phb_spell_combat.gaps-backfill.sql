-- Backfill ofensivas PHB standalone (gaps L1–6) — PVE-2b auditoria.
-- Fora: smites/weapon-addon (PVE-5), summons (PVE-7), exploração/longo prazo.
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
  -- L1
  ('faca-de-gelo', 'spell_attack', 'Faca de Gelo', 10, 0, NULL, NULL, 1, 0, 1, FALSE, FALSE, FALSE, NULL, NULL, 'piercing'),
  -- L2
  ('forca-espectral', 'save_damage', 'Força Espectral', 8, 0, NULL, NULL, 2, 0, 2, FALSE, FALSE, FALSE, 'none', 'inteligencia', 'psychic'),
  ('crescer-espinhos', 'auto_damage', 'Crescer Espinhos', 4, 0, 2, 0, NULL, NULL, 2, FALSE, FALSE, FALSE, NULL, NULL, 'piercing'),
  ('cordao-de-flechas', 'save_damage', 'Cordão de Flechas', 4, 0, NULL, NULL, 2, 0, 2, FALSE, FALSE, FALSE, 'none', 'destreza', 'piercing'),
  -- L3
  ('muralha-de-vento', 'save_damage', 'Muralha de Vento', 8, 0, NULL, NULL, 4, 0, 3, FALSE, FALSE, FALSE, 'half', 'forca', 'bludgeoning'),
  -- L4
  ('controlar-agua', 'save_damage', 'Controlar Água', 8, 0, NULL, NULL, 2, 0, 4, FALSE, FALSE, FALSE, 'half', 'forca', 'bludgeoning'),
  -- L5
  ('mao-de-bigby', 'spell_attack', 'Mão de Bigby', 8, 0, NULL, NULL, 5, 2, 5, FALSE, FALSE, FALSE, NULL, NULL, 'force'),
  ('contagio', 'save_damage', 'Contágio', 8, 0, NULL, NULL, 11, 0, 5, FALSE, FALSE, FALSE, 'none', 'constituicao', 'necrotic'),
  ('tempestade-radiante-de-jallarzi', 'save_damage', 'Tempestade Radiante de Jallarzi', 10, 0, NULL, NULL, 4, 1, 5, FALSE, FALSE, FALSE, 'half', 'constituicao', 'radiant'),
  ('presenca-regia-de-yolande', 'save_damage', 'Presença Régia de Yolande', 6, 0, NULL, NULL, 4, 0, 5, FALSE, FALSE, FALSE, 'none', 'sabedoria', 'psychic'),
  -- L6
  ('proibicao', 'auto_damage', 'Proibição', 10, 0, 5, 0, NULL, NULL, 6, FALSE, FALSE, FALSE, NULL, NULL, 'necrotic')
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
