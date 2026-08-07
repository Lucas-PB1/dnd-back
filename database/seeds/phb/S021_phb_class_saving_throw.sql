-- Seed rpg.phb_class_proficiency (saving_throw)
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'saving_throw'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'));
