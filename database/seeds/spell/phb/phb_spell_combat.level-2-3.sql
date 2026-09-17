-- Magias PHB níveis 2–3 ofensivas/cura (PVE-1c). Condições tipadas → `phb_spell_combat.conditions.sql` (PVE-3b).
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
  -- Nv 2: cura
  ('oracao-de-cura', 'heal_combatant', 'Oração de Cura', 8, 0, NULL, NULL, 2, 1, 2, FALSE, FALSE, FALSE, NULL, NULL, NULL),
  -- Nv 2: spell_attack
  ('arma-espiritual', 'spell_attack', 'Arma Espiritual', 8, 0, NULL, NULL, 1, 1, 2, FALSE, FALSE, FALSE, NULL, NULL, 'force'),
  ('flecha-acida-de-melf', 'spell_attack', 'Flecha Ácida de Melf', 4, 0, NULL, NULL, 4, 1, 2, FALSE, FALSE, FALSE, NULL, NULL, 'acid'),
  ('lamina-flamejante', 'spell_attack', 'Lâmina Flamejante', 6, 0, NULL, NULL, 3, 1, 2, FALSE, FALSE, TRUE, NULL, NULL, 'fire'),
  -- Raio Ardente: 3×2d6 ≈ 6d6 num ataque; +1 raio (=+2d6) por slot
  ('raio-ardente', 'spell_attack', 'Raio Ardente', 6, 0, NULL, NULL, 6, 2, 2, FALSE, FALSE, FALSE, NULL, NULL, 'fire'),
  -- Nv 2: auto_damage (área sem save no impacto inicial)
  ('nuvem-de-adagas', 'auto_damage', 'Nuvem de Adagas', 4, 0, 4, 2, NULL, NULL, 2, FALSE, FALSE, FALSE, NULL, NULL, 'slashing'),
  -- Nv 2: save_damage
  ('despedacar', 'save_damage', 'Despedaçar', 8, 0, NULL, NULL, 3, 1, 2, FALSE, FALSE, FALSE, 'half', 'constituicao', 'thunder'),
  ('esfera-flamejante', 'save_damage', 'Esfera Flamejante', 6, 0, NULL, NULL, 2, 1, 2, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('espinho-mental', 'save_damage', 'Espinho Mental', 8, 0, NULL, NULL, 3, 1, 2, FALSE, FALSE, FALSE, 'half', 'sabedoria', 'psychic'),
  ('esquentar-metal', 'save_damage', 'Esquentar Metal', 8, 0, NULL, NULL, 2, 1, 2, FALSE, FALSE, FALSE, 'none', 'constituicao', 'fire'),
  ('raio-lunar', 'save_damage', 'Raio Lunar', 10, 0, NULL, NULL, 2, 1, 2, FALSE, FALSE, FALSE, 'half', 'constituicao', 'radiant'),
  ('sopro-de-dragao', 'save_damage', 'Sopro de Dragão', 6, 0, NULL, NULL, 3, 1, 2, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  -- Nv 3: cura
  ('palavra-curativa-em-massa', 'heal_combatant', 'Palavra Curativa em Massa', 4, 0, NULL, NULL, 2, 1, 3, FALSE, FALSE, TRUE, NULL, NULL, NULL),
  ('aura-de-vitalidade', 'heal_combatant', 'Aura de Vitalidade', 6, 0, NULL, NULL, 2, 0, 3, FALSE, FALSE, FALSE, NULL, NULL, NULL),
  -- Nv 3: spell_attack
  ('toque-vampirico', 'spell_attack', 'Toque Vampírico', 6, 0, NULL, NULL, 3, 1, 3, FALSE, FALSE, FALSE, NULL, NULL, 'necrotic'),
  -- Nv 3: save_damage
  ('bola-de-fogo', 'save_damage', 'Bola de Fogo', 6, 0, NULL, NULL, 8, 1, 3, FALSE, FALSE, FALSE, 'half', 'destreza', 'fire'),
  ('relampago', 'save_damage', 'Relâmpago', 6, 0, NULL, NULL, 8, 1, 3, FALSE, FALSE, FALSE, 'half', 'destreza', 'lightning'),
  ('conjurar-barragem', 'save_damage', 'Conjurar Barragem', 8, 0, NULL, NULL, 5, 1, 3, FALSE, FALSE, FALSE, 'half', 'destreza', 'force'),
  ('convocar-relampagos', 'save_damage', 'Convocar Relâmpagos', 10, 0, NULL, NULL, 3, 1, 3, FALSE, FALSE, FALSE, 'half', 'destreza', 'lightning'),
  ('guardioes-espirituais', 'save_damage', 'Guardiões Espirituais', 8, 0, NULL, NULL, 3, 1, 3, FALSE, FALSE, FALSE, 'half', 'sabedoria', 'radiant'),
  -- Fome de Hadar: no cast tipamos o pulso ácido (save Dex); frio contínuo fica fora
  ('fome-de-hadar', 'save_damage', 'Fome de Hadar', 6, 0, NULL, NULL, 2, 1, 3, FALSE, FALSE, FALSE, 'none', 'destreza', 'acid')
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
