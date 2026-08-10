-- Arma Magificada: magia vinculada na cobertura anexada.
ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS attached_coverage_spell_slug TEXT NULL
  REFERENCES rpg.phb_spell(slug);

ALTER TABLE rpg.player_character_item
  DROP CONSTRAINT IF EXISTS player_character_item_attached_coverage_spell_pair_check;

ALTER TABLE rpg.player_character_item
  ADD CONSTRAINT player_character_item_attached_coverage_spell_pair_check
  CHECK (
    attached_coverage_spell_slug IS NULL
    OR attached_coverage_slug IS NOT NULL
  );
