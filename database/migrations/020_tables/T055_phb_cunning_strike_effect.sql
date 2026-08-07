-- Cunning Strike effects (Rogue) catalog

CREATE TABLE rpg.phb_cunning_strike_effect (
  id              BIGSERIAL PRIMARY KEY,
  slug            TEXT UNIQUE NOT NULL,
  name            TEXT NOT NULL,
  cost            INT NOT NULL CHECK (cost >= 1),
  unlock_level    INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  save_ability    rpg.save_ability NULL,
  subclass_id     BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  note            TEXT NOT NULL
);

CREATE INDEX idx_cunning_strike_effect_slug ON rpg.phb_cunning_strike_effect(slug);
CREATE INDEX idx_cunning_strike_effect_subclass ON rpg.phb_cunning_strike_effect(subclass_id);
