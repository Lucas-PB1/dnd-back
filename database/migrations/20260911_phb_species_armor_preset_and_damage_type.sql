-- Forward: species armor presets + damage_type slugs EN em option_value

CREATE TABLE IF NOT EXISTS rpg.phb_species_armor_preset (
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  preset_slug TEXT NOT NULL,
  label TEXT NOT NULL,
  base_ac INTEGER NOT NULL CHECK (base_ac >= 0),
  ability_a_slug TEXT NOT NULL,
  ability_a_cap INTEGER CHECK (ability_a_cap IS NULL OR ability_a_cap >= 0),
  ability_b_slug TEXT,
  ability_b_cap INTEGER CHECK (ability_b_cap IS NULL OR ability_b_cap >= 0),
  pick_mode TEXT NOT NULL DEFAULT 'single'
    CHECK (pick_mode IN ('single', 'max_of')),
  counts_as_worn_armor BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (species_id, preset_slug),
  CONSTRAINT phb_species_armor_preset_max_of_needs_b CHECK (
    pick_mode <> 'max_of' OR ability_b_slug IS NOT NULL
  )
);

INSERT INTO rpg.phb_species_armor_preset (
  species_id, preset_slug, label, base_ac,
  ability_a_slug, ability_a_cap, ability_b_slug, ability_b_cap,
  pick_mode, counts_as_worn_armor
)
SELECT s.id, v.preset_slug, v.label, v.base_ac,
  v.ability_a_slug, v.ability_a_cap, v.ability_b_slug, v.ability_b_cap,
  v.pick_mode, v.counts_as_worn_armor
FROM rpg.phb_species s
CROSS JOIN (
  VALUES
    ('infiltrator', 'Manikin (Infiltrador)', 11, 'destreza', NULL::int, NULL::text, NULL::int, 'single', FALSE),
    ('sentinel', 'Manikin (Sentinela)', 13, 'destreza', 2, 'forca', 3, 'max_of', TRUE),
    ('tormentor', 'Manikin (Tormentador)', 16, 'forca', 2, NULL, NULL, 'single', TRUE)
) AS v(preset_slug, label, base_ac, ability_a_slug, ability_a_cap, ability_b_slug, ability_b_cap, pick_mode, counts_as_worn_armor)
WHERE s.slug = 'manikin'
ON CONFLICT (species_id, preset_slug) DO UPDATE SET
  label = EXCLUDED.label,
  base_ac = EXCLUDED.base_ac,
  ability_a_slug = EXCLUDED.ability_a_slug,
  ability_a_cap = EXCLUDED.ability_a_cap,
  ability_b_slug = EXCLUDED.ability_b_slug,
  ability_b_cap = EXCLUDED.ability_b_cap,
  pick_mode = EXCLUDED.pick_mode,
  counts_as_worn_armor = EXCLUDED.counts_as_worn_armor;

-- Dragon ancestry: damage_type em slug EN (era rótulo PT)
UPDATE rpg.phb_option_value ov
SET damage_type = m.slug
FROM rpg.phb_species s
JOIN (
  VALUES
    ('blue', 'lightning'),
    ('black', 'acid'),
    ('white', 'cold'),
    ('gold', 'fire'),
    ('bronze', 'lightning'),
    ('silver', 'cold'),
    ('copper', 'acid'),
    ('green', 'poison'),
    ('brass', 'fire'),
    ('red', 'fire')
) AS m(value_id, slug) ON TRUE
WHERE ov.owner_id = s.id
  AND s.slug = 'dragonborn'
  AND ov.scope = 'species'
  AND ov.option_key = 'dragonAncestryId'
  AND ov.value_id = m.value_id;

-- Tiefling legacy: damage_type slug EN
UPDATE rpg.phb_option_value ov
SET damage_type = m.slug
FROM rpg.phb_species s
JOIN (
  VALUES
    ('abyssal', 'poison'),
    ('chthonic', 'necrotic'),
    ('infernal', 'fire')
) AS m(value_id, slug) ON TRUE
WHERE ov.owner_id = s.id
  AND s.slug = 'tiefling'
  AND ov.scope = 'species'
  AND ov.option_key = 'infernalLegacyId'
  AND ov.value_id = m.value_id;
