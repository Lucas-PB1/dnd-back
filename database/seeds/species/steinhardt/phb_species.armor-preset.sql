-- Manikin: fórmulas de CA por armorPresetId.

INSERT INTO rpg.phb_species_armor_preset (
  species_id, preset_slug, label, base_ac,
  ability_a_slug, ability_a_cap, ability_b_slug, ability_b_cap,
  pick_mode, counts_as_worn_armor
)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'infiltrator',
    'Manikin (Infiltrador)',
    11,
    'destreza', NULL, NULL, NULL,
    'single', FALSE
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'sentinel',
    'Manikin (Sentinela)',
    13,
    'destreza', 2, 'forca', 3,
    'max_of', TRUE
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'manikin'),
    'tormentor',
    'Manikin (Tormentador)',
    16,
    'forca', 2, NULL, NULL,
    'single', TRUE
  )
ON CONFLICT (species_id, preset_slug) DO UPDATE SET
  label = EXCLUDED.label,
  base_ac = EXCLUDED.base_ac,
  ability_a_slug = EXCLUDED.ability_a_slug,
  ability_a_cap = EXCLUDED.ability_a_cap,
  ability_b_slug = EXCLUDED.ability_b_slug,
  ability_b_cap = EXCLUDED.ability_b_cap,
  pick_mode = EXCLUDED.pick_mode,
  counts_as_worn_armor = EXCLUDED.counts_as_worn_armor;
