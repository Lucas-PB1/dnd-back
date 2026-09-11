-- Forward: fighting_style_unlock_level em phb_class (SQL-first Estilo de Luta)

ALTER TABLE rpg.phb_class
  ADD COLUMN IF NOT EXISTS fighting_style_unlock_level INTEGER
  CHECK (
    fighting_style_unlock_level IS NULL OR fighting_style_unlock_level >= 1
  );

UPDATE rpg.phb_class
SET fighting_style_unlock_level = 1
WHERE slug IN ('fighter', 'gunslinger')
  AND fighting_style_unlock_level IS NULL;

UPDATE rpg.phb_class
SET fighting_style_unlock_level = 2
WHERE slug IN ('paladin', 'ranger', 'monster-hunter')
  AND fighting_style_unlock_level IS NULL;
