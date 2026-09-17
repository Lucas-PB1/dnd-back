-- Magias PHB níveis 7–9 ofensivas/cura (PVE-2b).
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
  -- Nv 7
  ('tempestade-de-fogo', 'save_damage', 'Tempestade de Fogo', 10, 0, NULL, NULL, 7, 0, 7, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('simbolo', 'save_damage', 'Símbolo', 10, 0, NULL, NULL, 10, 0, 7, FALSE, FALSE, FALSE, 'none', 'sabedoria', 'necrotic'),
  -- Rajada Prismática: raio aleatório; tipamos 12d6 (dano típico de cor)
  ('rajada-prismatica', 'save_damage', 'Rajada Prismática', 6, 0, NULL, NULL, 12, 0, 7, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('regeneracao', 'heal_combatant', 'Regeneração', 8, 0, NULL, NULL, 4, 0, 7, FALSE, FALSE, FALSE, NULL, NULL, NULL),
  -- Conjurar Celestial: modo Luz Flamejante (6d12 radiante)
  ('conjurar-celestial', 'auto_damage', 'Conjurar Celestial', 12, 0, 6, 1, NULL, NULL, 7, FALSE, FALSE, FALSE, NULL, NULL, 'radiant'),
  -- Nv 8
  ('explosao-solar', 'save_damage', 'Explosão Solar', 6, 0, NULL, NULL, 12, 0, 8, FALSE, FALSE, FALSE, 'half', 'constituicao', 'radiant'),
  ('nuvem-incendiaria', 'save_damage', 'Nuvem Incendiária', 8, 0, NULL, NULL, 10, 0, 8, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('suplicio', 'save_damage', 'Suplício', 12, 0, NULL, NULL, 10, 0, 8, FALSE, FALSE, FALSE, 'none', 'inteligencia', 'psychic'),
  ('terremoto', 'save_damage', 'Terremoto', 6, 0, NULL, NULL, 12, 0, 8, FALSE, FALSE, FALSE, 'half', 'destreza', 'bludgeoning'),
  ('tsunami', 'save_damage', 'Tsunami', 10, 0, NULL, NULL, 6, 0, 8, FALSE, FALSE, FALSE, 'half', 'forca', 'bludgeoning'),
  -- Nv 9
  -- Chuva de Meteoros: 20d6 ígneo + 20d6 contundente
  ('chuva-de-meteoros', 'save_damage', 'Chuva de Meteoros', 6, 0, NULL, NULL, 40, 0, 9, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('encarnacao-fantasmagorica', 'save_damage', 'Encarnação Fantasmagórica', 10, 0, NULL, NULL, 10, 0, 9, FALSE, FALSE, FALSE, 'half', 'sabedoria', 'psychic'),
  ('muralha-prismatica', 'save_damage', 'Muralha Prismática', 6, 0, NULL, NULL, 12, 0, 9, FALSE, FALSE, FALSE, 'half', 'constituicao', 'fire'),
  ('palavra-de-poder-matar', 'auto_damage', 'Palavra de Poder: Matar', 12, 0, 12, 0, NULL, NULL, 9, FALSE, FALSE, FALSE, NULL, NULL, 'psychic'),
  -- pulso inicial da Tempestade da Vingança
  ('tempestade-da-vinganca', 'save_damage', 'Tempestade da Vingança', 6, 0, NULL, NULL, 2, 0, 9, FALSE, FALSE, FALSE, 'none', 'constituicao', 'thunder')
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
