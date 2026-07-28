-- Encontro de campanha + combatentes (só PCs linkados). Sem monstros.

CREATE TABLE rpg.campaign_encounter (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  status TEXT NOT NULL DEFAULT 'active'
    CHECK (status IN ('active', 'closed')),
  round INT NOT NULL DEFAULT 1 CHECK (round >= 1),
  current_turn_index INT NOT NULL DEFAULT 0 CHECK (current_turn_index >= 0),
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_campaign_encounter_campaign_id
  ON rpg.campaign_encounter(campaign_id);

CREATE UNIQUE INDEX uq_campaign_one_active_encounter
  ON rpg.campaign_encounter(campaign_id)
  WHERE status = 'active';

CREATE TRIGGER tr_campaign_encounter_updated_at
  BEFORE UPDATE ON rpg.campaign_encounter
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TABLE rpg.campaign_encounter_combatant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  encounter_id UUID NOT NULL REFERENCES rpg.campaign_encounter(id) ON DELETE CASCADE,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  initiative_total INT,
  initiative_modifier INT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE (encounter_id, character_id)
);

CREATE INDEX idx_campaign_encounter_combatant_encounter_id
  ON rpg.campaign_encounter_combatant(encounter_id);
