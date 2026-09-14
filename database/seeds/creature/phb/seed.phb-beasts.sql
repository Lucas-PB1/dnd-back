-- PHB 2024 Appendix B — Creature Stat Blocks (Beasts only).
-- Extract: docs/source/extracts/phb/creature-stat-blocks-beasts.json
-- Alimenta Wild Shape (filtro CR × Beast) e reusa slugs do Find Familiar.

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores, image_url
) VALUES
(
  'alce', 'phb-2024-pt', 'Alce',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/4', 2, 10, 11, '2d10', 0,
  '{"forca":16,"destreza":10,"constituicao":11,"inteligencia":2,"sabedoria":10,"carisma":6}'::jsonb, NULL
),
(
  'aranha', 'phb-2024-pt', 'Aranha',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 12, 1, '1d4 − 1', 2,
  '{"forca":2,"destreza":14,"constituicao":8,"inteligencia":1,"sabedoria":10,"carisma":2}'::jsonb, '/catalog/beasts/aranha.png'
),
(
  'aranha-gigante', 'phb-2024-pt', 'Aranha Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1', 2, 14, 26, '4d10 + 4', 3,
  '{"forca":14,"destreza":16,"constituicao":12,"inteligencia":2,"sabedoria":11,"carisma":4}'::jsonb, '/catalog/beasts/aranha-gigante.png'
),
(
  'cabra', 'phb-2024-pt', 'Cabra',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '0', 2, 10, 4, '1d8', 0,
  '{"forca":11,"destreza":10,"constituicao":11,"inteligencia":2,"sabedoria":10,"carisma":5}'::jsonb, NULL
),
(
  'cabra-gigante', 'phb-2024-pt', 'Cabra Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/2', 2, 11, 19, '3d10 + 3', 1,
  '{"forca":17,"destreza":13,"constituicao":12,"inteligencia":3,"sabedoria":12,"carisma":6}'::jsonb, NULL
),
(
  'camelo', 'phb-2024-pt', 'Camelo',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/8', 2, 10, 17, '2d10 + 6', 0,
  '{"forca":15,"destreza":8,"constituicao":17,"inteligencia":2,"sabedoria":11,"carisma":5}'::jsonb, NULL
),
(
  'caranguejo', 'phb-2024-pt', 'Caranguejo',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 11, 3, '1d4 + 1', 0,
  '{"forca":6,"destreza":11,"constituicao":12,"inteligencia":1,"sabedoria":8,"carisma":2}'::jsonb, NULL
),
(
  'caranguejo-gigante', 'phb-2024-pt', 'Caranguejo Gigante',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/8', 2, 15, 13, '3d8', 1,
  '{"forca":13,"destreza":13,"constituicao":11,"inteligencia":1,"sabedoria":9,"carisma":3}'::jsonb, NULL
),
(
  'cavalo-de-guerra', 'phb-2024-pt', 'Cavalo de Guerra',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/2', 2, 11, 19, '3d10 + 3', 1,
  '{"forca":18,"destreza":12,"constituicao":13,"inteligencia":2,"sabedoria":12,"carisma":7}'::jsonb, NULL
),
(
  'cavalo-de-montaria', 'phb-2024-pt', 'Cavalo de Montaria',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/4', 2, 11, 13, '2d10 + 2', 1,
  '{"forca":16,"destreza":13,"constituicao":12,"inteligencia":2,"sabedoria":11,"carisma":7}'::jsonb, NULL
),
(
  'cavalo-de-tracao', 'phb-2024-pt', 'Cavalo de Tração',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/4', 2, 10, 15, '2d10 + 4', 0,
  '{"forca":18,"destreza":10,"constituicao":15,"inteligencia":2,"sabedoria":11,"carisma":7}'::jsonb, NULL
),
(
  'cavalo-marinho-gigante', 'phb-2024-pt', 'Cavalo-marinho Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/2', 2, 14, 16, '3d10', 1,
  '{"forca":15,"destreza":12,"constituicao":11,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, NULL
),
(
  'cobra-constritora', 'phb-2024-pt', 'Cobra Constritora',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/4', 2, 13, 13, '2d10 + 2', 2,
  '{"forca":15,"destreza":14,"constituicao":12,"inteligencia":1,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'cobra-venenosa', 'phb-2024-pt', 'Cobra Venenosa',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '1/8', 2, 12, 5, '2d4', 2,
  '{"forca":2,"destreza":15,"constituicao":11,"inteligencia":1,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'coruja', 'phb-2024-pt', 'Coruja',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 11, 1, '1d4 − 1', 1,
  '{"forca":3,"destreza":13,"constituicao":8,"inteligencia":2,"sabedoria":12,"carisma":7}'::jsonb, '/catalog/beasts/coruja.png'
),
(
  'corvo', 'phb-2024-pt', 'Corvo',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 12, 2, '1d4', 2,
  '{"forca":2,"destreza":14,"constituicao":10,"inteligencia":5,"sabedoria":13,"carisma":6}'::jsonb, '/catalog/beasts/corvo.png'
),
(
  'crocodilo', 'phb-2024-pt', 'Crocodilo',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1/2', 2, 12, 13, '2d10 + 2', 0,
  '{"forca":15,"destreza":10,"constituicao":13,"inteligencia":2,"sabedoria":10,"carisma":5}'::jsonb, '/catalog/beasts/crocodilo.png'
),
(
  'doninha', 'phb-2024-pt', 'Doninha',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 13, 1, '1d4 − 1', 3,
  '{"forca":3,"destreza":16,"constituicao":8,"inteligencia":2,"sabedoria":12,"carisma":3}'::jsonb, '/catalog/beasts/doninha.png'
),
(
  'doninha-gigante', 'phb-2024-pt', 'Doninha Gigante',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/8', 2, 13, 9, '2d8', 3,
  '{"forca":11,"destreza":17,"constituicao":10,"inteligencia":4,"sabedoria":12,"carisma":5}'::jsonb, NULL
),
(
  'elefante', 'phb-2024-pt', 'Elefante',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', 'huge',
  '4', 2, 12, 76, '8d12 + 24', 0,
  '{"forca":22,"destreza":9,"constituicao":17,"inteligencia":3,"sabedoria":11,"carisma":6}'::jsonb, NULL
),
(
  'escorpiao', 'phb-2024-pt', 'Escorpião',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 11, 1, '1d4 − 1', 0,
  '{"forca":2,"destreza":11,"constituicao":8,"inteligencia":1,"sabedoria":8,"carisma":2}'::jsonb, NULL
),
(
  'falcao', 'phb-2024-pt', 'Falcão',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 13, 1, '1d4 − 1', 3,
  '{"forca":5,"destreza":16,"constituicao":8,"inteligencia":2,"sabedoria":14,"carisma":6}'::jsonb, '/catalog/beasts/falcao.png'
),
(
  'gato', 'phb-2024-pt', 'Gato',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 12, 2, '1d4', 2,
  '{"forca":3,"destreza":15,"constituicao":10,"inteligencia":3,"sabedoria":12,"carisma":7}'::jsonb, '/catalog/beasts/gato.png'
),
(
  'javali', 'phb-2024-pt', 'Javali',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/4', 2, 11, 13, '2d8 + 4', 0,
  '{"forca":13,"destreza":11,"constituicao":14,"inteligencia":2,"sabedoria":9,"carisma":5}'::jsonb, NULL
),
(
  'lagarto', 'phb-2024-pt', 'Lagarto',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 10, 2, '1d4', 0,
  '{"forca":2,"destreza":11,"constituicao":10,"inteligencia":1,"sabedoria":8,"carisma":3}'::jsonb, NULL
),
(
  'leao', 'phb-2024-pt', 'Leão',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1', 2, 12, 22, '4d10', 2,
  '{"forca":17,"destreza":15,"constituicao":11,"inteligencia":3,"sabedoria":12,"carisma":8}'::jsonb, NULL
),
(
  'lobo', 'phb-2024-pt', 'Lobo',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/4', 2, 12, 11, '2d8 + 2', 2,
  '{"forca":14,"destreza":15,"constituicao":12,"inteligencia":3,"sabedoria":12,"carisma":6}'::jsonb, '/catalog/beasts/lobo.png'
),
(
  'lobo-terrivel', 'phb-2024-pt', 'Lobo Terrível',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1', 2, 14, 22, '3d10 + 6', 2,
  '{"forca":17,"destreza":15,"constituicao":15,"inteligencia":3,"sabedoria":12,"carisma":7}'::jsonb, NULL
),
(
  'macaco', 'phb-2024-pt', 'Macaco',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/2', 2, 12, 19, '3d8 + 6', 2,
  '{"forca":16,"destreza":14,"constituicao":14,"inteligencia":6,"sabedoria":12,"carisma":7}'::jsonb, NULL
),
(
  'mastim', 'phb-2024-pt', 'Mastim',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/8', 2, 12, 5, '1d8 + 1', 2,
  '{"forca":13,"destreza":14,"constituicao":12,"inteligencia":3,"sabedoria":12,"carisma":7}'::jsonb, '/catalog/beasts/mastim.png'
),
(
  'morcego', 'phb-2024-pt', 'Morcego',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 12, 1, '1d4 − 1', 2,
  '{"forca":2,"destreza":15,"constituicao":8,"inteligencia":2,"sabedoria":12,"carisma":4}'::jsonb, '/catalog/beasts/morcego.png'
),
(
  'mula', 'phb-2024-pt', 'Mula',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/8', 2, 10, 11, '2d8 + 2', 0,
  '{"forca":14,"destreza":10,"constituicao":13,"inteligencia":2,"sabedoria":10,"carisma":5}'::jsonb, NULL
),
(
  'pantera', 'phb-2024-pt', 'Pantera',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/4', 2, 13, 13, '3d8', 3,
  '{"forca":14,"destreza":16,"constituicao":10,"inteligencia":3,"sabedoria":14,"carisma":7}'::jsonb, NULL
),
(
  'polvo', 'phb-2024-pt', 'Polvo',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', 'small',
  '0', 2, 12, 3, '1d6', 2,
  '{"forca":4,"destreza":15,"constituicao":11,"inteligencia":3,"sabedoria":10,"carisma":4}'::jsonb, '/catalog/beasts/polvo.png'
),
(
  'ponei', 'phb-2024-pt', 'Pônei',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/8', 2, 10, 11, '2d8 + 2', 0,
  '{"forca":15,"destreza":10,"constituicao":13,"inteligencia":2,"sabedoria":11,"carisma":7}'::jsonb, NULL
),
(
  'rato', 'phb-2024-pt', 'Rato',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 10, 1, '1d4 − 1', 0,
  '{"forca":2,"destreza":11,"constituicao":9,"inteligencia":2,"sabedoria":10,"carisma":4}'::jsonb, NULL
),
(
  'sapo', 'phb-2024-pt', 'Sapo',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 11, 1, '1d4 − 1', 1,
  '{"forca":1,"destreza":13,"constituicao":8,"inteligencia":1,"sabedoria":8,"carisma":3}'::jsonb, '/catalog/beasts/sapo.png'
),
(
  'texugo', 'phb-2024-pt', 'Texugo',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', 'tiny',
  '0', 2, 11, 5, '1d4 + 3', 0,
  '{"forca":10,"destreza":11,"constituicao":16,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, NULL
),
(
  'texugo-gigante', 'phb-2024-pt', 'Texugo Gigante',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/4', 2, 13, 15, '2d8 + 6', 0,
  '{"forca":13,"destreza":10,"constituicao":17,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, '/catalog/beasts/texugo-gigante.png'
),
(
  'tigre', 'phb-2024-pt', 'Tigre',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1', 2, 13, 30, '4d10 + 8', 3,
  '{"forca":17,"destreza":16,"constituicao":14,"inteligencia":3,"sabedoria":12,"carisma":8}'::jsonb, NULL
),
(
  'tubarao-de-recife', 'phb-2024-pt', 'Tubarão de Recife',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/2', 2, 12, 22, '4d8 + 4', 2,
  '{"forca":14,"destreza":15,"constituicao":13,"inteligencia":1,"sabedoria":10,"carisma":4}'::jsonb, NULL
),
(
  'urso-negro', 'phb-2024-pt', 'Urso Negro',
  'Média Fera, Neutra', 'Neutra', 'Beast', 'medium',
  '1/2', 2, 11, 19, '3d8 + 6', 1,
  '{"forca":15,"destreza":12,"constituicao":14,"inteligencia":2,"sabedoria":12,"carisma":7}'::jsonb, NULL
),
(
  'urso-pardo', 'phb-2024-pt', 'Urso Pardo',
  'Grande Fera, Neutra', 'Neutra', 'Beast', 'large',
  '1', 2, 11, 22, '3d10 + 6', 1,
  '{"forca":17,"destreza":12,"constituicao":15,"inteligencia":2,"sabedoria":13,"carisma":7}'::jsonb, NULL
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores,
  image_url = COALESCE(EXCLUDED.image_url, rpg.phb_creature_template.image_url);

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('alce', 1, 10, 0, 11, 0, 'per_slot'),
  ('aranha', 1, 12, 0, 1, 0, 'per_slot'),
  ('aranha-gigante', 1, 14, 0, 26, 0, 'per_slot'),
  ('cabra', 1, 10, 0, 4, 0, 'per_slot'),
  ('cabra-gigante', 1, 11, 0, 19, 0, 'per_slot'),
  ('camelo', 1, 10, 0, 17, 0, 'per_slot'),
  ('caranguejo', 1, 11, 0, 3, 0, 'per_slot'),
  ('caranguejo-gigante', 1, 15, 0, 13, 0, 'per_slot'),
  ('cavalo-de-guerra', 1, 11, 0, 19, 0, 'per_slot'),
  ('cavalo-de-montaria', 1, 11, 0, 13, 0, 'per_slot'),
  ('cavalo-de-tracao', 1, 10, 0, 15, 0, 'per_slot'),
  ('cavalo-marinho-gigante', 1, 14, 0, 16, 0, 'per_slot'),
  ('cobra-constritora', 1, 13, 0, 13, 0, 'per_slot'),
  ('cobra-venenosa', 1, 12, 0, 5, 0, 'per_slot'),
  ('coruja', 1, 11, 0, 1, 0, 'per_slot'),
  ('corvo', 1, 12, 0, 2, 0, 'per_slot'),
  ('crocodilo', 1, 12, 0, 13, 0, 'per_slot'),
  ('doninha', 1, 13, 0, 1, 0, 'per_slot'),
  ('doninha-gigante', 1, 13, 0, 9, 0, 'per_slot'),
  ('elefante', 1, 12, 0, 76, 0, 'per_slot'),
  ('escorpiao', 1, 11, 0, 1, 0, 'per_slot'),
  ('falcao', 1, 13, 0, 1, 0, 'per_slot'),
  ('gato', 1, 12, 0, 2, 0, 'per_slot'),
  ('javali', 1, 11, 0, 13, 0, 'per_slot'),
  ('lagarto', 1, 10, 0, 2, 0, 'per_slot'),
  ('leao', 1, 12, 0, 22, 0, 'per_slot'),
  ('lobo', 1, 12, 0, 11, 0, 'per_slot'),
  ('lobo-terrivel', 1, 14, 0, 22, 0, 'per_slot'),
  ('macaco', 1, 12, 0, 19, 0, 'per_slot'),
  ('mastim', 1, 12, 0, 5, 0, 'per_slot'),
  ('morcego', 1, 12, 0, 1, 0, 'per_slot'),
  ('mula', 1, 10, 0, 11, 0, 'per_slot'),
  ('pantera', 1, 13, 0, 13, 0, 'per_slot'),
  ('polvo', 1, 12, 0, 3, 0, 'per_slot'),
  ('ponei', 1, 10, 0, 11, 0, 'per_slot'),
  ('rato', 1, 10, 0, 1, 0, 'per_slot'),
  ('sapo', 1, 11, 0, 1, 0, 'per_slot'),
  ('texugo', 1, 11, 0, 5, 0, 'per_slot'),
  ('texugo-gigante', 1, 13, 0, 15, 0, 'per_slot'),
  ('tigre', 1, 13, 0, 30, 0, 'per_slot'),
  ('tubarao-de-recife', 1, 12, 0, 22, 0, 'per_slot'),
  ('urso-negro', 1, 11, 0, 19, 0, 'per_slot'),
  ('urso-pardo', 1, 11, 0, 22, 0, 'per_slot')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug IN ('alce', 'aranha', 'aranha-gigante', 'cabra', 'cabra-gigante', 'camelo', 'caranguejo', 'caranguejo-gigante', 'cavalo-de-guerra', 'cavalo-de-montaria', 'cavalo-de-tracao', 'cavalo-marinho-gigante', 'cobra-constritora', 'cobra-venenosa', 'coruja', 'corvo', 'crocodilo', 'doninha', 'doninha-gigante', 'elefante', 'escorpiao', 'falcao', 'gato', 'javali', 'lagarto', 'leao', 'lobo', 'lobo-terrivel', 'macaco', 'mastim', 'morcego', 'mula', 'pantera', 'polvo', 'ponei', 'rato', 'sapo', 'texugo', 'texugo-gigante', 'tigre', 'tubarao-de-recife', 'urso-negro', 'urso-pardo');
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('alce', 'walk', 50),
  ('aranha', 'walk', 20),
  ('aranha', 'climb', 20),
  ('aranha-gigante', 'walk', 30),
  ('aranha-gigante', 'climb', 30),
  ('cabra', 'walk', 40),
  ('cabra', 'climb', 30),
  ('cabra-gigante', 'walk', 40),
  ('cabra-gigante', 'climb', 30),
  ('camelo', 'walk', 50),
  ('caranguejo', 'walk', 20),
  ('caranguejo', 'swim', 20),
  ('caranguejo-gigante', 'walk', 30),
  ('caranguejo-gigante', 'swim', 30),
  ('cavalo-de-guerra', 'walk', 60),
  ('cavalo-de-montaria', 'walk', 60),
  ('cavalo-de-tracao', 'walk', 40),
  ('cavalo-marinho-gigante', 'walk', 5),
  ('cavalo-marinho-gigante', 'swim', 40),
  ('cobra-constritora', 'walk', 30),
  ('cobra-constritora', 'swim', 30),
  ('cobra-venenosa', 'walk', 30),
  ('cobra-venenosa', 'swim', 30),
  ('coruja', 'walk', 5),
  ('coruja', 'fly', 60),
  ('corvo', 'walk', 10),
  ('corvo', 'fly', 50),
  ('crocodilo', 'walk', 20),
  ('crocodilo', 'swim', 30),
  ('doninha', 'walk', 30),
  ('doninha', 'climb', 30),
  ('doninha-gigante', 'walk', 40),
  ('doninha-gigante', 'climb', 30),
  ('elefante', 'walk', 40),
  ('escorpiao', 'walk', 10),
  ('falcao', 'walk', 10),
  ('falcao', 'fly', 60),
  ('gato', 'walk', 40),
  ('gato', 'climb', 40),
  ('javali', 'walk', 40),
  ('lagarto', 'walk', 20),
  ('lagarto', 'climb', 20),
  ('leao', 'walk', 50),
  ('lobo', 'walk', 40),
  ('lobo-terrivel', 'walk', 50),
  ('macaco', 'walk', 30),
  ('macaco', 'climb', 30),
  ('mastim', 'walk', 40),
  ('morcego', 'walk', 5),
  ('morcego', 'fly', 30),
  ('mula', 'walk', 40),
  ('pantera', 'walk', 50),
  ('pantera', 'climb', 40),
  ('polvo', 'walk', 5),
  ('polvo', 'swim', 30),
  ('ponei', 'walk', 40),
  ('rato', 'walk', 20),
  ('rato', 'climb', 20),
  ('sapo', 'walk', 20),
  ('sapo', 'swim', 20),
  ('texugo', 'walk', 20),
  ('texugo', 'burrow', 5),
  ('texugo-gigante', 'walk', 30),
  ('texugo-gigante', 'burrow', 10),
  ('tigre', 'walk', 40),
  ('tubarao-de-recife', 'walk', 5),
  ('tubarao-de-recife', 'swim', 30),
  ('urso-negro', 'walk', 30),
  ('urso-negro', 'swim', 30),
  ('urso-negro', 'climb', 30),
  ('urso-pardo', 'walk', 40),
  ('urso-pardo', 'climb', 30);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug IN ('alce', 'aranha', 'aranha-gigante', 'cabra', 'cabra-gigante', 'camelo', 'caranguejo', 'caranguejo-gigante', 'cavalo-de-guerra', 'cavalo-de-montaria', 'cavalo-de-tracao', 'cavalo-marinho-gigante', 'cobra-constritora', 'cobra-venenosa', 'coruja', 'corvo', 'crocodilo', 'doninha', 'doninha-gigante', 'elefante', 'escorpiao', 'falcao', 'gato', 'javali', 'lagarto', 'leao', 'lobo', 'lobo-terrivel', 'macaco', 'mastim', 'morcego', 'mula', 'pantera', 'polvo', 'ponei', 'rato', 'sapo', 'texugo', 'texugo-gigante', 'tigre', 'tubarao-de-recife', 'urso-negro', 'urso-pardo');
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('alce', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 12.', 0),
  ('aranha', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 10.', 0),
  ('aranha', 'Spider Climb', 'The spider can climb difficult surfaces, including along ceilings, without needing to make an ability check.', 1),
  ('aranha', 'Web Walker', 'The spider ignores movement restrictions caused by webs, and the spider knows the location of any other creature in contact with the same web.', 2),
  ('aranha-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 14.', 0),
  ('aranha-gigante', 'Spider Climb', 'The spider can climb difficult surfaces, including along ceilings, without needing to make an ability check.', 1),
  ('aranha-gigante', 'Web Walker', 'The spider ignores movement restrictions caused by webs, and it knows the location of any other creature in contact with the same web.', 2),
  ('cabra', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 12.', 0),
  ('cabra-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('camelo', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 10.', 0),
  ('caranguejo', 'Sentidos', 'Visão às Cegas 9 m. Percepção Passiva 9.', 0),
  ('caranguejo', 'Amphibious', 'The crab can breathe air and water.', 1),
  ('caranguejo-gigante', 'Sentidos', 'Visão às Cegas 9 m. Percepção Passiva 9.', 0),
  ('caranguejo-gigante', 'Amphibious', 'The crab can breathe air and water.', 1),
  ('cavalo-de-guerra', 'Sentidos', 'Percepção Passiva 11.', 0),
  ('cavalo-de-montaria', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('cavalo-de-tracao', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('cavalo-marinho-gigante', 'Sentidos', 'Percepção Passiva 11.', 0),
  ('cavalo-marinho-gigante', 'Water Breathing', 'The seahorse can breathe only underwater.', 1),
  ('cobra-constritora', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 12.', 0),
  ('cobra-venenosa', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 10.', 0),
  ('coruja', 'Sentidos', 'Visão no Escuro 36 m. Percepção Passiva 15.', 0),
  ('coruja', 'Flyby', 'The owl doesn’t provoke an Opportunity Attack when it flies out of an enemy’s reach.', 1),
  ('corvo', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('corvo', 'Mimicry', 'The raven can mimic simple sounds it has heard, such as a whisper or chitter. A hearer can discern the sounds are imitations with a successful DC 10 Wisdom (Insight) check.', 1),
  ('crocodilo', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('crocodilo', 'Hold Breath', 'The crocodile can hold its breath for 1 hour.', 1),
  ('doninha', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('doninha-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('elefante', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('escorpiao', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 9.', 0),
  ('falcao', 'Sentidos', 'Percepção Passiva 16.', 0),
  ('gato', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('gato', 'Jumper', 'The cat’s jump distance is determined using its Dexterity rather than its Strength.', 1),
  ('javali', 'Sentidos', 'Percepção Passiva 9.', 0),
  ('javali', 'Bloodied Fury', 'While Bloodied, the boar has Advantage on attack rolls.', 1),
  ('lagarto', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 9.', 0),
  ('lagarto', 'Spider Climb', 'The lizard can climb difficult surfaces, including along ceilings, without needing to make an ability check.', 1),
  ('leao', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('leao', 'Pack Tactics', 'The lion has Advantage on an attack roll against a creature if at least one of the lion’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('leao', 'Running Leap', 'With a 10-foot running start, the lion can Long Jump up to 25 feet.', 2),
  ('lobo', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 15.', 0),
  ('lobo', 'Pack Tactics', 'The wolf has Advantage on attack rolls against a creature if at least one of the wolf’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('lobo-terrivel', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 15.', 0),
  ('lobo-terrivel', 'Pack Tactics', 'The wolf has Advantage on an attack roll against a creature if at least one of the wolf’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('macaco', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('mastim', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 15.', 0),
  ('morcego', 'Sentidos', 'Visão às Cegas 18 m. Percepção Passiva 11.', 0),
  ('mula', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('mula', 'Beast of Burden', 'The mule counts as one size larger for the purpose of determining its carrying capacity.', 1),
  ('pantera', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 14.', 0),
  ('polvo', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 12.', 0),
  ('polvo', 'Compression', 'The octopus can move through a space as narrow as 1 inch without expending extra movement to do so.', 1),
  ('polvo', 'Water Breathing', 'The octopus can breathe only underwater.', 2),
  ('ponei', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('rato', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 12.', 0),
  ('rato', 'Agile', 'The rat doesn’t provoke an Opportunity Attack when it moves out of an enemy’s reach.', 1),
  ('sapo', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 11.', 0),
  ('sapo', 'Amphibious', 'The frog can breathe air and water.', 1),
  ('sapo', 'Standing Leap', 'The frog’s Long Jump is up to 10 feet and its High Jump is up to 5 feet with or without a running start.', 2),
  ('texugo', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 13.', 0),
  ('texugo-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('tigre', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('tubarao-de-recife', 'Sentidos', 'Visão às Cegas 9 m. Percepção Passiva 12.', 0),
  ('tubarao-de-recife', 'Pack Tactics', 'The shark has Advantage on an attack roll against a creature if at least one of the shark’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('tubarao-de-recife', 'Water Breathing', 'The shark can breathe only underwater.', 2),
  ('urso-negro', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 15.', 0),
  ('urso-pardo', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug IN ('alce', 'aranha', 'aranha-gigante', 'cabra', 'cabra-gigante', 'camelo', 'caranguejo', 'caranguejo-gigante', 'cavalo-de-guerra', 'cavalo-de-montaria', 'cavalo-de-tracao', 'cavalo-marinho-gigante', 'cobra-constritora', 'cobra-venenosa', 'coruja', 'corvo', 'crocodilo', 'doninha', 'doninha-gigante', 'elefante', 'escorpiao', 'falcao', 'gato', 'javali', 'lagarto', 'leao', 'lobo', 'lobo-terrivel', 'macaco', 'mastim', 'morcego', 'mula', 'pantera', 'polvo', 'ponei', 'rato', 'sapo', 'texugo', 'texugo-gigante', 'tigre', 'tubarao-de-recife', 'urso-negro', 'urso-pardo');
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('alce', 'Ram', 'action'::rpg.actor_action_bucket, 5, '6', 'Melee Attack Roll: +5, reach 5 ft. Hit: 6 (1d6 + 3) Bludgeoning damage. If the target is a Large or smaller creature and the elk moved 20+ feet straight toward it immediately before the hit, the target takes an extra 3 (1d6) Bludgeoning damage and has the Prone condition.', 1),
  ('aranha', 'Bite', 'action'::rpg.actor_action_bucket, 4, '1', 'Melee Attack Roll: +4, reach 5 ft. Hit: 1 Piercing damage plus 2 (1d4) Poison damage.', 1),
  ('aranha-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 5, '7', 'Melee Attack Roll: +5, reach 5 ft. Hit: 7 (1d8 + 3) Piercing damage plus 7 (2d6) Poison damage.', 1),
  ('aranha-gigante', 'Web (Recharge 5–6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Dexterity Saving Throw: DC 13, one creature the spider can see within 60 feet. Failure: The target has the Restrained condition until the web is destroyed (AC 10; HP 5; Vulnerability to Fire damage; Immunity to Poison and Psychic damage).', 2),
  ('cabra', 'Ram', 'action'::rpg.actor_action_bucket, 2, '1', 'Melee Attack Roll: +2, reach 5 ft. Hit: 1 Bludgeoning damage, or 2 (1d4) Bludgeoning damage if the goat moved 20+ feet straight toward the target immediately before the hit.', 1),
  ('cabra-gigante', 'Ram', 'action'::rpg.actor_action_bucket, 5, '6', 'Melee Attack Roll: +5, reach 5 ft. Hit: 6 (1d6 + 3) Bludgeoning damage. If the target is a Large or smaller creature and the goat moved 20+ feet straight toward it immediately before the hit, the target takes an extra 5 (2d4) Bludgeoning damage and has the Prone condition.', 1),
  ('camelo', 'Bite', 'action'::rpg.actor_action_bucket, 4, '4', 'Melee Attack Roll: +4, reach 5 ft. Hit: 4 (1d4 + 2) Bludgeoning damage.', 1),
  ('caranguejo', 'Claw', 'action'::rpg.actor_action_bucket, 2, '1', 'Melee Attack Roll: +2, reach 5 ft. Hit: 1 Bludgeoning damage.', 1),
  ('caranguejo-gigante', 'Claw', 'action'::rpg.actor_action_bucket, 3, '4', 'Melee Attack Roll: +3, reach 5 ft. Hit: 4 (1d6 + 1) Bludgeoning damage. If the target is a Medium or smaller creature, it has the Grappled condition (escape DC 11) from one of two claws.', 1),
  ('cavalo-de-guerra', 'Hooves', 'action'::rpg.actor_action_bucket, 6, '9', 'Melee Attack Roll: +6, reach 5 ft. Hit: 9 (2d4 + 4) Bludgeoning damage. If the target is a Large or smaller creature and the horse moved 20+ feet straight toward it immediately before the hit, the target takes an extra 5 (2d4) Bludgeoning damage and has the Prone condition.', 1),
  ('cavalo-de-montaria', 'Hooves', 'action'::rpg.actor_action_bucket, 5, '7', 'Melee Attack Roll: +5, reach 5 ft. Hit: 7 (1d8 + 3) Bludgeoning damage.', 1),
  ('cavalo-de-tracao', 'Hooves', 'action'::rpg.actor_action_bucket, 6, '6', 'Melee Attack Roll: +6, reach 5 ft. Hit: 6 (1d4 + 4) Bludgeoning damage.', 1),
  ('cavalo-marinho-gigante', 'Ram', 'action'::rpg.actor_action_bucket, 4, '9', 'Melee Attack Roll: +4, reach 5 ft. Hit: 9 (2d6 + 2) Bludgeoning damage, or 11 (2d8 + 2) Bludgeoning damage if the seahorse moved 20+ feet straight toward the target immediately before the hit.', 1),
  ('cavalo-marinho-gigante', 'Bubble Dash', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'While underwater, the seahorse moves up to half its Swim Speed without provoking Opportunity Attacks.', 2),
  ('cobra-constritora', 'Bite', 'action'::rpg.actor_action_bucket, 4, '6', 'Melee Attack Roll: +4, reach 5 ft. Hit: 6 (1d8 + 2) Piercing damage.', 1),
  ('cobra-constritora', 'Constrict', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Strength Saving Throw: DC 12, one Medium or smaller creature the snake can see within 5 feet. Failure: 7 (3d4) Bludgeoning damage, and the target has the Grappled condition (escape DC 12).', 2),
  ('cobra-venenosa', 'Bite', 'action'::rpg.actor_action_bucket, 4, '4', 'Melee Attack Roll: +4, reach 5 ft. Hit: 4 (1d4 + 2) Piercing damage plus 3 (1d6) Poison damage.', 1),
  ('coruja', 'Talons', 'action'::rpg.actor_action_bucket, 3, '1', 'Melee Attack Roll: +3, reach 5 ft. Hit: 1 Slashing damage.', 1),
  ('corvo', 'Beak', 'action'::rpg.actor_action_bucket, 4, '1', 'Melee Attack Roll: +4, reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('crocodilo', 'Bite', 'action'::rpg.actor_action_bucket, 4, '6', 'Melee Attack Roll: +4, reach 5 ft. Hit: 6 (1d8 + 2) Piercing damage. If the target is a Medium or smaller creature, it has the Grappled condition (escape DC 12). While Grappled, the target has the Restrained condition.', 1),
  ('doninha', 'Bite', 'action'::rpg.actor_action_bucket, 5, '1', 'Melee Attack Roll: +5, reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('doninha-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 5, '5', 'Melee Attack Roll: +5, reach 5 ft. Hit: 5 (1d4 + 3) Piercing damage.', 1),
  ('elefante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The elephant makes two Gore attacks.', 1),
  ('elefante', 'Gore', 'action'::rpg.actor_action_bucket, 8, '15', 'Melee Attack Roll: +8, reach 5 ft. Hit: 15 (2d8 + 6) Piercing damage. If the target is a Huge or smaller creature and the elephant moved 20+ feet straight toward it immediately before the hit, the target has the Prone condition.', 2),
  ('elefante', 'Trample', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Dexterity Saving Throw: DC 16, one creature within 5 feet that has the Prone condition. Failure: 17 (2d10 + 6) Bludgeoning damage. Success: Half damage.', 3),
  ('escorpiao', 'Sting', 'action'::rpg.actor_action_bucket, 2, '1', 'Melee Attack Roll: +2, reach 5 ft. Hit: 1 Piercing damage plus 3 (1d6) Poison damage.', 1),
  ('falcao', 'Talons', 'action'::rpg.actor_action_bucket, 5, '1', 'Melee Attack Roll: +5, reach 5 ft. Hit: 1 Slashing damage.', 1),
  ('gato', 'Scratch', 'action'::rpg.actor_action_bucket, 4, '1', 'Melee Attack Roll: +4, reach 5 ft. Hit: 1 Slashing damage.', 1),
  ('javali', 'Gore', 'action'::rpg.actor_action_bucket, 3, '4', 'Melee Attack Roll: +3, reach 5 ft. Hit: 4 (1d6 + 1) Piercing damage. If the target is a Medium or smaller creature and the boar moved 20+ feet straight toward it immediately before the hit, the target takes an extra 3 (1d6) Piercing damage and has the Prone condition.', 1),
  ('lagarto', 'Bite', 'action'::rpg.actor_action_bucket, 2, '1', 'Melee Attack Roll: +2, reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('leao', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The lion makes two Rend attacks. It can replace one attack with a use of Roar.', 1),
  ('leao', 'Rend', 'action'::rpg.actor_action_bucket, 5, '7', 'Melee Attack Roll: +5, reach 5 ft. Hit: 7 (1d8 + 3) Slashing damage.', 2),
  ('leao', 'Roar', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Wisdom Saving Throw: DC 11, one creature within 15 feet. Failure: The target has the Frightened condition until the start of the lion’s next turn.', 3),
  ('lobo', 'Bite', 'action'::rpg.actor_action_bucket, 4, '5', 'Melee Attack Roll: +4, reach 5 ft. Hit: 5 (1d6 + 2) Piercing damage. If the target is a Medium or smaller creature, it has the Prone condition.', 1),
  ('lobo-terrivel', 'Bite', 'action'::rpg.actor_action_bucket, 5, '8', 'Melee Attack Roll: +5, reach 5 ft. Hit: 8 (1d10 + 3) Piercing damage. If the target is a Large or smaller creature, it has the Prone condition.', 1),
  ('macaco', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The ape makes two Fist attacks.', 1),
  ('macaco', 'Fist', 'action'::rpg.actor_action_bucket, 5, '5', 'Melee Attack Roll: +5, reach 5 ft. Hit: 5 (1d4 + 3) Bludgeoning damage.', 2),
  ('macaco', 'Rock (Recharge 6)', 'action'::rpg.actor_action_bucket, 5, '10', 'Ranged Attack Roll: +5, range 25/50 ft. Hit: 10 (2d6 + 3) Bludgeoning damage.', 3),
  ('mastim', 'Bite', 'action'::rpg.actor_action_bucket, 3, '4', 'Melee Attack Roll: +3, reach 5 ft. Hit: 4 (1d6 + 1) Piercing damage. If the target is a Medium or smaller creature, it has the Prone condition.', 1),
  ('morcego', 'Bite', 'action'::rpg.actor_action_bucket, 4, '1', 'Melee Attack Roll: +4, reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('mula', 'Hooves', 'action'::rpg.actor_action_bucket, 4, '4', 'Melee Attack Roll: +4, reach 5 ft. Hit: 4 (1d4 + 2) Bludgeoning damage.', 1),
  ('pantera', 'Rend', 'action'::rpg.actor_action_bucket, 5, '6', 'Melee Attack Roll: +5, reach 5 ft. Hit: 6 (1d6 + 3) Slashing damage.', 1),
  ('pantera', 'Nimble Escape', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'The panther takes the Disengage or Hide action.', 2),
  ('polvo', 'Tentacles', 'action'::rpg.actor_action_bucket, 4, '1', 'Melee Attack Roll: +4, reach 5 ft. Hit: 1 Bludgeoning damage.', 1),
  ('polvo', 'Ink Cloud (1/Day)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Trigger: A creature ends its turn within 5 feet of the octopus while underwater. Response: The octopus releases ink that fills a 5-foot Cube centered on itself, and the octopus moves up to its Swim Speed. The Cube is Heavily Obscured for 1 minute or until a strong current or similar effect disperses the ink.', 2),
  ('ponei', 'Hooves', 'action'::rpg.actor_action_bucket, 4, '4', 'Melee Attack Roll: +4, reach 5 ft. Hit: 4 (1d4 + 2) Bludgeoning damage.', 1),
  ('rato', 'Bite', 'action'::rpg.actor_action_bucket, 2, '1', 'Melee Attack Roll: +2, reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('sapo', 'Bite', 'action'::rpg.actor_action_bucket, 3, '1', 'Melee Attack Roll: +3, reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('texugo', 'Bite', 'action'::rpg.actor_action_bucket, 2, '1', 'Melee Attack Roll: +2, reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('texugo-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 3, '6', 'Melee Attack Roll: +3, reach 5 ft. Hit: 6 (2d4 + 1) Piercing damage.', 1),
  ('tigre', 'Rend', 'action'::rpg.actor_action_bucket, 5, '10', 'Melee Attack Roll: +5, reach 5 ft. Hit: 10 (2d6 + 3) Slashing damage. If the target is a Large or smaller creature, it has the Prone condition.', 1),
  ('tigre', 'Nimble Escape', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'The tiger takes the Disengage or Hide action.', 2),
  ('tubarao-de-recife', 'Bite', 'action'::rpg.actor_action_bucket, 4, '7', 'Melee Attack Roll: +4, reach 5 ft. Hit: 7 (2d4 + 2) Piercing damage.', 1),
  ('urso-negro', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The bear makes two Rend attacks.', 1),
  ('urso-negro', 'Rend', 'action'::rpg.actor_action_bucket, 4, '5', 'Melee Attack Roll: +4, reach 5 ft. Hit: 5 (1d6 + 2) Slashing damage.', 2),
  ('urso-pardo', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The bear makes one Bite attack and one Claw attack.', 1),
  ('urso-pardo', 'Bite', 'action'::rpg.actor_action_bucket, 5, '7', 'Melee Attack Roll: +5, reach 5 ft. Hit: 7 (1d8 + 3) Piercing damage.', 2),
  ('urso-pardo', 'Claw', 'action'::rpg.actor_action_bucket, 5, '5', 'Melee Attack Roll: +5, reach 5 ft. Hit: 5 (1d4 + 3) Slashing damage. If the target is a Large or smaller creature, it has the Prone condition.', 3);

