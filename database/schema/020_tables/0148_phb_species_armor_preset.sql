-- Presets de CA por espécie (ex.: Manikin armorPresetId).

CREATE TABLE rpg.phb_species_armor_preset (
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
