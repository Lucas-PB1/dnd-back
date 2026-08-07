-- Seed rpg.phb_class_proficiency (armor_training)
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'armor_training'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'));
