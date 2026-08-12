-- Table actions — Northlands Heroes of the Sagas (declarativo)

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 'bragi-rune', 'Runa da Fala de Bragi', 6, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 'battle-sagas', 'Sagas de Batalha', 14, 'battle-sagas', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'adjust-the-skein', 'Ajustar a Teia', 3, 'norn-skeins', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'pluck-the-threads', 'Puxar os Fios', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'intertwined-fate', 'Destino Entrelaçado', 6, NULL, false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'wolf-mantle', 'Manto do Lobo', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'defend-the-pack', 'Defender a Alcateia', 10, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'children-of-great-wolf', 'Filhos do Grande Lobo', 14, 'children-of-great-wolf', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 'marauders-reprisal', 'Represália do Saqueador', 15, 'marauders-reprisal', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 'unstoppable-assault', 'Assalto Imparável', 18, 'unstoppable-assault', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'encouraging-smite', 'Destruição Encorajadora', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'guardian-of-the-dead', 'Guardião dos Mortos', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'spirit-of-the-valkyrie', 'Espírito da Valquíria', 20, 'spirit-of-the-valkyrie', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'spirit-guidance', 'Orientação Espiritual', 3, 'spirit-guidance', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'spirit-aura', 'Aura Espiritual', 6, 'spirit-aura', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'spirit-secrets', 'Segredos Espirituais', 14, 'spirit-secrets', false, false, false, NULL, NULL),

  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 'context-switch', 'Troca de Contexto', 3, 'context-switch', false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 'harbinger-of-chaos', 'Arauto do Caos', 14, 'harbinger-of-chaos', false, false, false, NULL, NULL)
ON CONFLICT (subclass_id, slug) DO UPDATE
  SET name = EXCLUDED.name,
      unlock_level = EXCLUDED.unlock_level,
      free_resource_slug = EXCLUDED.free_resource_slug,
      always_spends_pool = EXCLUDED.always_spends_pool,
      rolls_pool_die = EXCLUDED.rolls_pool_die,
      spends_only_on_success = EXCLUDED.spends_only_on_success,
      always_pool_cost = EXCLUDED.always_pool_cost,
      repeat_pool_cost = EXCLUDED.repeat_pool_cost;
