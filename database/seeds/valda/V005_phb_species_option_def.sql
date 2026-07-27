-- Seed Valda species option defs

INSERT INTO rpg.phb_species_option_def (species_id, option_key, value_type)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'catalog'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'skill'::rpg.option_value_type)
ON CONFLICT (species_id, option_key) DO UPDATE SET value_type = EXCLUDED.value_type;

INSERT INTO rpg.phb_species_option_def (species_id, option_key, value_type)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'skill'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'ability'::rpg.option_value_type),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'catalog'::rpg.option_value_type)
ON CONFLICT (species_id, option_key) DO UPDATE SET value_type = EXCLUDED.value_type;
