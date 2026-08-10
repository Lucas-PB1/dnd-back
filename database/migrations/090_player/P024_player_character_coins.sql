-- Wealth: 5 moedas D&D no personagem (PC / PP prata / PE / PO / PL platina)
ALTER TABLE rpg.player_character
  ADD COLUMN IF NOT EXISTS coin_copper INTEGER NOT NULL DEFAULT 0
    CHECK (coin_copper >= 0),
  ADD COLUMN IF NOT EXISTS coin_silver INTEGER NOT NULL DEFAULT 0
    CHECK (coin_silver >= 0),
  ADD COLUMN IF NOT EXISTS coin_electrum INTEGER NOT NULL DEFAULT 0
    CHECK (coin_electrum >= 0),
  ADD COLUMN IF NOT EXISTS coin_gold INTEGER NOT NULL DEFAULT 0
    CHECK (coin_gold >= 0),
  ADD COLUMN IF NOT EXISTS coin_platinum INTEGER NOT NULL DEFAULT 0
    CHECK (coin_platinum >= 0);
