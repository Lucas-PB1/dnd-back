-- Seed rpg.phb_character_level
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_character_level (level, proficiency_bonus, xp_threshold)
VALUES
  (1, 2, 0),
  (2, 2, 300),
  (3, 2, 900),
  (4, 2, 2700),
  (5, 3, 6500),
  (6, 3, 14000),
  (7, 3, 23000),
  (8, 3, 34000),
  (9, 4, 48000),
  (10, 4, 64000),
  (11, 4, 85000),
  (12, 4, 100000),
  (13, 5, 120000),
  (14, 5, 140000),
  (15, 5, 165000),
  (16, 5, 195000),
  (17, 6, 225000),
  (18, 6, 265000),
  (19, 6, 305000),
  (20, 6, 355000)
ON CONFLICT (level) DO UPDATE SET proficiency_bonus = EXCLUDED.proficiency_bonus, xp_threshold = EXCLUDED.xp_threshold;
