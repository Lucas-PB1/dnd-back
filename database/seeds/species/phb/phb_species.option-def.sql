-- Seed rpg.phb_option_def (scope = 'species')
-- Lote C: migrado de phb_species_option_def

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'keenSensesSkillId', 'skill'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalCastingAbilityId', 'ability'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeLineageId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeCastingAbilityId', 'ability'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;
