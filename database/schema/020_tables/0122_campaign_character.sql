CREATE TABLE rpg.campaign_character (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  linked_by UUID NOT NULL,
  linked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (campaign_id, character_id)
);

CREATE INDEX idx_campaign_character_character_id ON rpg.campaign_character(character_id);
CREATE INDEX idx_campaign_character_campaign_id ON rpg.campaign_character(campaign_id);

-- Criticals: ownership FKs quando auth.users existir
