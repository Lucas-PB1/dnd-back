-- Seed rpg.phb_class_armor_training
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_armor_training (class_id, category_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'));
