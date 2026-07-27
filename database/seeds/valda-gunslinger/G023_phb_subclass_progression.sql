-- Seed: Spellslinger cantrips + prepared quotas (Gunslinger levels 3–20)

DELETE FROM rpg.phb_subclass_progression
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger');

INSERT INTO rpg.phb_subclass_progression (subclass_id, level, cantrips, prepared_spells)
SELECT sc.id, v.level, v.cantrips, v.prepared
FROM rpg.phb_subclass sc
CROSS JOIN (VALUES
  (3, 2, 3),
  (4, 2, 4),
  (5, 2, 4),
  (6, 2, 4),
  (7, 2, 5),
  (8, 2, 6),
  (9, 2, 6),
  (10, 3, 7),
  (11, 3, 8),
  (12, 3, 8),
  (13, 3, 9),
  (14, 3, 10),
  (15, 3, 10),
  (16, 3, 11),
  (17, 3, 11),
  (18, 3, 11),
  (19, 3, 12),
  (20, 3, 13)
) AS v(level, cantrips, prepared)
WHERE sc.slug = 'spellslinger';
