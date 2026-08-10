-- Overlay DMG §3.1: cobertura presa à peça base (estilo Valdas charm).
ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS attached_coverage_slug TEXT NULL;

ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS attached_coverage_bonus SMALLINT NULL;

ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS attached_coverage_attuned BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE rpg.player_character_item
  DROP CONSTRAINT IF EXISTS player_character_item_attached_coverage_bonus_check;

ALTER TABLE rpg.player_character_item
  ADD CONSTRAINT player_character_item_attached_coverage_bonus_check
  CHECK (
    attached_coverage_bonus IS NULL
    OR attached_coverage_bonus IN (1, 2, 3)
  );

ALTER TABLE rpg.player_character_item
  DROP CONSTRAINT IF EXISTS player_character_item_attached_coverage_pair_check;

ALTER TABLE rpg.player_character_item
  ADD CONSTRAINT player_character_item_attached_coverage_pair_check
  CHECK (
    (attached_coverage_slug IS NULL AND attached_coverage_bonus IS NULL AND attached_coverage_attuned = FALSE)
    OR (attached_coverage_slug IS NOT NULL)
  );
