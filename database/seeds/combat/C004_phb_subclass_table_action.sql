-- Seed: Subclass table actions (Psi Warrior + Soulknife)
-- Soulknife: slugs alinhados ao handler/DTO (`guided-strike`, `psychic-teleport`).

-- Psi Warrior actions
INSERT INTO rpg.phb_subclass_table_action (subclass_id, slug, name, unlock_level, free_resource_slug, always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 'protective-field', 'Campo Protetor', 3, NULL, true, true, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 'telekinetic-movement', 'Movimento Telecinético', 3, 'telekinetic-movement', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 'psychic-leap', 'Salto com Impulsão Psíquica', 7, 'psychic-leap', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 'mental-guard', 'Resguardo Mental', 10, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 'energy-bulwark', 'Baluarte de Energia', 15, 'energy-bulwark', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 'telekinetic-master', 'Mestre Telecinético', 18, 'telekinetic-master', false, false, false, NULL, NULL),

  -- Soulknife actions (canônico = handler)
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 'psi-bolstered-knack', 'Aptidão Reforçada Psiquicamente', 3, NULL, false, true, true, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 'psychic-whispers', 'Sussurros Psíquicos', 3, 'psychic-whispers', false, true, false, NULL, 1),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 'guided-strike', 'Golpes Teleguiados', 9, NULL, false, true, true, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 'psychic-teleport', 'Teleporte Psíquico', 9, NULL, false, true, false, 1, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 'psychic-veil', 'Véu Psíquico', 13, 'psychic-veil', false, false, false, NULL, 1),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'), 'rend-mind', 'Rasgar Mente', 17, 'rend-mind', false, false, false, NULL, 3)
ON CONFLICT (subclass_id, slug) DO UPDATE
  SET name = EXCLUDED.name,
      unlock_level = EXCLUDED.unlock_level,
      free_resource_slug = EXCLUDED.free_resource_slug,
      always_spends_pool = EXCLUDED.always_spends_pool,
      rolls_pool_die = EXCLUDED.rolls_pool_die,
      spends_only_on_success = EXCLUDED.spends_only_on_success,
      always_pool_cost = EXCLUDED.always_pool_cost,
      repeat_pool_cost = EXCLUDED.repeat_pool_cost;

-- Remover slugs legados (homing-strikes / psychic-teleportation) após alinhar ao handler.
DELETE FROM rpg.phb_subclass_table_action
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife')
  AND slug IN ('homing-strikes', 'psychic-teleportation');
