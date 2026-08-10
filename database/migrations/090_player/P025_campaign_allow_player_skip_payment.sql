-- Campanha: players podem optar por não pagar ao pegar item
ALTER TABLE rpg.campaign
  ADD COLUMN IF NOT EXISTS allow_player_skip_payment BOOLEAN NOT NULL DEFAULT FALSE;
