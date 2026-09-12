-- Magias que spawnam espírito / montaria tipada (Summon / Find Steed).

CREATE TABLE rpg.phb_spell_spirit (
  spell_slug TEXT PRIMARY KEY REFERENCES rpg.phb_spell(slug) ON DELETE CASCADE,
  actor_kind TEXT NOT NULL
    CHECK (actor_kind IN ('mount', 'companion')),
  replace_policy TEXT NOT NULL DEFAULT 'replace_same_spell'
    CHECK (replace_policy IN ('replace_same_spell')),
  fly_speed_min_slot INT
    CHECK (fly_speed_min_slot IS NULL OR fly_speed_min_slot BETWEEN 1 AND 20)
);

CREATE TABLE rpg.phb_spell_spirit_variant (
  id BIGSERIAL PRIMARY KEY,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell_spirit(spell_slug) ON DELETE CASCADE,
  variant_key TEXT NOT NULL CHECK (char_length(variant_key) BETWEEN 1 AND 64),
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE RESTRICT,
  label TEXT NOT NULL CHECK (char_length(label) BETWEEN 1 AND 120),
  UNIQUE (spell_slug, variant_key)
);

CREATE INDEX idx_phb_spell_spirit_variant_template
  ON rpg.phb_spell_spirit_variant(template_slug);
