-- Magias PHB níveis 4–6 ofensivas/cura (PVE-2a). Summons / condição pura → slot_only (PVE-3/7).
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
  -- Nv 4: spell_attack
  ('vinha-agarradora', 'spell_attack', 'Vinha Agarradora', 8, 0, NULL, NULL, 4, 0, 4, FALSE, FALSE, FALSE, NULL, NULL, 'bludgeoning'),
  -- Nv 4: save_damage
  ('assassino-fantasmagorico', 'save_damage', 'Assassino Fantasmagórico', 10, 0, NULL, NULL, 4, 1, 4, FALSE, FALSE, FALSE, 'half', 'sabedoria', 'psychic'),
  ('esfera-vitriolica', 'save_damage', 'Esfera Vitriólica', 4, 0, NULL, NULL, 10, 2, 4, FALSE, FALSE, FALSE, 'half', 'destreza', 'acid'),
  ('malogro', 'save_damage', 'Malogro', 8, 0, NULL, NULL, 8, 1, 4, FALSE, FALSE, FALSE, 'half', 'constituicao', 'necrotic'),
  ('muralha-de-fogo', 'save_damage', 'Muralha de Fogo', 8, 0, NULL, NULL, 5, 1, 4, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  -- Tempestade Glacial: 2d10+4d6 ≈ 6d6 no skirmish
  ('tempestade-glacial', 'save_damage', 'Tempestade Glacial', 6, 0, NULL, NULL, 6, 1, 4, FALSE, FALSE, FALSE, 'half', 'destreza', 'cold'),
  ('tentaculos-negros-de-evard', 'save_damage', 'Tentáculos Negros de Evard', 6, 0, NULL, NULL, 3, 0, 4, FALSE, FALSE, FALSE, 'none', 'forca', 'bludgeoning'),
  -- Nv 5: cura
  ('curar-ferimentos-em-massa', 'heal_combatant', 'Curar Ferimentos em Massa', 8, 0, NULL, NULL, 5, 1, 5, FALSE, FALSE, TRUE, NULL, NULL, NULL),
  -- Nv 5: spell_attack
  ('golpe-de-arco', 'spell_attack', 'Golpe de Arço', 10, 0, NULL, NULL, 6, 0, 5, FALSE, FALSE, FALSE, NULL, NULL, 'force'),
  -- Nv 5: save_damage
  -- Coluna de Chamas: 5d6 ígneo + 5d6 radiante; upcast +1d6 cada (=+2d6)
  ('coluna-de-chamas', 'save_damage', 'Coluna de Chamas', 6, 0, NULL, NULL, 10, 2, 5, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('cone-de-frio', 'save_damage', 'Cone de Frio', 8, 0, NULL, NULL, 8, 1, 5, FALSE, FALSE, FALSE, 'half', 'constituicao', 'cold'),
  ('conjurar-saraivada', 'save_damage', 'Conjurar Saraivada', 8, 0, NULL, NULL, 8, 0, 5, FALSE, FALSE, FALSE, 'half', 'destreza', 'force'),
  ('estatica-sinaptica', 'save_damage', 'Estática Sináptica', 6, 0, NULL, NULL, 8, 0, 5, FALSE, FALSE, FALSE, 'half', 'inteligencia', 'psychic'),
  ('nevoa-mortal', 'save_damage', 'Névoa Mortal', 8, 0, NULL, NULL, 5, 1, 5, FALSE, FALSE, FALSE, 'half', 'constituicao', 'poison'),
  -- Onda Destrutiva: 5d6 trovão + 5d6 necrótico/radiante
  ('onda-destrutiva', 'save_damage', 'Onda Destrutiva', 6, 0, NULL, NULL, 10, 0, 5, FALSE, FALSE, FALSE, 'half', 'constituicao', 'thunder'),
  ('praga-de-insetos', 'save_damage', 'Praga de Insetos', 10, 0, NULL, NULL, 4, 1, 5, FALSE, FALSE, FALSE, 'half', 'constituicao', 'piercing'),
  -- Nv 6: save_damage
  ('barreira-de-laminas', 'save_damage', 'Barreira de Lâminas', 10, 0, NULL, NULL, 6, 0, 6, FALSE, FALSE, FALSE, 'half', 'destreza', 'force'),
  ('circulo-da-morte', 'save_damage', 'Círculo da Morte', 8, 0, NULL, NULL, 8, 2, 6, FALSE, FALSE, FALSE, 'half', 'constituicao', 'necrotic'),
  ('corrente-de-relampagos', 'save_damage', 'Corrente de Relâmpagos', 8, 0, NULL, NULL, 10, 0, 6, FALSE, FALSE, FALSE, 'half', 'destreza', 'lightning'),
  ('esfera-congelante-de-otiluke', 'save_damage', 'Esfera Congelante de Otiluke', 6, 0, NULL, NULL, 10, 1, 6, FALSE, FALSE, FALSE, 'half', 'constituicao', 'cold'),
  ('muralha-de-espinhos', 'save_damage', 'Muralha de Espinhos', 8, 0, NULL, NULL, 7, 1, 6, FALSE, FALSE, FALSE, 'half', 'destreza', 'piercing'),
  ('muralha-de-gelo', 'save_damage', 'Muralha de Gelo', 6, 0, NULL, NULL, 10, 2, 6, FALSE, FALSE, FALSE, 'half', 'destreza', 'cold'),
  ('raio-solar', 'save_damage', 'Raio Solar', 8, 0, NULL, NULL, 6, 0, 6, FALSE, FALSE, FALSE, 'half', 'constituicao', 'radiant')
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
