-- Magia vinculada em item único (ex.: Cajado Magificado).
ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS bound_spell_slug TEXT NULL
  REFERENCES rpg.phb_spell(slug);
