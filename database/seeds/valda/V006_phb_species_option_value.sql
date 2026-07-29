-- Seed Valda species option values

INSERT INTO rpg.phb_species_option_value (species_id, option_key, value_id, label)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'bisque', 'Porcelana'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'marionette', 'Marionete'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'plushie', 'Pelúcia'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'intimidation', 'Intimidação'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'performance', 'Atuação'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'persuasion', 'Persuasão')
ON CONFLICT (species_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_species_option_value (species_id, option_key, value_id, label)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'nature', 'Natureza'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'survival', 'Sobrevivência'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'inteligencia', 'Inteligência'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'sabedoria', 'Sabedoria'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'carisma', 'Carisma'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'spring', 'Primavera'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'summer', 'Verão'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'autumn', 'Outono'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'winter', 'Inverno')
ON CONFLICT (species_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
