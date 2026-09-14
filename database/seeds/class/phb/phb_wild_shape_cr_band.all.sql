-- Forma Selvagem base: CR máx. + fly por nível (PHB 2024).

INSERT INTO rpg.phb_wild_shape_cr_band (min_level, cr_max, allow_fly) VALUES
  (2, '1/4', false),
  (4, '1/2', false),
  (8, '1', true)
ON CONFLICT (min_level) DO UPDATE SET
  cr_max = EXCLUDED.cr_max,
  allow_fly = EXCLUDED.allow_fly;
