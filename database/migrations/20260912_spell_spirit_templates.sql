-- Spirit actors (Summon / Find Steed): escala por círculo do slot + mapa spell→variante.

ALTER TABLE rpg.phb_creature_template
  ADD COLUMN IF NOT EXISTS spirit_scale_min_slot INT
    CHECK (spirit_scale_min_slot IS NULL OR spirit_scale_min_slot BETWEEN 0 AND 20),
  ADD COLUMN IF NOT EXISTS spirit_ac_base INT
    CHECK (spirit_ac_base IS NULL OR spirit_ac_base BETWEEN 0 AND 40),
  ADD COLUMN IF NOT EXISTS spirit_ac_per_slot INT
    CHECK (spirit_ac_per_slot IS NULL OR spirit_ac_per_slot BETWEEN 0 AND 10),
  ADD COLUMN IF NOT EXISTS spirit_hp_base INT
    CHECK (spirit_hp_base IS NULL OR spirit_hp_base >= 0),
  ADD COLUMN IF NOT EXISTS spirit_hp_per_slot INT
    CHECK (spirit_hp_per_slot IS NULL OR spirit_hp_per_slot >= 0),
  ADD COLUMN IF NOT EXISTS spirit_hp_mode TEXT
    CHECK (spirit_hp_mode IS NULL OR spirit_hp_mode IN ('per_slot', 'above_min'));

COMMENT ON COLUMN rpg.phb_creature_template.spirit_ac_base IS
  'AC = spirit_ac_base + spirit_ac_per_slot × slot_level (Summon/Find Steed).';
COMMENT ON COLUMN rpg.phb_creature_template.spirit_hp_mode IS
  'per_slot: HP = base + per_slot × slot; above_min: HP = base + per_slot × (slot − min_slot).';

CREATE TABLE IF NOT EXISTS rpg.phb_spell_spirit (
  spell_slug TEXT PRIMARY KEY REFERENCES rpg.phb_spell(slug) ON DELETE CASCADE,
  actor_kind TEXT NOT NULL
    CHECK (actor_kind IN ('mount', 'companion')),
  replace_policy TEXT NOT NULL DEFAULT 'replace_same_spell'
    CHECK (replace_policy IN ('replace_same_spell')),
  fly_speed_min_slot INT
    CHECK (fly_speed_min_slot IS NULL OR fly_speed_min_slot BETWEEN 1 AND 20)
);

COMMENT ON TABLE rpg.phb_spell_spirit IS
  'Magias que spawnam spirit_actor / Find Steed (mapa para variantes tipadas).';
COMMENT ON COLUMN rpg.phb_spell_spirit.fly_speed_min_slot IS
  'Se preenchido, remove speed fly do actor quando slot_level < este valor (ex.: Steed = 4).';

CREATE TABLE IF NOT EXISTS rpg.phb_spell_spirit_variant (
  id BIGSERIAL PRIMARY KEY,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell_spirit(spell_slug) ON DELETE CASCADE,
  variant_key TEXT NOT NULL CHECK (char_length(variant_key) BETWEEN 1 AND 64),
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE RESTRICT,
  label TEXT NOT NULL CHECK (char_length(label) BETWEEN 1 AND 120),
  UNIQUE (spell_slug, variant_key)
);

CREATE INDEX IF NOT EXISTS idx_phb_spell_spirit_variant_template
  ON rpg.phb_spell_spirit_variant(template_slug);
