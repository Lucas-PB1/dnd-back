-- Forward: asi_or_feat em phb_class_progression (SQL-first ASI / talento)

ALTER TABLE rpg.phb_class_progression
  ADD COLUMN IF NOT EXISTS asi_or_feat BOOLEAN NOT NULL DEFAULT false;

UPDATE rpg.phb_class_progression
SET asi_or_feat = true
WHERE level IN (4, 8, 12, 16, 19)
  AND asi_or_feat = false;

UPDATE rpg.phb_class_progression p
SET asi_or_feat = true
FROM rpg.phb_class c
WHERE p.class_id = c.id
  AND c.slug = 'fighter'
  AND p.level IN (6, 14)
  AND p.asi_or_feat = false;

UPDATE rpg.phb_class_progression p
SET asi_or_feat = true
FROM rpg.phb_class c
WHERE p.class_id = c.id
  AND c.slug = 'rogue'
  AND p.level = 10
  AND p.asi_or_feat = false;
