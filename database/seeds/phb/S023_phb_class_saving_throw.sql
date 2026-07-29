-- Seed rpg.phb_class_saving_throw
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_saving_throw (class_id, ability_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'));
