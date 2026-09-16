CREATE TABLE rpg.game_actor_state (
  actor_id UUID PRIMARY KEY REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  conditions TEXT[] NOT NULL DEFAULT '{}',
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0),
  concentrating_on TEXT,
  innate_spell_uses JSONB NOT NULL DEFAULT '{}'::jsonb,
  crew_current INT NOT NULL DEFAULT 0 CHECK (crew_current >= 0),
  passenger_current INT NOT NULL DEFAULT 0 CHECK (passenger_current >= 0),
  cargo_current_lb INT NOT NULL DEFAULT 0 CHECK (cargo_current_lb >= 0),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
