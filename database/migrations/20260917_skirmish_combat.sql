ALTER TABLE rpg.skirmish
  ADD COLUMN IF NOT EXISTS turn_attacks_remaining INT
  CHECK (turn_attacks_remaining IS NULL OR turn_attacks_remaining >= 0);
