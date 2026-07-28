-- Encontro: visibilidade para jogadores + combatentes criatura (manual)

ALTER TABLE rpg.campaign_encounter
  ADD COLUMN IF NOT EXISTS players_can_view BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS creature_hp_visibility TEXT NOT NULL DEFAULT 'percent'
    CHECK (creature_hp_visibility IN ('hidden', 'percent', 'exact'));

ALTER TABLE rpg.campaign_encounter_combatant
  ALTER COLUMN character_id DROP NOT NULL;

ALTER TABLE rpg.campaign_encounter_combatant
  DROP CONSTRAINT IF EXISTS campaign_encounter_combatant_encounter_id_character_id_key;

ALTER TABLE rpg.campaign_encounter_combatant
  ADD COLUMN IF NOT EXISTS kind TEXT NOT NULL DEFAULT 'pc'
    CHECK (kind IN ('pc', 'creature')),
  ADD COLUMN IF NOT EXISTS display_name TEXT,
  ADD COLUMN IF NOT EXISTS hp_current INT,
  ADD COLUMN IF NOT EXISTS hp_max INT,
  ADD COLUMN IF NOT EXISTS armor_class INT;

UPDATE rpg.campaign_encounter_combatant
SET kind = 'pc'
WHERE kind IS NULL OR kind = '';

ALTER TABLE rpg.campaign_encounter_combatant
  DROP CONSTRAINT IF EXISTS campaign_encounter_combatant_kind_check;

ALTER TABLE rpg.campaign_encounter_combatant
  ADD CONSTRAINT campaign_encounter_combatant_shape_check CHECK (
    (kind = 'pc' AND character_id IS NOT NULL)
    OR (kind = 'creature' AND display_name IS NOT NULL AND char_length(display_name) BETWEEN 1 AND 120)
  );

CREATE UNIQUE INDEX IF NOT EXISTS uq_encounter_pc_character
  ON rpg.campaign_encounter_combatant(encounter_id, character_id)
  WHERE character_id IS NOT NULL;
