-- Anotações livres da sessão (ficha do personagem)
ALTER TABLE rpg.player_character
  ADD COLUMN IF NOT EXISTS session_notes TEXT NOT NULL DEFAULT '';

COMMENT ON COLUMN rpg.player_character.session_notes IS
  'Anotações da sessão (jogador/DM) — texto livre, não confundir com game_actor.notes';
