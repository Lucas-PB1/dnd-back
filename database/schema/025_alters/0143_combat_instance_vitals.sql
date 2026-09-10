-- Alter incremental (DBs já provisionados): vitals de instância no duelo/encontro.
ALTER TABLE rpg.duel_member
  ADD COLUMN IF NOT EXISTS hit_points_current INT NULL
    CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  ADD COLUMN IF NOT EXISTS hit_points_max INT NULL
    CHECK (hit_points_max IS NULL OR hit_points_max >= 1),
  ADD COLUMN IF NOT EXISTS temp_hp INT NOT NULL DEFAULT 0
    CHECK (temp_hp >= 0),
  ADD COLUMN IF NOT EXISTS conditions TEXT[] NOT NULL DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS speed_penalty_m INT NOT NULL DEFAULT 0
    CHECK (speed_penalty_m >= 0);

ALTER TABLE rpg.duel
  ADD COLUMN IF NOT EXISTS turn_attacks_remaining INT NULL
    CHECK (turn_attacks_remaining IS NULL OR turn_attacks_remaining >= 0);

ALTER TABLE rpg.campaign_encounter_combatant
  ADD COLUMN IF NOT EXISTS hit_points_current INT NULL
    CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  ADD COLUMN IF NOT EXISTS hit_points_max INT NULL
    CHECK (hit_points_max IS NULL OR hit_points_max >= 1),
  ADD COLUMN IF NOT EXISTS temp_hp INT NOT NULL DEFAULT 0
    CHECK (temp_hp >= 0),
  ADD COLUMN IF NOT EXISTS conditions TEXT[] NOT NULL DEFAULT '{}';
