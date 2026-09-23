-- Magias inatas de template (criatura; veículo reservado) — GEN-6.

CREATE TABLE rpg.phb_stat_block_spell (
  id BIGSERIAL PRIMARY KEY,
  creature_template_slug TEXT REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  vehicle_template_slug TEXT REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  usage_kind rpg.innate_spell_usage NOT NULL,
  uses_per_day INT CHECK (uses_per_day IS NULL OR uses_per_day >= 1),
  slot_level INT CHECK (slot_level IS NULL OR slot_level BETWEEN 0 AND 9),
  recharge_dice TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  owner_kind rpg.stat_block_owner GENERATED ALWAYS AS (
    CASE
      WHEN creature_template_slug IS NOT NULL THEN 'creature'::rpg.stat_block_owner
      ELSE 'vehicle'::rpg.stat_block_owner
    END
  ) STORED,
  template_slug TEXT GENERATED ALWAYS AS (
    COALESCE(creature_template_slug, vehicle_template_slug)
  ) STORED,
  CONSTRAINT phb_stat_block_spell_owner CHECK (
    (creature_template_slug IS NOT NULL AND vehicle_template_slug IS NULL)
    OR (vehicle_template_slug IS NOT NULL AND creature_template_slug IS NULL)
  ),
  UNIQUE (owner_kind, template_slug, spell_slug, usage_kind, slot_level)
);

CREATE INDEX idx_phb_stat_block_spell_creature
  ON rpg.phb_stat_block_spell (creature_template_slug)
  WHERE creature_template_slug IS NOT NULL;
