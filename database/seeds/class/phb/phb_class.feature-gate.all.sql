-- Gates booleanos de nível por classe (PHB 2024).

INSERT INTO rpg.phb_class_feature_gate (class_id, gate_key, unlock_level)
SELECT c.id, v.gate_key, v.unlock_level
FROM rpg.phb_class c
JOIN (
  VALUES
    ('fighter', 'studied_attacks', 13),
    ('fighter', 'tactical_master', 9),
    ('fighter', 'tactical_shift', 5),
    ('fighter', 'tactical_mind', 2),
    ('fighter', 'indomitable', 9),
    ('rogue', 'slippery_mind', 15),
    ('rogue', 'evasion', 7),
    ('monk', 'evasion', 7),
    ('monk', 'diamond_soul', 14),
    ('paladin', 'aura_of_protection', 6),
    ('ranger', 'precise_hunter', 17),
    ('ranger', 'relentless_hunter', 13)
) AS v(class_slug, gate_key, unlock_level)
  ON c.slug = v.class_slug
ON CONFLICT (class_id, gate_key) DO UPDATE SET
  unlock_level = EXCLUDED.unlock_level;
