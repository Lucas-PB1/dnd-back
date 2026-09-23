CREATE TABLE rpg.campaign_member (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  role rpg.campaign_member_role NOT NULL,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (campaign_id, user_id)
);

CREATE INDEX idx_campaign_member_user_id ON rpg.campaign_member(user_id);
CREATE INDEX idx_campaign_member_campaign_id ON rpg.campaign_member(campaign_id);

-- Personagem do jogador vinculado à campanha (N:N — várias campanhas).
