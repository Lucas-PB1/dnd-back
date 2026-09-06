CREATE TABLE rpg.campaign_member (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('dm', 'player', 'assistant')),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (campaign_id, user_id)
);

CREATE INDEX idx_campaign_member_user_id ON rpg.campaign_member(user_id);
CREATE INDEX idx_campaign_member_campaign_id ON rpg.campaign_member(campaign_id);

-- Personagem do jogador vinculado Ã  campanha (N:N â€” vÃ¡rias campanhas).
