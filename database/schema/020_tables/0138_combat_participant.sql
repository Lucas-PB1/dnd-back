-- Participante de sessão de combate (GEN-8). `session_mode` espelha o modo da sessão
-- (FK composta) e serve de discriminador para as entities de cada modo.
-- Vitals de instância (≠ ficha) usados por encounter/duel.
CREATE TABLE rpg.combat_participant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID NOT NULL,
  session_mode rpg.combat_session_mode NOT NULL,
  kind rpg.combatant_kind NOT NULL DEFAULT 'pc',
  character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  user_id UUID,
  display_name TEXT CHECK (display_name IS NULL OR char_length(display_name) BETWEEN 1 AND 120),
  ready BOOLEAN NOT NULL DEFAULT FALSE,
  initiative_total INT,
  initiative_modifier INT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  hit_points_current INT CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  hit_points_max INT CHECK (hit_points_max IS NULL OR hit_points_max >= 1),
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0),
  conditions TEXT[] NOT NULL DEFAULT '{}',
  speed_penalty_m INT NOT NULL DEFAULT 0 CHECK (speed_penalty_m >= 0),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  FOREIGN KEY (session_id, session_mode)
    REFERENCES rpg.combat_session(id, mode) ON DELETE CASCADE,
  CONSTRAINT combat_participant_shape_check CHECK (
    (kind = 'pc'::rpg.combatant_kind AND character_id IS NOT NULL AND actor_id IS NULL)
    OR (kind = 'actor'::rpg.combatant_kind AND actor_id IS NOT NULL AND character_id IS NULL)
  ),
  CONSTRAINT combat_participant_hp_bounds CHECK (
    hit_points_current IS NULL
    OR hit_points_max IS NULL
    OR hit_points_current <= hit_points_max
  ),
  CONSTRAINT combat_participant_mode_shape CHECK (
    (session_mode <> 'duel' OR (user_id IS NOT NULL AND kind = 'pc'::rpg.combatant_kind))
    AND (session_mode <> 'skirmish' OR display_name IS NOT NULL)
  )
);

CREATE INDEX idx_combat_participant_session_id
  ON rpg.combat_participant(session_id);

CREATE INDEX idx_combat_participant_user_id
  ON rpg.combat_participant(user_id)
  WHERE user_id IS NOT NULL;

CREATE INDEX idx_combat_participant_actor_id
  ON rpg.combat_participant(actor_id)
  WHERE actor_id IS NOT NULL;

CREATE UNIQUE INDEX uq_combat_participant_character
  ON rpg.combat_participant(session_id, character_id)
  WHERE character_id IS NOT NULL;

CREATE UNIQUE INDEX uq_combat_participant_actor
  ON rpg.combat_participant(session_id, actor_id)
  WHERE actor_id IS NOT NULL;

CREATE UNIQUE INDEX uq_combat_participant_duel_user
  ON rpg.combat_participant(session_id, user_id)
  WHERE session_mode = 'duel';

ALTER TABLE rpg.combat_session
  ADD CONSTRAINT combat_session_current_participant_fk
  FOREIGN KEY (current_participant_id)
  REFERENCES rpg.combat_participant(id)
  ON DELETE SET NULL;
