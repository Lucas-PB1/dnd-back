-- Seed rpg.phb_class_proficiency (primary_ability)
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_id, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 2),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'primary_ability'::rpg.class_proficiency_kind, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 2);
