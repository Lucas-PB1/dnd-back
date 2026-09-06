CREATE TABLE rpg.campaign_encounter_combatant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  encounter_id UUID NOT NULL REFERENCES rpg.campaign_encounter(id) ON DELETE CASCADE,
  kind TEXT NOT NULL DEFAULT 'pc',
  character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  initiative_total INT,
  initiative_modifier INT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT campaign_encounter_combatant_kind_check CHECK (kind IN ('pc', 'actor')),
  CONSTRAINT campaign_encounter_combatant_shape_check CHECK (
    (kind = 'pc' AND character_id IS NOT NULL AND actor_id IS NULL)
    OR (kind = 'actor' AND actor_id IS NOT NULL AND character_id IS NULL)
  )
);

CREATE INDEX idx_campaign_encounter_combatant_encounter_id
  ON rpg.campaign_encounter_combatant(encounter_id);

CREATE UNIQUE INDEX uq_encounter_pc_character
  ON rpg.campaign_encounter_combatant(encounter_id, character_id)
  WHERE character_id IS NOT NULL;

CREATE UNIQUE INDEX uq_encounter_actor
  ON rpg.campaign_encounter_combatant(encounter_id, actor_id)
  WHERE actor_id IS NOT NULL;

CREATE INDEX idx_campaign_encounter_combatant_actor_id
  ON rpg.campaign_encounter_combatant(actor_id)
  WHERE actor_id IS NOT NULL;
