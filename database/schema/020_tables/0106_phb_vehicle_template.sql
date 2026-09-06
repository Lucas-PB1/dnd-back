CREATE TABLE rpg.phb_vehicle_template (
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  armor_class INT,
  hit_points INT CHECK (hit_points IS NULL OR hit_points >= 0),
  damage_threshold INT CHECK (damage_threshold IS NULL OR damage_threshold >= 0),
  crew_capacity INT CHECK (crew_capacity IS NULL OR crew_capacity >= 0),
  cargo_capacity_lb INT CHECK (cargo_capacity_lb IS NULL OR cargo_capacity_lb >= 0),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  subtitle TEXT,
  passenger_capacity INT CHECK (passenger_capacity IS NULL OR passenger_capacity >= 0),
  initiative_modifier INT,
  ability_scores JSONB,
  cargo_capacity_label TEXT,
  image_url TEXT
);
