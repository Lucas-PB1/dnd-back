-- Circunstâncias de mesa (snow_ice | in_water | extreme_cold) na ficha.
ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS mesa_circumstances TEXT[] NOT NULL DEFAULT '{}';
