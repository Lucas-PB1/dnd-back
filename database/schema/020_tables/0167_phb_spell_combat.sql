CREATE TABLE rpg.phb_spell_combat (
  spell_slug TEXT PRIMARY KEY REFERENCES rpg.phb_spell(slug) ON DELETE CASCADE,
  resolution TEXT NOT NULL
    CHECK (resolution IN (
      'auto_damage',
      'spell_attack',
      'arena_darkness',
      'save_damage',
      'heal_combatant'
    )),
  label TEXT NOT NULL CHECK (char_length(label) BETWEEN 1 AND 120),
  damage_die INT
    CHECK (damage_die IS NULL OR damage_die IN (4, 6, 8, 10, 12, 20)),
  flat_per_die INT NOT NULL DEFAULT 0
    CHECK (flat_per_die BETWEEN 0 AND 20),
  auto_unit_base INT
    CHECK (auto_unit_base IS NULL OR auto_unit_base BETWEEN 1 AND 20),
  auto_unit_per_slot_above_base INT
    CHECK (
      auto_unit_per_slot_above_base IS NULL
      OR auto_unit_per_slot_above_base BETWEEN 0 AND 10
    ),
  dice_count_base INT
    CHECK (dice_count_base IS NULL OR dice_count_base BETWEEN 1 AND 40),
  dice_per_slot_above_base INT
    CHECK (
      dice_per_slot_above_base IS NULL
      OR dice_per_slot_above_base BETWEEN 0 AND 10
    ),
  spell_level INT NOT NULL DEFAULT 0
    CHECK (spell_level BETWEEN 0 AND 9),
  cantrip_scale BOOLEAN NOT NULL DEFAULT FALSE,
  per_die_attack BOOLEAN NOT NULL DEFAULT FALSE,
  include_spellcasting_mod BOOLEAN NOT NULL DEFAULT FALSE,
  save_success_outcome TEXT
    CHECK (
      save_success_outcome IS NULL
      OR save_success_outcome IN ('none', 'half', 'full')
    ),
  save_ability_slug TEXT,
  damage_type_slug TEXT
);

COMMENT ON TABLE rpg.phb_spell_combat IS
  'Resolução tipada de magia em combate (skirmish/duelo/encontro) — sem hardcode por slug.';
