-- Seed rpg.phb_species_option_value
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_species_option_value (species_id, option_key, value_id, label)
VALUES
  ((SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'high-elf', 'high-elf'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'drow', 'drow'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'elf'), 'lineageId', 'wood-elf', 'wood-elf'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'abyssal', 'abyssal'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'chthonic', 'chthonic'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'tiefling'), 'infernalLegacyId', 'infernal', 'infernal'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeLineageId', 'rock-gnome', 'rock-gnome'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'gnome'), 'gnomeLineageId', 'forest-gnome', 'forest-gnome'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'blue', 'blue'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'black', 'black'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'white', 'white'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'gold', 'gold'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'bronze', 'bronze'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'silver', 'silver'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'copper', 'copper'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'green', 'green'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'brass', 'brass'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), 'dragonAncestryId', 'red', 'red'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'ice', 'ice'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'fire', 'fire'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'stone', 'stone'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'cloud', 'cloud'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'hill', 'hill'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), 'giantAncestryId', 'storm', 'storm'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'celestial-wings', 'celestial-wings'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'necrotic-shroud', 'necrotic-shroud'),
  ((SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), 'aasimarRevelationId', 'radiant-consumption', 'radiant-consumption');
