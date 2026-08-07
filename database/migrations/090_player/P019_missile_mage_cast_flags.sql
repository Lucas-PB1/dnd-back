-- Trackers de sessão: Mago dos Mísseis (Escudo / Giga armados para o próximo cast).
ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS missile_shield_armed BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS giga_missile_armed BOOLEAN NOT NULL DEFAULT false;
