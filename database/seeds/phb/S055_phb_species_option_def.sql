-- Seed rpg.phb_species_option_def
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_species_option_def (species_id, option_key, value_type)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'catalog'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'keenSensesSkillId', 'skill'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'catalog'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalCastingAbilityId', 'ability'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeLineageId', 'catalog'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeCastingAbilityId', 'ability'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'catalog'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'catalog'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'catalog'::rpg.option_value_type);
