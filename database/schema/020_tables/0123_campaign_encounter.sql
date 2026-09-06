CREATE TABLE rpg.campaign_encounter (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'closed')),
  round INT NOT NULL DEFAULT 1 CHECK (round >= 1),
  current_turn_index INT NOT NULL DEFAULT 0 CHECK (current_turn_index >= 0),
  players_can_view BOOLEAN NOT NULL DEFAULT FALSE,
  creature_hp_visibility TEXT NOT NULL DEFAULT 'percent' CHECK (creature_hp_visibility IN ('hidden', 'percent', 'exact')),
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_campaign_encounter_campaign_id
  ON rpg.campaign_encounter(campaign_id);

CREATE UNIQUE INDEX uq_campaign_one_active_encounter
  ON rpg.campaign_encounter(campaign_id)
  WHERE status = 'active';




-- Runtime: fichas de mesa alÃ©m do personagem jogador (criatura, montaria, veÃ­culo, companion)
