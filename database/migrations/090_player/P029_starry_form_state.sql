-- Forma Estrelada (Círculo das Estrelas): constelação ativa na sessão
ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS starry_form_active BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS stellar_constellation TEXT NULL;
