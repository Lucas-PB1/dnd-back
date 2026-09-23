-- Traços de template (criatura | veículo) — GEN-6.

CREATE TABLE rpg.phb_stat_block_trait (
  id BIGSERIAL PRIMARY KEY,
  creature_template_slug TEXT REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  vehicle_template_slug TEXT REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
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
  CONSTRAINT phb_stat_block_trait_owner CHECK (
    (creature_template_slug IS NOT NULL AND vehicle_template_slug IS NULL)
    OR (vehicle_template_slug IS NOT NULL AND creature_template_slug IS NULL)
  )
);

CREATE INDEX idx_phb_stat_block_trait_creature
  ON rpg.phb_stat_block_trait (creature_template_slug)
  WHERE creature_template_slug IS NOT NULL;

CREATE INDEX idx_phb_stat_block_trait_vehicle
  ON rpg.phb_stat_block_trait (vehicle_template_slug)
  WHERE vehicle_template_slug IS NOT NULL;
