CREATE TABLE rpg.phb_vehicle_template_speed (
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (template_slug, movement_kind)
);
