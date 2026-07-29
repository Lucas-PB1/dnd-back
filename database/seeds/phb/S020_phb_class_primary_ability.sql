-- Seed rpg.phb_class_primary_ability
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_primary_ability (class_id, ability_id, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 2);
