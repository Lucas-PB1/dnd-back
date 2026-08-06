-- Gunslinger (Valdas) maneuvers catalog

CREATE TABLE rpg.phb_gunslinger_maneuver (
  id              BIGSERIAL PRIMARY KEY,
  slug            TEXT UNIQUE NOT NULL,
  name            TEXT NOT NULL,
  description     TEXT NOT NULL,
  effect_kind     rpg.maneuver_effect_kind NOT NULL,
  risk_cost       INT NOT NULL DEFAULT 1 CHECK (risk_cost >= 1),
  from_level      INT NOT NULL CHECK (from_level BETWEEN 1 AND 20),
  subclass_id     BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE
);

CREATE INDEX idx_gunslinger_maneuver_slug ON rpg.phb_gunslinger_maneuver(slug);
CREATE INDEX idx_gunslinger_maneuver_subclass ON rpg.phb_gunslinger_maneuver(subclass_id);
