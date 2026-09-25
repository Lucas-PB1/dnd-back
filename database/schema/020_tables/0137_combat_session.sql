-- Sessão de combate única (GEN-8): encontro de campanha | duelo PvP | escaramuça solo.
-- Colunas específicas de modo ficam NULL/default nos outros modos; CHECKs garantem o shape.
CREATE TABLE rpg.combat_session (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mode rpg.combat_session_mode NOT NULL,
  status TEXT NOT NULL DEFAULT 'active',
  created_by UUID NOT NULL,
  round INT NOT NULL DEFAULT 1 CHECK (round >= 1),
  -- encounter
  campaign_id UUID REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  name TEXT CHECK (name IS NULL OR char_length(name) BETWEEN 1 AND 120),
  current_turn_index INT NOT NULL DEFAULT 0 CHECK (current_turn_index >= 0),
  players_can_view BOOLEAN NOT NULL DEFAULT FALSE,
  creature_hp_visibility TEXT NOT NULL DEFAULT 'percent'
    CHECK (creature_hp_visibility IN ('hidden', 'percent', 'exact')),
  -- duel
  invite_code TEXT CHECK (invite_code IS NULL OR char_length(invite_code) BETWEEN 6 AND 16),
  turn_character_id UUID REFERENCES rpg.player_character(id) ON DELETE SET NULL,
  winner_user_id UUID,
  winner_character_id UUID REFERENCES rpg.player_character(id) ON DELETE SET NULL,
  -- skirmish
  character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  current_participant_id UUID,
  pc_reaction_available BOOLEAN NOT NULL DEFAULT TRUE,
  pc_oa_available BOOLEAN NOT NULL DEFAULT FALSE,
  pc_savage_attacker_used BOOLEAN NOT NULL DEFAULT FALSE,
  winner_kind rpg.combatant_kind,
  -- duel + skirmish
  turn_attacks_remaining INT CHECK (turn_attacks_remaining IS NULL OR turn_attacks_remaining >= 0),
  combat_log JSONB NOT NULL DEFAULT '[]'::jsonb,
  arena_effects TEXT[] NOT NULL DEFAULT '{}',
  arena_effect_source_character_id UUID REFERENCES rpg.player_character(id) ON DELETE SET NULL,
  end_reason TEXT CHECK (end_reason IS NULL OR end_reason IN ('hp', 'forfeit', 'cancel')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (id, mode),
  CONSTRAINT combat_session_status_by_mode CHECK (
    (mode = 'encounter' AND status IN ('active', 'closed'))
    OR (mode = 'duel' AND status IN ('open', 'ready', 'active', 'finished', 'cancelled'))
    OR (mode = 'skirmish' AND status IN ('active', 'finished'))
  ),
  CONSTRAINT combat_session_shape_by_mode CHECK (
    (mode = 'encounter' AND campaign_id IS NOT NULL AND name IS NOT NULL)
    OR (mode = 'duel' AND invite_code IS NOT NULL)
    OR (mode = 'skirmish' AND character_id IS NOT NULL)
  )
);

CREATE INDEX idx_combat_session_created_by ON rpg.combat_session(created_by);
CREATE INDEX idx_combat_session_mode_status ON rpg.combat_session(mode, status);

CREATE INDEX idx_combat_session_campaign_id
  ON rpg.combat_session(campaign_id)
  WHERE campaign_id IS NOT NULL;

CREATE INDEX idx_combat_session_character_id
  ON rpg.combat_session(character_id)
  WHERE character_id IS NOT NULL;

CREATE UNIQUE INDEX uq_combat_session_invite_code
  ON rpg.combat_session(invite_code)
  WHERE invite_code IS NOT NULL;

CREATE UNIQUE INDEX uq_combat_session_one_active_encounter
  ON rpg.combat_session(campaign_id)
  WHERE mode = 'encounter' AND status = 'active';

CREATE UNIQUE INDEX uq_combat_session_one_active_skirmish
  ON rpg.combat_session(created_by)
  WHERE mode = 'skirmish' AND status = 'active';
