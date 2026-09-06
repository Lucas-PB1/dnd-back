CREATE TABLE rpg.game_actor_action (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0,
  description TEXT
);

CREATE INDEX idx_game_actor_action_actor_id ON rpg.game_actor_action(actor_id);
