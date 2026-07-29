-- Câmara de armas de fogo por personagem (estado de sessão).
ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS firearm_chambers JSONB NOT NULL DEFAULT '{}'::jsonb;
