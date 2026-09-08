-- Duelo 1v1 (PvP) — lobby + combate (turno / log / efeitos de arena).
CREATE TABLE rpg.duel (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  status TEXT NOT NULL DEFAULT 'open'
    CHECK (status IN ('open', 'ready', 'active', 'finished', 'cancelled')),
  invite_code TEXT NOT NULL UNIQUE CHECK (char_length(invite_code) BETWEEN 6 AND 16),
  created_by UUID NOT NULL,
  turn_character_id UUID REFERENCES rpg.player_character(id) ON DELETE SET NULL,
  round INT NOT NULL DEFAULT 1 CHECK (round >= 1),
  combat_log JSONB NOT NULL DEFAULT '[]'::jsonb,
  arena_effects TEXT[] NOT NULL DEFAULT '{}',
  arena_effect_source_character_id UUID REFERENCES rpg.player_character(id) ON DELETE SET NULL,
  winner_user_id UUID,
  winner_character_id UUID REFERENCES rpg.player_character(id) ON DELETE SET NULL,
  end_reason TEXT CHECK (
    end_reason IS NULL
    OR end_reason IN ('hp', 'forfeit', 'cancel')
  ),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_duel_created_by ON rpg.duel(created_by);
CREATE INDEX idx_duel_invite_code ON rpg.duel(invite_code);
CREATE INDEX idx_duel_status ON rpg.duel(status);
