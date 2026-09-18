CREATE TABLE rpg.skirmish (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'finished')),
  round INT NOT NULL DEFAULT 1 CHECK (round >= 1),
  turn_attacks_remaining INT CHECK (turn_attacks_remaining IS NULL OR turn_attacks_remaining >= 0),
  current_combatant_id UUID,
  combat_log JSONB NOT NULL DEFAULT '[]'::jsonb,
  arena_effects TEXT[] NOT NULL DEFAULT '{}',
  arena_effect_source_character_id UUID
    REFERENCES rpg.player_character(id) ON DELETE SET NULL,
  pc_reaction_available BOOLEAN NOT NULL DEFAULT TRUE,
  pc_oa_available BOOLEAN NOT NULL DEFAULT FALSE,
  pc_savage_attacker_used BOOLEAN NOT NULL DEFAULT FALSE,
  winner_kind TEXT CHECK (winner_kind IS NULL OR winner_kind IN ('pc', 'actor')),
  end_reason TEXT CHECK (end_reason IS NULL OR end_reason IN ('hp', 'forfeit')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_skirmish_user_id ON rpg.skirmish(user_id);
CREATE INDEX idx_skirmish_character_id ON rpg.skirmish(character_id);
CREATE UNIQUE INDEX uq_skirmish_one_active_per_user
  ON rpg.skirmish(user_id)
  WHERE status = 'active';

CREATE TABLE rpg.skirmish_combatant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  skirmish_id UUID NOT NULL REFERENCES rpg.skirmish(id) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK (kind IN ('pc', 'actor')),
  character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL CHECK (char_length(display_name) BETWEEN 1 AND 120),
  initiative_total INT,
  initiative_modifier INT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT skirmish_combatant_shape_check CHECK (
    (kind = 'pc' AND character_id IS NOT NULL AND actor_id IS NULL)
    OR (kind = 'actor' AND actor_id IS NOT NULL AND character_id IS NULL)
  )
);

CREATE INDEX idx_skirmish_combatant_skirmish_id
  ON rpg.skirmish_combatant(skirmish_id);

CREATE UNIQUE INDEX uq_skirmish_pc
  ON rpg.skirmish_combatant(skirmish_id, character_id)
  WHERE character_id IS NOT NULL;

CREATE UNIQUE INDEX uq_skirmish_actor
  ON rpg.skirmish_combatant(skirmish_id, actor_id)
  WHERE actor_id IS NOT NULL;

ALTER TABLE rpg.skirmish
  ADD CONSTRAINT skirmish_current_combatant_fk
  FOREIGN KEY (current_combatant_id)
  REFERENCES rpg.skirmish_combatant(id)
  ON DELETE SET NULL;
