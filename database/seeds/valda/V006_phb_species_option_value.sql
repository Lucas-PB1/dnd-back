-- Seed Valda species option values

INSERT INTO rpg.phb_species_option_value (species_id, option_key, value_id, label)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'bisque', 'Bisque'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'marionette', 'Marionette'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'geppettinConstructionId', 'plushie', 'Plushie'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'intimidation', 'Intimidation'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'performance', 'Performance'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'geppettin'), 'handcraftedSkillId', 'persuasion', 'Persuasion')
ON CONFLICT (species_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;

INSERT INTO rpg.phb_species_option_value (species_id, option_key, value_id, label)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'nature', 'Nature'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'naturalConnectionSkillId', 'survival', 'Survival'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'inteligencia', 'Intelligence'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'sabedoria', 'Wisdom'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'rootMagicCastingAbilityId', 'carisma', 'Charisma'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'spring', 'Spring'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'summer', 'Summer'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'autumn', 'Autumn'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'), 'harvestSeasonId', 'winter', 'Winter')
ON CONFLICT (species_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
