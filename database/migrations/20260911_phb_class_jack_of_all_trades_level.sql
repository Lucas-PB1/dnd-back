-- Forward: jack_of_all_trades_level em phb_class

ALTER TABLE rpg.phb_class
  ADD COLUMN IF NOT EXISTS jack_of_all_trades_level INTEGER
  CHECK (
    jack_of_all_trades_level IS NULL OR jack_of_all_trades_level >= 1
  );

UPDATE rpg.phb_class
SET jack_of_all_trades_level = 2
WHERE slug = 'bard'
  AND jack_of_all_trades_level IS NULL;
