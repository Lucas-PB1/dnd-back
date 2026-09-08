CREATE TABLE rpg.campaign (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT,
  invite_code TEXT NOT NULL UNIQUE CHECK (char_length(invite_code) BETWEEN 6 AND 16),
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  allow_player_skip_payment BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_campaign_created_by ON rpg.campaign(created_by);
CREATE INDEX idx_campaign_invite_code ON rpg.campaign(invite_code);



-- Papéis na mesa: dm (mestre), player (jogador), assistant (auxiliar).
