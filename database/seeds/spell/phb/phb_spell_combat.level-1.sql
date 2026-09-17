-- Magias PHB nível 1 ofensivas/cura (PVE-1b). Utilitárias ficam slot_only.
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
  -- cura
  ('curar-ferimentos', 'heal_combatant', 'Curar Ferimentos', 8, 0, NULL, NULL, 2, 2, 1, FALSE, FALSE, TRUE, NULL, NULL, NULL),
  ('palavra-curativa', 'heal_combatant', 'Palavra Curativa', 4, 0, NULL, NULL, 2, 2, 1, FALSE, FALSE, TRUE, NULL, NULL, NULL),
  -- spell_attack
  ('raio-guia', 'spell_attack', 'Raio Guia', 6, 0, NULL, NULL, 4, 1, 1, FALSE, FALSE, FALSE, NULL, NULL, 'radiant'),
  ('orbe-cromatico', 'spell_attack', 'Orbe Cromático', 8, 0, NULL, NULL, 3, 1, 1, FALSE, FALSE, FALSE, NULL, NULL, 'fire'),
  ('raio-de-bruxa', 'spell_attack', 'Raio de Bruxa', 12, 0, NULL, NULL, 2, 1, 1, FALSE, FALSE, FALSE, NULL, NULL, 'lightning'),
  ('raio-nauseante', 'spell_attack', 'Raio Nauseante', 8, 0, NULL, NULL, 2, 1, 1, FALSE, FALSE, FALSE, NULL, NULL, 'poison'),
  -- save_damage
  ('maos-flamejantes', 'save_damage', 'Mãos Flamejantes', 6, 0, NULL, NULL, 3, 1, 1, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('onda-trovejante', 'save_damage', 'Onda Trovejante', 8, 0, NULL, NULL, 2, 1, 1, FALSE, FALSE, FALSE, 'half', 'constituicao', 'thunder'),
  ('bracos-de-hadar', 'save_damage', 'Braços de Hadar', 6, 0, NULL, NULL, 2, 1, 1, FALSE, FALSE, FALSE, 'half', 'forca', 'necrotic'),
  ('infligir-ferimentos', 'save_damage', 'Infligir Ferimentos', 10, 0, NULL, NULL, 2, 1, 1, FALSE, FALSE, FALSE, 'half', 'constituicao', 'necrotic'),
  ('sussurros-dissonantes', 'save_damage', 'Sussurros Dissonantes', 6, 0, NULL, NULL, 3, 1, 1, FALSE, FALSE, FALSE, 'half', 'sabedoria', 'psychic'),
  ('saraivada-de-espinhos', 'save_damage', 'Saraivada de Espinhos', 10, 0, NULL, NULL, 1, 1, 1, FALSE, FALSE, FALSE, 'half', 'destreza', 'piercing'),
  ('repreensao-diabolica', 'save_damage', 'Repreensão Diabólica', 10, 0, NULL, NULL, 2, 1, 1, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire')
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
