-- Seed rpg.phb_background_starting_package
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_background_starting_package (background_id, slug, label, gold, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_background WHERE slug = 'acolyte'), 'a', 'A', 8, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'wanderer'), 'a', 'A', 16, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'artisan'), 'a', 'A', 32, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'entertainer'), 'a', 'A', 11, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'charlatan'), 'a', 'A', 15, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'criminal'), 'a', 'A', 16, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'hermit'), 'a', 'A', 16, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'scribe'), 'a', 'A', 23, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'farmer'), 'a', 'A', 30, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'guard'), 'a', 'A', 12, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'guide'), 'a', 'A', 3, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'sailor'), 'a', 'A', 20, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'merchant'), 'a', 'A', 22, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'noble'), 'a', 'A', 29, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'sage'), 'a', 'A', 8, 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'soldier'), 'a', 'A', 14, 1);
