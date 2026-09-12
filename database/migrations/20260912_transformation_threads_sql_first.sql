-- Cap.6 formulas + heritage combat notes + thread bracket/spend notes + Cap.6 boon notes.

ALTER TYPE rpg.resource_max_formula ADD VALUE IF NOT EXISTS 'proficiency_bonus_plus_stage';
ALTER TYPE rpg.resource_max_formula ADD VALUE IF NOT EXISTS 'transformation_stage';

CREATE TABLE IF NOT EXISTS rpg.phb_heritage_combat_note (
  id BIGSERIAL PRIMARY KEY,
  trait_id BIGINT NOT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  min_trait_takes INTEGER NOT NULL DEFAULT 1 CHECK (min_trait_takes >= 1),
  note TEXT NOT NULL CHECK (length(trim(note)) > 0),
  UNIQUE (trait_id, min_trait_takes)
);

CREATE INDEX IF NOT EXISTS idx_phb_heritage_combat_note_trait
  ON rpg.phb_heritage_combat_note (trait_id);

COMMENT ON TABLE rpg.phb_heritage_combat_note IS
  'Notas de combate por traço de heritage (tier por min_trait_takes; {takes} = contagem).';

ALTER TABLE rpg.phb_character_thread_milestone_benefit
  ADD COLUMN IF NOT EXISTS bracket_max_kept INTEGER;
ALTER TABLE rpg.phb_character_thread_milestone_benefit
  ADD COLUMN IF NOT EXISTS bracket_roll_kinds TEXT[];
ALTER TABLE rpg.phb_character_thread_milestone_benefit
  ADD COLUMN IF NOT EXISTS bracket_trigger_note TEXT;
ALTER TABLE rpg.phb_character_thread_milestone_benefit
  ADD COLUMN IF NOT EXISTS spend_side_effect_note TEXT;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'phb_character_thread_milestone_benefit_bracket_max_kept_check'
  ) THEN
    ALTER TABLE rpg.phb_character_thread_milestone_benefit
      ADD CONSTRAINT phb_character_thread_milestone_benefit_bracket_max_kept_check
      CHECK (bracket_max_kept IS NULL OR bracket_max_kept >= 1);
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS rpg.phb_transformation_boon_combat_note (
  boon_id TEXT PRIMARY KEY CHECK (length(trim(boon_id)) > 0),
  name_pt TEXT NOT NULL CHECK (length(trim(name_pt)) > 0),
  economy TEXT[] NOT NULL DEFAULT '{}',
  note_pt TEXT
);

COMMENT ON TABLE rpg.phb_transformation_boon_combat_note IS
  'Notas de combate Cap.6 por boon_id (ficha / combat slice).';
