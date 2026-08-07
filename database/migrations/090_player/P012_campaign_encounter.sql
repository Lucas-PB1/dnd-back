-- Encontro de campanha + combatentes (PCs + criaturas manuais)

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

CREATE TRIGGER tr_campaign_encounter_updated_at
  BEFORE UPDATE ON rpg.campaign_encounter
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TABLE rpg.campaign_encounter_combatant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  encounter_id UUID NOT NULL REFERENCES rpg.campaign_encounter(id) ON DELETE CASCADE,
  kind TEXT NOT NULL DEFAULT 'pc' CHECK (kind IN ('pc', 'creature')),
  character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  display_name TEXT,
  hp_current INT,
  hp_max INT,
  armor_class INT,
  initiative_total INT,
  initiative_modifier INT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT campaign_encounter_combatant_shape_check CHECK (
    (kind = 'pc' AND character_id IS NOT NULL)
    OR (kind = 'creature' AND display_name IS NOT NULL AND char_length(display_name) BETWEEN 1 AND 120)
  )
);

CREATE INDEX idx_campaign_encounter_combatant_encounter_id
  ON rpg.campaign_encounter_combatant(encounter_id);

CREATE UNIQUE INDEX uq_encounter_pc_character
  ON rpg.campaign_encounter_combatant(encounter_id, character_id)
  WHERE character_id IS NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign_encounter.created_by FK — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.campaign_encounter
    ADD CONSTRAINT campaign_encounter_created_by_fkey
    FOREIGN KEY (created_by) REFERENCES auth.users(id);
END $$;
