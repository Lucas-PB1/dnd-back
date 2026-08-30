-- Table actions — Grim Hollow Cap. 2 (piloto: guildas Caçador de Monstros)

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'carver-guild'), 'close-quarters', 'Corpo a Corpo', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'), 'consume-portion', 'Consumir Porção', 3, 'devourer-portion', true, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'), 'harvest-portion', 'Colher Porção', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'), 'elemental-ammo', 'Munição Elemental', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'), 'runic-bomb', 'Bomba Rúnica', 3, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'), 'agile-response', 'Resposta Ágil', 10, NULL, false, false, false, NULL, NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'occultist-guild'), 'arcane-response', 'Resposta Arcana', 18, NULL, false, false, false, NULL, NULL)
ON CONFLICT (subclass_id, slug) DO UPDATE
  SET name = EXCLUDED.name,
      unlock_level = EXCLUDED.unlock_level,
      free_resource_slug = EXCLUDED.free_resource_slug,
      always_spends_pool = EXCLUDED.always_spends_pool;
