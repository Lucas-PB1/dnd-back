-- Remove heranças GH legadas de phb_species; migra personagens para phb_heritage.

-- Personagens: species gh-* → heritage_slug
UPDATE rpg.player_character pc
SET heritage_slug = pc.species_slug,
    species_slug = NULL
WHERE pc.species_slug LIKE 'gh-%'
  AND pc.species_slug <> 'gh-heritage-traits';

-- Escolhas runtime: gh_heritage_* → heritage_*
UPDATE rpg.player_character_species_choice
SET choice_kind = replace(choice_kind, 'gh_heritage_', 'heritage_')
WHERE choice_kind LIKE 'gh_heritage_%';

-- Opções do pool legado
DELETE FROM rpg.phb_option_value
WHERE scope = 'species'::rpg.option_scope
  AND owner_id IN (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits');

DELETE FROM rpg.phb_option_def
WHERE scope = 'species'::rpg.option_scope
  AND owner_id IN (SELECT id FROM rpg.phb_species WHERE slug = 'gh-heritage-traits');

-- Traços fixos / slots legados em phb_species_trait
DELETE FROM rpg.phb_species_trait
WHERE species_id IN (SELECT id FROM rpg.phb_species WHERE slug LIKE 'gh-%');

-- Heranças GH em phb_species
DELETE FROM rpg.phb_species
WHERE slug LIKE 'gh-%';
