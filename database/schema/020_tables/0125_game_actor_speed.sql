CREATE TABLE rpg.game_actor_speed (
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (actor_id, movement_kind)
);
