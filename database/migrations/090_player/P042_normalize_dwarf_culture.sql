-- Normaliza fichas com slug variante anão → dwarf + dwarf_culture.

INSERT INTO rpg.player_character_species_choice (character_id, choice_kind, choice_slug)
SELECT
  pc.id,
  'dwarf_culture',
  CASE pc.species_slug
    WHEN 'baugsmidr-dwarf' THEN 'baugsmidr'
    WHEN 'fjord-dwarf' THEN 'fjord'
  END
FROM rpg.player_character pc
WHERE pc.species_slug IN ('baugsmidr-dwarf', 'fjord-dwarf')
ON CONFLICT (character_id, choice_kind) DO UPDATE SET
  choice_slug = EXCLUDED.choice_slug;

UPDATE rpg.player_character
SET species_slug = 'dwarf'
WHERE species_slug IN ('baugsmidr-dwarf', 'fjord-dwarf');

INSERT INTO rpg.player_character_species_choice (character_id, choice_kind, choice_slug)
SELECT pc.id, 'dwarf_culture', 'phb'
FROM rpg.player_character pc
WHERE pc.species_slug = 'dwarf'
  AND NOT EXISTS (
    SELECT 1
    FROM rpg.player_character_species_choice sc
    WHERE sc.character_id = pc.id
      AND sc.choice_kind = 'dwarf_culture'
  );
