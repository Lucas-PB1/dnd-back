-- Table actions — Griffon's Saddlebag (piloto: Caminho da Glaciar)

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'), 'glacier-rage-extension', 'Extensão de Fúria', 3, NULL, true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'), 'frostbite', 'Geladura', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'), 'cold-fortress-entry', 'Fortaleza Gelada (entrada)', 6, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'), 'cold-fortress-renew', 'Fortaleza Gelada (renovar)', 6, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'), 'avalanche-stomp', 'Pisoteio Glacial', 14, NULL, false, false, false, NULL, NULL)
ON CONFLICT (subclass_id, slug) DO UPDATE
  SET name = EXCLUDED.name,
      unlock_level = EXCLUDED.unlock_level,
      free_resource_slug = EXCLUDED.free_resource_slug,
      always_spends_pool = EXCLUDED.always_spends_pool,
      rolls_pool_die = EXCLUDED.rolls_pool_die,
      spends_only_on_success = EXCLUDED.spends_only_on_success,
      always_pool_cost = EXCLUDED.always_pool_cost,
      repeat_pool_cost = EXCLUDED.repeat_pool_cost;
