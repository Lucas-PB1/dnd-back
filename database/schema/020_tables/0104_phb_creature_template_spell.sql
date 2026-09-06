CREATE TABLE rpg.phb_creature_template_spell (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  usage_kind rpg.innate_spell_usage NOT NULL,
  uses_per_day INT CHECK (uses_per_day IS NULL OR uses_per_day >= 1),
  slot_level INT CHECK (slot_level IS NULL OR slot_level BETWEEN 0 AND 9),
  recharge_dice TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (template_slug, spell_slug, usage_kind, slot_level)
);
