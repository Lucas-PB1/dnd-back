-- Seed rpg.phb_starting_package (class)
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_starting_package (source, owner_id, slug, label, sort_order)
VALUES
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'b', 'B', 2),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'a', 'A', 1),
  ('class', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'b', 'B', 2);
