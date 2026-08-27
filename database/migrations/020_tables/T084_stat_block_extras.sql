-- Stat blocks completos: atributos, descrição de ações, veículos Northlands

ALTER TABLE rpg.phb_creature_template
  ADD COLUMN IF NOT EXISTS subtitle TEXT,
  ADD COLUMN IF NOT EXISTS alignment TEXT,
  ADD COLUMN IF NOT EXISTS initiative_modifier INT,
  ADD COLUMN IF NOT EXISTS ability_scores JSONB;

ALTER TABLE rpg.phb_creature_template_action
  ADD COLUMN IF NOT EXISTS description TEXT;

ALTER TABLE rpg.phb_vehicle_template
  ADD COLUMN IF NOT EXISTS subtitle TEXT,
  ADD COLUMN IF NOT EXISTS passenger_capacity INT CHECK (passenger_capacity IS NULL OR passenger_capacity >= 0),
  ADD COLUMN IF NOT EXISTS initiative_modifier INT,
  ADD COLUMN IF NOT EXISTS ability_scores JSONB,
  ADD COLUMN IF NOT EXISTS cargo_capacity_label TEXT;

ALTER TABLE rpg.phb_vehicle_template_action
  ADD COLUMN IF NOT EXISTS description TEXT;

CREATE TABLE IF NOT EXISTS rpg.phb_vehicle_template_trait (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_phb_vehicle_template_trait_slug
  ON rpg.phb_vehicle_template_trait(template_slug);

ALTER TABLE rpg.game_actor
  ADD COLUMN IF NOT EXISTS passenger_capacity INT CHECK (passenger_capacity IS NULL OR passenger_capacity >= 0);

ALTER TABLE rpg.game_actor_action
  ADD COLUMN IF NOT EXISTS description TEXT;
