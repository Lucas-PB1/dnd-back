-- Níveis em que a classe ganha ASI / talento (PHB 2024 + extras Guerreiro/Ladino).

UPDATE rpg.phb_class_progression
SET asi_or_feat = true
WHERE level IN (4, 8, 12, 16, 19);

UPDATE rpg.phb_class_progression p
SET asi_or_feat = true
FROM rpg.phb_class c
WHERE p.class_id = c.id
  AND c.slug = 'fighter'
  AND p.level IN (6, 14);

UPDATE rpg.phb_class_progression p
SET asi_or_feat = true
FROM rpg.phb_class c
WHERE p.class_id = c.id
  AND c.slug = 'rogue'
  AND p.level = 10;
