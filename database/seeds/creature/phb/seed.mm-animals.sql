-- Monster Manual — Animals (Beasts novas; sem overlap PHB App. B).
-- Extract: docs/source/extracts/mm/animals-beasts.json
-- Exclui Swarm e não-Beast (ex.: Giant Eagle Celestial).

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, creature_subtype, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores, image_url
) VALUES
(
  'abutre', 'phb-2024-pt', 'Abutre',
  'Média Fera, Neutra', 'Neutra', 'Beast', NULL, 'medium',
  '0', 2, 10, 5, '1d8 + 1', 0,
  '{"forca":7,"destreza":10,"constituicao":13,"inteligencia":2,"sabedoria":12,"carisma":4}'::jsonb, NULL
),
(
  'aguia', 'phb-2024-pt', 'Águia',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', NULL, 'small',
  '0', 2, 12, 4, '1d6 + 1', 2,
  '{"forca":6,"destreza":15,"constituicao":12,"inteligencia":2,"sabedoria":14,"carisma":7}'::jsonb, NULL
),
(
  'alossauro', 'phb-2024-pt', 'Alossauro',
  'Grande Fera (Dinosaur), Neutra', 'Neutra', 'Beast', 'Dinosaur', 'large',
  '2', 2, 13, 51, '6d10 + 18', 1,
  '{"forca":19,"destreza":13,"constituicao":17,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, '/catalog/beasts/alossauro.png'
),
(
  'anquilossauro', 'phb-2024-pt', 'Anquilossauro',
  'Enorme Fera (Dinosaur), Neutra', 'Neutra', 'Beast', 'Dinosaur', 'huge',
  '3', 2, 15, 68, '8d12 + 16', 0,
  '{"forca":19,"destreza":11,"constituicao":15,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, NULL
),
(
  'aranha-lobo-gigante', 'phb-2024-pt', 'Aranha-lobo Gigante',
  'Média Fera, Neutra', 'Neutra', 'Beast', NULL, 'medium',
  '1/4', 2, 13, 11, '2d8 + 2', 3,
  '{"forca":12,"destreza":16,"constituicao":13,"inteligencia":3,"sabedoria":12,"carisma":4}'::jsonb, NULL
),
(
  'arquelon', 'phb-2024-pt', 'Arquelon',
  'Enorme Fera (Dinosaur), Neutra', 'Neutra', 'Beast', 'Dinosaur', 'huge',
  '4', 2, 17, 90, '12d12 + 12', 3,
  '{"forca":18,"destreza":16,"constituicao":13,"inteligencia":4,"sabedoria":14,"carisma":6}'::jsonb, '/catalog/beasts/arquelon.png'
),
(
  'babuino', 'phb-2024-pt', 'Babuíno',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', NULL, 'small',
  '0', 2, 12, 3, '1d6', 2,
  '{"forca":8,"destreza":14,"constituicao":11,"inteligencia":4,"sabedoria":12,"carisma":6}'::jsonb, NULL
),
(
  'besouro-de-fogo-gigante', 'phb-2024-pt', 'Besouro de Fogo Gigante',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', NULL, 'small',
  '0', 2, 13, 4, '1d6 + 1', 0,
  '{"forca":8,"destreza":10,"constituicao":12,"inteligencia":1,"sabedoria":7,"carisma":3}'::jsonb, NULL
),
(
  'cavalo-marinho', 'phb-2024-pt', 'Cavalo-marinho',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', NULL, 'tiny',
  '0', 2, 12, 1, '1d4 − 1', 1,
  '{"forca":1,"destreza":12,"constituicao":8,"inteligencia":1,"sabedoria":10,"carisma":2}'::jsonb, NULL
),
(
  'centopeia-gigante', 'phb-2024-pt', 'Centopeia Gigante',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', NULL, 'small',
  '1/4', 2, 14, 9, '2d6 + 2', 2,
  '{"forca":5,"destreza":14,"constituicao":12,"inteligencia":1,"sabedoria":7,"carisma":3}'::jsonb, NULL
),
(
  'cervo', 'phb-2024-pt', 'Cervo',
  'Média Fera, Neutra', 'Neutra', 'Beast', NULL, 'medium',
  '0', 2, 13, 4, '1d8', 3,
  '{"forca":11,"destreza":16,"constituicao":11,"inteligencia":2,"sabedoria":14,"carisma":5}'::jsonb, NULL
),
(
  'chacal', 'phb-2024-pt', 'Chacal',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', NULL, 'small',
  '0', 2, 12, 3, '1d6', 2,
  '{"forca":8,"destreza":15,"constituicao":11,"inteligencia":3,"sabedoria":12,"carisma":6}'::jsonb, NULL
),
(
  'cobra-constritora-gigante', 'phb-2024-pt', 'Cobra Constritora Gigante',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '2', 2, 12, 60, '8d12 + 8', 2,
  '{"forca":19,"destreza":14,"constituicao":12,"inteligencia":1,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'cobra-venenosa-gigante', 'phb-2024-pt', 'Cobra Venenosa Gigante',
  'Média Fera, Neutra', 'Neutra', 'Beast', NULL, 'medium',
  '1/4', 2, 14, 11, '2d8 + 2', 4,
  '{"forca":10,"destreza":18,"constituicao":13,"inteligencia":2,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'crocodilo-gigante', 'phb-2024-pt', 'Crocodilo Gigante',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '5', 3, 14, 85, '9d12 + 27', 0,
  '{"forca":21,"destreza":9,"constituicao":17,"inteligencia":2,"sabedoria":10,"carisma":7}'::jsonb, NULL
),
(
  'escorpiao-gigante', 'phb-2024-pt', 'Escorpião Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '3', 2, 15, 52, '7d10 + 14', 1,
  '{"forca":16,"destreza":13,"constituicao":15,"inteligencia":1,"sabedoria":9,"carisma":3}'::jsonb, NULL
),
(
  'falcao-sangrento', 'phb-2024-pt', 'Falcão Sangrento',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', NULL, 'small',
  '1/8', 2, 12, 7, '2d6', 2,
  '{"forca":6,"destreza":14,"constituicao":10,"inteligencia":3,"sabedoria":14,"carisma":5}'::jsonb, NULL
),
(
  'hiena', 'phb-2024-pt', 'Hiena',
  'Média Fera, Neutra', 'Neutra', 'Beast', NULL, 'medium',
  '0', 2, 11, 5, '1d8 + 1', 1,
  '{"forca":11,"destreza":13,"constituicao":12,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, NULL
),
(
  'hiena-gigante', 'phb-2024-pt', 'Hiena Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1', 2, 12, 45, '6d10 + 12', 2,
  '{"forca":16,"destreza":14,"constituicao":14,"inteligencia":2,"sabedoria":12,"carisma":7}'::jsonb, NULL
),
(
  'hipopotamo', 'phb-2024-pt', 'Hipopótamo',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '4', 2, 14, 82, '11d10 + 22', 0,
  '{"forca":21,"destreza":7,"constituicao":15,"inteligencia":2,"sabedoria":12,"carisma":4}'::jsonb, NULL
),
(
  'javali-gigante', 'phb-2024-pt', 'Javali Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '2', 2, 13, 42, '5d10 + 15', 0,
  '{"forca":17,"destreza":10,"constituicao":16,"inteligencia":2,"sabedoria":7,"carisma":5}'::jsonb, '/catalog/beasts/javali-gigante.png'
),
(
  'lagarto-gigante', 'phb-2024-pt', 'Lagarto Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1/4', 2, 12, 19, '3d10 + 3', 1,
  '{"forca":15,"destreza":12,"constituicao":13,"inteligencia":2,"sabedoria":10,"carisma":5}'::jsonb, '/catalog/beasts/lagarto-gigante.png'
),
(
  'lula-gigante', 'phb-2024-pt', 'Lula Gigante',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '6', 3, 12, 120, '16d12 + 16', 2,
  '{"forca":23,"destreza":14,"constituicao":12,"inteligencia":5,"sabedoria":11,"carisma":4}'::jsonb, '/catalog/beasts/lula-gigante.png'
),
(
  'macaco-gigante', 'phb-2024-pt', 'Macaco Gigante',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '7', 3, 12, 168, '16d12 + 64', 5,
  '{"forca":23,"destreza":14,"constituicao":18,"inteligencia":5,"sabedoria":12,"carisma":7}'::jsonb, '/catalog/beasts/macaco-gigante.png'
),
(
  'mamute', 'phb-2024-pt', 'Mamute',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '6', 3, 13, 126, '11d12 + 55', 2,
  '{"forca":24,"destreza":9,"constituicao":21,"inteligencia":3,"sabedoria":11,"carisma":6}'::jsonb, NULL
),
(
  'morcego-gigante', 'phb-2024-pt', 'Morcego Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1/4', 2, 13, 22, '4d10', 3,
  '{"forca":15,"destreza":16,"constituicao":11,"inteligencia":2,"sabedoria":12,"carisma":6}'::jsonb, NULL
),
(
  'orca', 'phb-2024-pt', 'Orca',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '3', 2, 12, 90, '12d12 + 12', 2,
  '{"forca":19,"destreza":14,"constituicao":13,"inteligencia":3,"sabedoria":12,"carisma":7}'::jsonb, NULL
),
(
  'piranha', 'phb-2024-pt', 'Piranha',
  'Minúscula Fera, Neutra', 'Neutra', 'Beast', NULL, 'tiny',
  '0', 2, 13, 1, '1d4 − 1', 3,
  '{"forca":2,"destreza":16,"constituicao":9,"inteligencia":1,"sabedoria":7,"carisma":2}'::jsonb, NULL
),
(
  'plessiossauro', 'phb-2024-pt', 'Plessiossauro',
  'Grande Fera (Dinosaur), Neutra', 'Neutra', 'Beast', 'Dinosaur', 'large',
  '2', 2, 13, 68, '8d10 + 24', 2,
  '{"forca":18,"destreza":15,"constituicao":16,"inteligencia":2,"sabedoria":12,"carisma":5}'::jsonb, NULL
),
(
  'polvo-gigante', 'phb-2024-pt', 'Polvo Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1', 2, 11, 45, '7d10 + 7', 1,
  '{"forca":17,"destreza":13,"constituicao":13,"inteligencia":5,"sabedoria":10,"carisma":4}'::jsonb, NULL
),
(
  'pteranodonte', 'phb-2024-pt', 'Pteranodonte',
  'Média Fera (Dinosaur), Neutra', 'Neutra', 'Beast', 'Dinosaur', 'medium',
  '1/4', 2, 13, 13, '3d8', 2,
  '{"forca":12,"destreza":15,"constituicao":10,"inteligencia":2,"sabedoria":9,"carisma":5}'::jsonb, NULL
),
(
  'ra-gigante', 'phb-2024-pt', 'Rã Gigante',
  'Média Fera, Neutra', 'Neutra', 'Beast', NULL, 'medium',
  '1/4', 2, 11, 18, '4d8', 1,
  '{"forca":12,"destreza":13,"constituicao":11,"inteligencia":2,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'rato-gigante', 'phb-2024-pt', 'Rato Gigante',
  'Pequena Fera, Neutra', 'Neutra', 'Beast', NULL, 'small',
  '1/8', 2, 13, 7, '2d6', 3,
  '{"forca":7,"destreza":16,"constituicao":11,"inteligencia":2,"sabedoria":10,"carisma":4}'::jsonb, NULL
),
(
  'rinoceronte', 'phb-2024-pt', 'Rinoceronte',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '2', 2, 13, 45, '6d10 + 12', 0,
  '{"forca":21,"destreza":8,"constituicao":15,"inteligencia":2,"sabedoria":12,"carisma":6}'::jsonb, '/catalog/beasts/rinoceronte.png'
),
(
  'sapo-gigante', 'phb-2024-pt', 'Sapo Gigante',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '1', 2, 11, 39, '6d10 + 6', 1,
  '{"forca":15,"destreza":13,"constituicao":13,"inteligencia":2,"sabedoria":10,"carisma":3}'::jsonb, NULL
),
(
  'tigre-dentes-de-sabre', 'phb-2024-pt', 'Tigre-dentes-de-sabre',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '2', 2, 13, 52, '7d10 + 14', 3,
  '{"forca":18,"destreza":17,"constituicao":15,"inteligencia":3,"sabedoria":12,"carisma":8}'::jsonb, NULL
),
(
  'tiranossauro', 'phb-2024-pt', 'Tiranossauro Rex',
  'Enorme Fera (Dinosaur), Neutra', 'Neutra', 'Beast', 'Dinosaur', 'huge',
  '8', 3, 13, 136, '13d12 + 52', 3,
  '{"forca":25,"destreza":10,"constituicao":19,"inteligencia":2,"sabedoria":12,"carisma":9}'::jsonb, '/catalog/beasts/tiranossauro.png'
),
(
  'triceratops', 'phb-2024-pt', 'Tricerátops',
  'Enorme Fera (Dinosaur), Neutra', 'Neutra', 'Beast', 'Dinosaur', 'huge',
  '5', 3, 14, 114, '12d12 + 36', 0,
  '{"forca":22,"destreza":9,"constituicao":17,"inteligencia":2,"sabedoria":11,"carisma":5}'::jsonb, NULL
),
(
  'tubarao-cacador', 'phb-2024-pt', 'Tubarão Caçador',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '2', 2, 12, 45, '6d10 + 12', 2,
  '{"forca":18,"destreza":14,"constituicao":15,"inteligencia":1,"sabedoria":10,"carisma":4}'::jsonb, NULL
),
(
  'tubarao-gigante', 'phb-2024-pt', 'Tubarão Gigante',
  'Enorme Fera, Neutra', 'Neutra', 'Beast', NULL, 'huge',
  '5', 3, 13, 92, '8d12 + 40', 3,
  '{"forca":23,"destreza":11,"constituicao":21,"inteligencia":1,"sabedoria":10,"carisma":5}'::jsonb, NULL
),
(
  'urso-polar', 'phb-2024-pt', 'Urso Polar',
  'Grande Fera, Neutra', 'Neutra', 'Beast', NULL, 'large',
  '2', 2, 12, 42, '5d10 + 15', 2,
  '{"forca":20,"destreza":14,"constituicao":16,"inteligencia":2,"sabedoria":13,"carisma":7}'::jsonb, NULL
),
(
  'vespa-gigante', 'phb-2024-pt', 'Vespa Gigante',
  'Média Fera, Neutra', 'Neutra', 'Beast', NULL, 'medium',
  '1/2', 2, 13, 22, '5d8', 2,
  '{"forca":10,"destreza":14,"constituicao":10,"inteligencia":1,"sabedoria":10,"carisma":3}'::jsonb, '/catalog/beasts/vespa-gigante.png'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, creature_subtype = EXCLUDED.creature_subtype,
  size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores,
  image_url = COALESCE(EXCLUDED.image_url, rpg.phb_creature_template.image_url);

INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES
  ('abutre', 1, 10, 0, 5, 0, 'per_slot'),
  ('aguia', 1, 12, 0, 4, 0, 'per_slot'),
  ('alossauro', 1, 13, 0, 51, 0, 'per_slot'),
  ('anquilossauro', 1, 15, 0, 68, 0, 'per_slot'),
  ('aranha-lobo-gigante', 1, 13, 0, 11, 0, 'per_slot'),
  ('arquelon', 1, 17, 0, 90, 0, 'per_slot'),
  ('babuino', 1, 12, 0, 3, 0, 'per_slot'),
  ('besouro-de-fogo-gigante', 1, 13, 0, 4, 0, 'per_slot'),
  ('cavalo-marinho', 1, 12, 0, 1, 0, 'per_slot'),
  ('centopeia-gigante', 1, 14, 0, 9, 0, 'per_slot'),
  ('cervo', 1, 13, 0, 4, 0, 'per_slot'),
  ('chacal', 1, 12, 0, 3, 0, 'per_slot'),
  ('cobra-constritora-gigante', 1, 12, 0, 60, 0, 'per_slot'),
  ('cobra-venenosa-gigante', 1, 14, 0, 11, 0, 'per_slot'),
  ('crocodilo-gigante', 1, 14, 0, 85, 0, 'per_slot'),
  ('escorpiao-gigante', 1, 15, 0, 52, 0, 'per_slot'),
  ('falcao-sangrento', 1, 12, 0, 7, 0, 'per_slot'),
  ('hiena', 1, 11, 0, 5, 0, 'per_slot'),
  ('hiena-gigante', 1, 12, 0, 45, 0, 'per_slot'),
  ('hipopotamo', 1, 14, 0, 82, 0, 'per_slot'),
  ('javali-gigante', 1, 13, 0, 42, 0, 'per_slot'),
  ('lagarto-gigante', 1, 12, 0, 19, 0, 'per_slot'),
  ('lula-gigante', 1, 12, 0, 120, 0, 'per_slot'),
  ('macaco-gigante', 1, 12, 0, 168, 0, 'per_slot'),
  ('mamute', 1, 13, 0, 126, 0, 'per_slot'),
  ('morcego-gigante', 1, 13, 0, 22, 0, 'per_slot'),
  ('orca', 1, 12, 0, 90, 0, 'per_slot'),
  ('piranha', 1, 13, 0, 1, 0, 'per_slot'),
  ('plessiossauro', 1, 13, 0, 68, 0, 'per_slot'),
  ('polvo-gigante', 1, 11, 0, 45, 0, 'per_slot'),
  ('pteranodonte', 1, 13, 0, 13, 0, 'per_slot'),
  ('ra-gigante', 1, 11, 0, 18, 0, 'per_slot'),
  ('rato-gigante', 1, 13, 0, 7, 0, 'per_slot'),
  ('rinoceronte', 1, 13, 0, 45, 0, 'per_slot'),
  ('sapo-gigante', 1, 11, 0, 39, 0, 'per_slot'),
  ('tigre-dentes-de-sabre', 1, 13, 0, 52, 0, 'per_slot'),
  ('tiranossauro', 1, 13, 0, 136, 0, 'per_slot'),
  ('triceratops', 1, 14, 0, 114, 0, 'per_slot'),
  ('tubarao-cacador', 1, 12, 0, 45, 0, 'per_slot'),
  ('tubarao-gigante', 1, 13, 0, 92, 0, 'per_slot'),
  ('urso-polar', 1, 12, 0, 42, 0, 'per_slot'),
  ('vespa-gigante', 1, 13, 0, 22, 0, 'per_slot')
ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;

DELETE FROM rpg.phb_creature_template_speed WHERE template_slug IN ('abutre', 'aguia', 'alossauro', 'anquilossauro', 'aranha-lobo-gigante', 'arquelon', 'babuino', 'besouro-de-fogo-gigante', 'cavalo-marinho', 'centopeia-gigante', 'cervo', 'chacal', 'cobra-constritora-gigante', 'cobra-venenosa-gigante', 'crocodilo-gigante', 'escorpiao-gigante', 'falcao-sangrento', 'hiena', 'hiena-gigante', 'hipopotamo', 'javali-gigante', 'lagarto-gigante', 'lula-gigante', 'macaco-gigante', 'mamute', 'morcego-gigante', 'orca', 'piranha', 'plessiossauro', 'polvo-gigante', 'pteranodonte', 'ra-gigante', 'rato-gigante', 'rinoceronte', 'sapo-gigante', 'tigre-dentes-de-sabre', 'tiranossauro', 'triceratops', 'tubarao-cacador', 'tubarao-gigante', 'urso-polar', 'vespa-gigante');
INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES
  ('abutre', 'walk', 10),
  ('abutre', 'fly', 50),
  ('aguia', 'walk', 10),
  ('aguia', 'fly', 60),
  ('alossauro', 'walk', 60),
  ('anquilossauro', 'walk', 30),
  ('aranha-lobo-gigante', 'walk', 40),
  ('aranha-lobo-gigante', 'climb', 40),
  ('arquelon', 'walk', 20),
  ('arquelon', 'swim', 80),
  ('babuino', 'walk', 30),
  ('babuino', 'climb', 30),
  ('besouro-de-fogo-gigante', 'walk', 30),
  ('besouro-de-fogo-gigante', 'climb', 30),
  ('cavalo-marinho', 'walk', 5),
  ('cavalo-marinho', 'swim', 20),
  ('centopeia-gigante', 'walk', 30),
  ('centopeia-gigante', 'climb', 30),
  ('cervo', 'walk', 50),
  ('chacal', 'walk', 40),
  ('cobra-constritora-gigante', 'walk', 30),
  ('cobra-constritora-gigante', 'swim', 30),
  ('cobra-venenosa-gigante', 'walk', 40),
  ('cobra-venenosa-gigante', 'swim', 40),
  ('crocodilo-gigante', 'walk', 30),
  ('crocodilo-gigante', 'swim', 50),
  ('escorpiao-gigante', 'walk', 40),
  ('falcao-sangrento', 'walk', 10),
  ('falcao-sangrento', 'fly', 60),
  ('hiena', 'walk', 50),
  ('hiena-gigante', 'walk', 50),
  ('hipopotamo', 'walk', 30),
  ('hipopotamo', 'swim', 30),
  ('javali-gigante', 'walk', 40),
  ('lagarto-gigante', 'walk', 40),
  ('lagarto-gigante', 'climb', 40),
  ('lula-gigante', 'walk', 5),
  ('lula-gigante', 'swim', 80),
  ('macaco-gigante', 'walk', 40),
  ('macaco-gigante', 'climb', 40),
  ('mamute', 'walk', 50),
  ('morcego-gigante', 'walk', 10),
  ('morcego-gigante', 'fly', 60),
  ('orca', 'walk', 5),
  ('orca', 'swim', 60),
  ('piranha', 'walk', 5),
  ('piranha', 'swim', 40),
  ('plessiossauro', 'walk', 20),
  ('plessiossauro', 'swim', 40),
  ('polvo-gigante', 'walk', 10),
  ('polvo-gigante', 'swim', 60),
  ('pteranodonte', 'walk', 10),
  ('pteranodonte', 'fly', 60),
  ('ra-gigante', 'walk', 30),
  ('ra-gigante', 'swim', 30),
  ('rato-gigante', 'walk', 30),
  ('rato-gigante', 'climb', 30),
  ('rinoceronte', 'walk', 40),
  ('sapo-gigante', 'walk', 30),
  ('sapo-gigante', 'swim', 30),
  ('tigre-dentes-de-sabre', 'walk', 40),
  ('tiranossauro', 'walk', 50),
  ('triceratops', 'walk', 50),
  ('tubarao-cacador', 'walk', 5),
  ('tubarao-cacador', 'swim', 40),
  ('tubarao-gigante', 'walk', 5),
  ('tubarao-gigante', 'swim', 60),
  ('urso-polar', 'walk', 40),
  ('urso-polar', 'swim', 40),
  ('vespa-gigante', 'walk', 10),
  ('vespa-gigante', 'fly', 50);

DELETE FROM rpg.phb_creature_template_trait WHERE template_slug IN ('abutre', 'aguia', 'alossauro', 'anquilossauro', 'aranha-lobo-gigante', 'arquelon', 'babuino', 'besouro-de-fogo-gigante', 'cavalo-marinho', 'centopeia-gigante', 'cervo', 'chacal', 'cobra-constritora-gigante', 'cobra-venenosa-gigante', 'crocodilo-gigante', 'escorpiao-gigante', 'falcao-sangrento', 'hiena', 'hiena-gigante', 'hipopotamo', 'javali-gigante', 'lagarto-gigante', 'lula-gigante', 'macaco-gigante', 'mamute', 'morcego-gigante', 'orca', 'piranha', 'plessiossauro', 'polvo-gigante', 'pteranodonte', 'ra-gigante', 'rato-gigante', 'rinoceronte', 'sapo-gigante', 'tigre-dentes-de-sabre', 'tiranossauro', 'triceratops', 'tubarao-cacador', 'tubarao-gigante', 'urso-polar', 'vespa-gigante');
INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES
  ('abutre', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('abutre', 'Pack Tactics', 'The vulture has Advantage on an attack roll against a creature if at least one of the vulture’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('aguia', 'Sentidos', 'Percepção Passiva 16.', 0),
  ('alossauro', 'Sentidos', 'Percepção Passiva 15.', 0),
  ('anquilossauro', 'Sentidos', 'Percepção Passiva 11.', 0),
  ('aranha-lobo-gigante', 'Sentidos', 'Visão às Cegas 3 m, Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('aranha-lobo-gigante', 'Spider Climb', 'The spider can climb difficult surfaces, including along ceilings, without needing to make an ability check.', 1),
  ('arquelon', 'Sentidos', 'Percepção Passiva 12.', 0),
  ('arquelon', 'Amphibious', 'The archelon can breathe air and water.', 1),
  ('babuino', 'Sentidos', 'Percepção Passiva 11.', 0),
  ('babuino', 'Pack Tactics', 'The baboon has Advantage on an attack roll against a creature if at least one of the baboon’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('besouro-de-fogo-gigante', 'Sentidos', 'Visão às Cegas 9 m. Percepção Passiva 8.', 0),
  ('besouro-de-fogo-gigante', 'Illumination', 'The beetle sheds Bright Light in a 10-foot radius and Dim Light for an additional 10 feet.', 1),
  ('cavalo-marinho', 'Sentidos', 'Percepção Passiva 12.', 0),
  ('cavalo-marinho', 'Water Breathing', 'The seahorse can breathe only underwater.', 1),
  ('centopeia-gigante', 'Sentidos', 'Visão às Cegas 9 m. Percepção Passiva 8.', 0),
  ('cervo', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 14.', 0),
  ('cervo', 'Agile', 'The deer doesn’t provoke an Opportunity Attack when it moves out of an enemy’s reach.', 1),
  ('chacal', 'Sentidos', 'Visão no Escuro 27 m. Percepção Passiva 15.', 0),
  ('cobra-constritora-gigante', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 12.', 0),
  ('cobra-venenosa-gigante', 'Sentidos', 'Visão às Cegas 3 m. Percepção Passiva 12.', 0),
  ('crocodilo-gigante', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('crocodilo-gigante', 'Hold Breath', 'The crocodile can hold its breath for 1 hour.', 1),
  ('escorpiao-gigante', 'Sentidos', 'Visão às Cegas 18 m. Percepção Passiva 9.', 0),
  ('falcao-sangrento', 'Sentidos', 'Percepção Passiva 16.', 0),
  ('falcao-sangrento', 'Pack Tactics', 'The hawk has Advantage on an attack roll against a creature if at least one of the hawk’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('hiena', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('hiena', 'Pack Tactics', 'The hyena has Advantage on an attack roll against a creature if at least one of the hyena’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('hiena-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 13.', 0),
  ('hipopotamo', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('hipopotamo', 'Hold Breath', 'The hippopotamus can hold its breath for 10 minutes.', 1),
  ('javali-gigante', 'Sentidos', 'Percepção Passiva 8.', 0),
  ('javali-gigante', 'Bloodied Fury', 'The boar has Advantage on melee attack rolls while it is Bloodied.', 1),
  ('lagarto-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 10.', 0),
  ('lagarto-gigante', 'Spider Climb', 'The lizard can climb difficult surfaces, including along ceilings, without needing to make an ability check.', 1),
  ('lula-gigante', 'Sentidos', 'Visão no Escuro 36 m. Percepção Passiva 16.', 0),
  ('lula-gigante', 'Water Breathing', 'The squid can breathe only underwater.', 1),
  ('macaco-gigante', 'Sentidos', 'Percepção Passiva 14.', 0),
  ('mamute', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('morcego-gigante', 'Sentidos', 'Visão às Cegas 36 m. Percepção Passiva 11.', 0),
  ('orca', 'Sentidos', 'Visão às Cegas 36 m. Percepção Passiva 13.', 0),
  ('orca', 'Hold Breath', 'The whale can hold its breath for 30 minutes.', 1),
  ('piranha', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 8.', 0),
  ('piranha', 'Water Breathing', 'The piranha can breathe only underwater.', 1),
  ('plessiossauro', 'Sentidos', 'Percepção Passiva 13.', 0),
  ('plessiossauro', 'Hold Breath', 'The plesiosaurus can hold its breath for 1 hour.', 1),
  ('polvo-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 14.', 0),
  ('polvo-gigante', 'Water Breathing', 'The octopus can breathe only underwater. It can hold its breath for 1 hour outside water.', 1),
  ('pteranodonte', 'Sentidos', 'Percepção Passiva 11.', 0),
  ('pteranodonte', 'Flyby', 'The pteranodon doesn’t provoke an Opportunity Attack when it flies out of an enemy’s reach.', 1),
  ('ra-gigante', 'Sentidos', 'Visão no Escuro 9 m. Percepção Passiva 12.', 0),
  ('ra-gigante', 'Amphibious', 'The frog can breathe air and water.', 1),
  ('ra-gigante', 'Standing Leap', 'The frog’s Long Jump is up to 20 feet and its High Jump is up to 10 feet with or without a running start.', 2),
  ('rato-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 12.', 0),
  ('rato-gigante', 'Pack Tactics', 'The rat has Advantage on an attack roll against a creature if at least one of the rat’s allies is within 5 feet of the creature and the ally doesn’t have the Incapacitated condition.', 1),
  ('rinoceronte', 'Sentidos', 'Percepção Passiva 11.', 0),
  ('sapo-gigante', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 10.', 0),
  ('sapo-gigante', 'Amphibious', 'The toad can breathe air and water.', 1),
  ('sapo-gigante', 'Standing Leap', 'The toad’s Long Jump is up to 20 feet and its High Jump is up to 10 feet with or without a running start.', 2),
  ('tigre-dentes-de-sabre', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 15.', 0),
  ('tigre-dentes-de-sabre', 'Running Leap', 'With a 10-foot running start, the tiger can Long Jump up to 25 feet.', 1),
  ('tiranossauro', 'Sentidos', 'Percepção Passiva 14.', 0),
  ('triceratops', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('tubarao-cacador', 'Sentidos', 'Visão às Cegas 18 m. Percepção Passiva 12.', 0),
  ('tubarao-cacador', 'Water Breathing', 'The shark can breathe only underwater.', 1),
  ('tubarao-gigante', 'Sentidos', 'Visão às Cegas 18 m. Percepção Passiva 13.', 0),
  ('tubarao-gigante', 'Water Breathing', 'The shark can breathe only underwater.', 1),
  ('urso-polar', 'Sentidos', 'Visão no Escuro 18 m. Percepção Passiva 15.', 0),
  ('vespa-gigante', 'Sentidos', 'Percepção Passiva 10.', 0),
  ('vespa-gigante', 'Flyby', 'The wasp doesn’t provoke an Opportunity Attack when it flies out of an enemy’s reach.', 1);

DELETE FROM rpg.phb_creature_template_action WHERE template_slug IN ('abutre', 'aguia', 'alossauro', 'anquilossauro', 'aranha-lobo-gigante', 'arquelon', 'babuino', 'besouro-de-fogo-gigante', 'cavalo-marinho', 'centopeia-gigante', 'cervo', 'chacal', 'cobra-constritora-gigante', 'cobra-venenosa-gigante', 'crocodilo-gigante', 'escorpiao-gigante', 'falcao-sangrento', 'hiena', 'hiena-gigante', 'hipopotamo', 'javali-gigante', 'lagarto-gigante', 'lula-gigante', 'macaco-gigante', 'mamute', 'morcego-gigante', 'orca', 'piranha', 'plessiossauro', 'polvo-gigante', 'pteranodonte', 'ra-gigante', 'rato-gigante', 'rinoceronte', 'sapo-gigante', 'tigre-dentes-de-sabre', 'tiranossauro', 'triceratops', 'tubarao-cacador', 'tubarao-gigante', 'urso-polar', 'vespa-gigante');
INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES
  ('abutre', 'Beak', 'action'::rpg.actor_action_bucket, 2, '2', 'Melee Attack Roll: +2, reach 5 ft. Hit: 2 (1d4) Piercing damage.', 1),
  ('aguia', 'Talons', 'action'::rpg.actor_action_bucket, 4, '4', 'Melee Attack Roll: +4, reach 5 feet. Hit: 4 (1d4 + 2) Slashing damage.', 1),
  ('alossauro', 'Bite', 'action'::rpg.actor_action_bucket, 6, '15', 'Melee Attack Roll: +6, reach 5 ft. Hit: 15 (2d10 + 4) Piercing damage.', 1),
  ('alossauro', 'Claws', 'action'::rpg.actor_action_bucket, 6, '8', 'Melee Attack Roll: +6, reach 5 ft. Hit: 8 (1d8 + 4) Slashing damage. If the target is a Large or smaller creature and the allosaurus moved 30+ feet straight toward it immediately before the hit, the target has the Prone condition, and the allosaurus can make one Bite attack against it.', 2),
  ('anquilossauro', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The ankylosaurus makes two Tail attacks.', 1),
  ('anquilossauro', 'Tail', 'action'::rpg.actor_action_bucket, 6, '9', 'Melee Attack Roll: +6, reach 10 ft. Hit: 9 (1d10 + 4) Bludgeoning damage. If the target is a Huge or smaller creature, it has the Prone condition.', 2),
  ('aranha-lobo-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 5, '5', 'Melee Attack Roll: +5, reach 5 ft. Hit: 5 (1d4 + 3) Piercing damage plus 5 (2d4) Poison damage.', 1),
  ('arquelon', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The archelon makes two Bite attacks.', 1),
  ('arquelon', 'Bite', 'action'::rpg.actor_action_bucket, 6, '14', 'Melee Attack Roll: +6, reach 5 ft. Hit: 14 (3d6 + 4) Piercing damage.', 2),
  ('babuino', 'Bite', 'action'::rpg.actor_action_bucket, 1, '1', 'Melee Attack Roll: +1, reach 5 ft. Hit: 1 (1d4 - 1) Piercing damage.', 1),
  ('besouro-de-fogo-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 1, '1', 'Melee Attack Roll: +1, reach 5 ft. Hit: 1 Fire damage.', 1),
  ('cavalo-marinho', 'Bubble Dash', 'action'::rpg.actor_action_bucket, NULL, NULL, 'While underwater, the seahorse moves up to its Swim Speed without provoking Opportunity Attacks.', 1),
  ('centopeia-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 4, '4', 'Melee Attack Roll: +4, reach 5 ft. Hit: 4 (1d4 + 2) Piercing damage, and the target has the Poisoned condition until the start of the centipede’s next turn.', 1),
  ('cervo', 'Ram', 'action'::rpg.actor_action_bucket, 2, '2', 'Melee Attack Roll: +2, reach 5 ft. Hit: 2 (1d4) Bludgeoning damage.', 1),
  ('chacal', 'Bite', 'action'::rpg.actor_action_bucket, 1, '1', 'Melee Attack Roll: +1, reach 5 ft. Hit: 1 (1d4 – 1) Piercing damage.', 1),
  ('cobra-constritora-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The snake makes one Bite attack and uses Constrict.', 1),
  ('cobra-constritora-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 6, '11', 'Melee Attack Roll: +6, reach 10 ft. Hit: 11 (2d6 + 4) Piercing damage.', 2),
  ('cobra-constritora-gigante', 'Constrict', 'action'::rpg.actor_action_bucket, NULL, NULL, 'Strength Saving Throw: DC 14, one Large or smaller creature the snake can see within 10 feet. Failure: 13 (2d8 + 4) Bludgeoning damage, and the target has the Grappled condition (escape DC 14).', 3),
  ('cobra-venenosa-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 6, '6', 'Melee Attack Roll: +6, reach 10 ft. Hit: 6 (1d4 + 4) Piercing damage plus 4 (1d8) Poison damage.', 1),
  ('crocodilo-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The crocodile makes one Bite attack and one Tail attack.', 1),
  ('crocodilo-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 8, '21', 'Melee Attack Roll: +8, reach 5 ft. Hit: 21 (3d10 + 5) Piercing damage. If the target is a Large or smaller creature, it has the Grappled condition (escape DC 15). While Grappled, the target has the Restrained condition and can’t be targeted by the crocodile’s Tail.', 2),
  ('crocodilo-gigante', 'Tail', 'action'::rpg.actor_action_bucket, 8, '18', 'Melee Attack Roll: +8, reach 10 ft. Hit: 18 (3d8 + 5) Bludgeoning damage. If the target is a Large or smaller creature, it has the Prone condition.', 3),
  ('escorpiao-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The scorpion makes two Claw attacks and one Sting attack.', 1),
  ('escorpiao-gigante', 'Claw', 'action'::rpg.actor_action_bucket, 5, '6', 'Melee Attack Roll: +5, reach 5 ft. Hit: 6 (1d6 + 3) Bludgeoning damage. If the target is a Large or smaller creature, it has the Grappled condition (escape DC 13) from one of two claws.', 2),
  ('escorpiao-gigante', 'Sting', 'action'::rpg.actor_action_bucket, 5, '7', 'Melee Attack Roll: +5, reach 5 ft. Hit: 7 (1d8 + 3) Piercing damage plus 11 (2d10) Poison damage.', 3),
  ('falcao-sangrento', 'Beak', 'action'::rpg.actor_action_bucket, 4, '4', 'Melee Attack Roll: +4, reach 5 ft. Hit: 4 (1d4 + 2) Piercing damage, or 6 (1d8 + 2) Piercing damage if the target is Bloodied.', 1),
  ('hiena', 'Bite', 'action'::rpg.actor_action_bucket, 2, '3', 'Melee Attack Roll: +2, reach 5 ft. Hit: 3 (1d6) Piercing damage.', 1),
  ('hiena-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 5, '10', 'Melee Attack Roll: +5, reach 5 ft. Hit: 10 (2d6 + 3) Piercing damage.', 1),
  ('hiena-gigante', 'Rampage (1/Day)', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Immediately after dealing damage to a creature that was already Bloodied, the hyena can move up to half its Speed, and it makes one Bite attack.', 2),
  ('hipopotamo', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The hippopotamus makes two Bite attacks.', 1),
  ('hipopotamo', 'Bite', 'action'::rpg.actor_action_bucket, 7, '16', 'Melee Attack Roll: +7, reach 5 ft. Hit: 16 (2d10 + 5) Piercing damage.', 2),
  ('javali-gigante', 'Gore', 'action'::rpg.actor_action_bucket, 5, '10', 'Melee Attack Roll: +5, reach 5 ft. Hit: 10 (2d6 + 3) Piercing damage. If the target is a Large or smaller creature and the boar moved 20+ feet straight toward it immediately before the hit, the target takes an extra 7 (2d6) Piercing damage and has the Prone condition.', 1),
  ('lagarto-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 4, '6', 'Melee Attack Roll: +4, reach 5 ft. Hit: 6 (1d8 + 2) Piercing damage.', 1),
  ('lula-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The squid makes one Bite attack and one Tentacle attack.', 1),
  ('lula-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 9, '28', 'Melee Attack Roll: +9, reach 5 ft. Hit: 28 (4d10 + 6) Piercing damage.', 2),
  ('lula-gigante', 'Tentacle', 'action'::rpg.actor_action_bucket, 9, '19', 'Melee Attack Roll: +9, reach 15 ft. Hit: 19 (3d8 + 6) Bludgeoning damage. If the target is a Huge or smaller creature, it has the Grappled condition (escape DC 16) from one of two tentacles, and the squid can pull the target up to 10 feet straight toward itself.', 3),
  ('lula-gigante', 'Ink Cloud (1/Day)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Trigger: The squid takes damage while underwater. Response: The squid releases ink that fills a 15-foot Cube centered on itself, and the squid moves up to its Swim Speed. The Cube is Heavily Obscured for 1 minute or until a strong current or similar effect disperses the ink.', 4),
  ('macaco-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The ape makes two Fist attacks.', 1),
  ('macaco-gigante', 'Fist', 'action'::rpg.actor_action_bucket, 9, '22', 'Melee Attack Roll: +9, reach 10 ft. Hit: 22 (3d10 + 6) Bludgeoning damage.', 2),
  ('macaco-gigante', 'Boulder Toss (Recharge 6)', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The ape hurls a boulder at a point it can see within 90 feet. Dexterity Saving Throw: DC 17, each creature in a 5-foot-radius Sphere centered on that point. Failure: 24 (7d6) Bludgeoning damage. If the target is a Large or smaller creature, it has the Prone condition. Success: Half damage only.', 3),
  ('macaco-gigante', 'Leap', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'The ape jumps up to 30 feet by spending 10 feet of movement.', 4),
  ('mamute', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The mammoth makes two Gore attacks.', 1),
  ('mamute', 'Gore', 'action'::rpg.actor_action_bucket, 10, '18', 'Melee Attack Roll: +10, reach 10 ft. Hit: 18 (2d10 + 7) Piercing damage. If the target is a Huge or smaller creature and the mammoth moved 20+ feet straight toward it immediately before the hit, the target has the Prone condition.', 2),
  ('mamute', 'Trample', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'Dexterity Saving Throw: DC 18, one creature within 5 feet that has the Prone condition. Failure: 29 (4d10 + 7) Bludgeoning damage. Success: Half damage.', 3),
  ('morcego-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 5, '6', 'Melee Attack Roll: +5, reach 5 ft. Hit: 6 (1d6 + 3) Piercing damage.', 1),
  ('orca', 'Bite', 'action'::rpg.actor_action_bucket, 6, '21', 'Melee Attack Roll: +6, reach 5 ft. Hit: 21 (5d6 + 4) Piercing damage.', 1),
  ('piranha', 'Bite', 'action'::rpg.actor_action_bucket, 5, '1', 'Melee Attack Roll: +5 (with Advantage if the target doesn’t have all its Hit Points), reach 5 ft. Hit: 1 Piercing damage.', 1),
  ('plessiossauro', 'Bite', 'action'::rpg.actor_action_bucket, 6, '11', 'Melee Attack Roll: +6, reach 10 ft. Hit: 11 (2d6 + 4) Piercing damage.', 1),
  ('polvo-gigante', 'Tentacles', 'action'::rpg.actor_action_bucket, 5, '10', 'Melee Attack Roll: +5, reach 10 ft. Hit: 10 (2d6 + 3) Bludgeoning damage. If the target is a Medium or smaller creature, it has the Grappled condition (escape DC 13) from all eight tentacles. While Grappled, the target has the Restrained condition.', 1),
  ('polvo-gigante', 'Ink Cloud (1/Day)', 'reaction'::rpg.actor_action_bucket, NULL, NULL, 'Trigger: The octopus takes damage while underwater. Response: The octopus releases ink that fills a 10-foot Cube centered on itself, and the octopus moves up to its Swim Speed. The Cube is Heavily Obscured for 1 minute or until a strong current or similar effect disperses the ink.', 2),
  ('pteranodonte', 'Bite', 'action'::rpg.actor_action_bucket, 4, '6', 'Melee Attack Roll: +4, reach 5 ft. Hit: 6 (1d8 + 2) Piercing damage.', 1),
  ('ra-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 3, '5', 'Melee Attack Roll: +3, reach 5 ft. Hit: 5 (1d6 + 2) Piercing damage. If the target is a Medium or smaller creature, it has the Grappled condition (escape DC 11).', 1),
  ('ra-gigante', 'Swallow', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The frog swallows a Small or smaller target it is grappling. While swallowed, the target isn’t Grappled but has the Blinded and Restrained conditions, and it has Total Cover against attacks and other effects outside the frog. While swallowing the target, the frog can’t use Bite, and if the frog dies, the swallowed target is no longer Restrained and can escape from the corpse using 5 feet of movement, exiting with the Prone condition.', 2),
  ('rato-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 5, '5', 'Melee Attack Roll: +5, reach 5 feet. Hit: 5 (1d4 + 3) Piercing damage.', 1),
  ('rinoceronte', 'Gore', 'action'::rpg.actor_action_bucket, 7, '14', 'Melee Attack Roll: +7, reach 5 ft. Hit: 14 (2d8 + 5) Piercing damage. If target is a Large or smaller creature and the rhinoceros moved 20+ feet straight toward it immediately before the hit, the target takes an extra 9 (2d8) Piercing damage and has the Prone condition.', 1),
  ('sapo-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 4, '5', 'Melee Attack Roll: +4, reach 5 ft. Hit: 5 (1d6 + 2) Piercing damage plus 5 (2d4) Poison damage. If the target is a Medium or smaller creature, it has the Grappled condition (escape DC 12).', 1),
  ('sapo-gigante', 'Swallow', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The toad swallows a Medium or smaller target it is grappling. While swallowed, the target isn’t Grappled but has the Blinded and Restrained conditions, and it has Total Cover against attacks and other effects outside the toad. In addition, the target takes 10 (3d6) Acid damage at the end of each of the toad’s turns. The toad can have only one target swallowed at a time, and it can’t use Bite while it has a swallowed target. If the toad dies, a swallowed creature is no longer Restrained and can escape from the corpse using 5 feet of movement, exiting with the Prone condition.', 2),
  ('tigre-dentes-de-sabre', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The tiger makes two Rend attacks.', 1),
  ('tigre-dentes-de-sabre', 'Rend', 'action'::rpg.actor_action_bucket, 6, '11', 'Melee Attack Roll: +6, reach 5 ft. Hit: 11 (2d6 + 4) Slashing damage.', 2),
  ('tigre-dentes-de-sabre', 'Nimble Escape', 'bonus'::rpg.actor_action_bucket, NULL, NULL, 'The tiger takes the Disengage or Hide action.', 3),
  ('tiranossauro', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The tyrannosaurus makes one Bite attack and one Tail attack.', 1),
  ('tiranossauro', 'Bite', 'action'::rpg.actor_action_bucket, 10, '33', 'Melee Attack Roll: +10, reach 10 ft. Hit: 33 (4d12 + 7) Piercing damage. If the target is a Large or smaller creature, it has the Grappled condition (escape DC 17). While Grappled, the target has the Restrained condition and can’t be targeted by the tyrannosaurus’s Tail.', 2),
  ('tiranossauro', 'Tail', 'action'::rpg.actor_action_bucket, 10, '25', 'Melee Attack Roll: +10, reach 15 ft. Hit: 25 (4d8 + 7) Bludgeoning damage. If the target is a Huge or smaller creature, it has the Prone condition.', 3),
  ('triceratops', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The triceratops makes two Gore attacks.', 1),
  ('triceratops', 'Gore', 'action'::rpg.actor_action_bucket, 9, '19', 'Melee Attack Roll: +9, reach 5 ft. Hit: 19 (2d12 + 6) Piercing damage. If the target is Huge or smaller and the triceratops moved 20+ feet straight toward it immediately before the hit, the target takes an extra 9 (2d8) Piercing damage and has the Prone condition.', 2),
  ('tubarao-cacador', 'Bite', 'action'::rpg.actor_action_bucket, 6, '14', 'Melee Attack Roll: +6 (with Advantage if the target doesn’t have all its Hit Points), reach 5 ft. Hit: 14 (3d6 + 4) Piercing damage.', 1),
  ('tubarao-gigante', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The shark makes two Bite attacks.', 1),
  ('tubarao-gigante', 'Bite', 'action'::rpg.actor_action_bucket, 9, '22', 'Melee Attack Roll: +9 (with Advantage if the target doesn’t have all its Hit Points), reach 5 ft. Hit: 22 (3d10 + 6) Piercing damage.', 2),
  ('urso-polar', 'Multiattack', 'action'::rpg.actor_action_bucket, NULL, NULL, 'The bear makes two Rend attacks.', 1),
  ('urso-polar', 'Rend', 'action'::rpg.actor_action_bucket, 7, '9', 'Melee Attack Roll: +7, reach 5 ft. Hit: 9 (1d8 + 5) Slashing damage.', 2),
  ('vespa-gigante', 'Sting', 'action'::rpg.actor_action_bucket, 4, '5', 'Melee Attack Roll: +4, reach 5 ft. Hit: 5 (1d6 + 2) Piercing damage plus 5 (2d4) Poison damage.', 1);

-- Artes MM para bestas já no PHB App. B
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/camelo.png' WHERE slug = 'camelo';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/cobra-constritora.png' WHERE slug = 'cobra-constritora';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/lobo-terrivel.png' WHERE slug = 'lobo-terrivel';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/elefante.png' WHERE slug = 'elefante';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/caranguejo-gigante.png' WHERE slug = 'caranguejo-gigante';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/cabra-gigante.png' WHERE slug = 'cabra-gigante';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/doninha-gigante.png' WHERE slug = 'doninha-gigante';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/aranha-gigante.png' WHERE slug = 'aranha-gigante';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/falcao.png' WHERE slug = 'falcao';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/leao.png' WHERE slug = 'leao';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/polvo.png' WHERE slug = 'polvo';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/coruja.png' WHERE slug = 'coruja';
UPDATE rpg.phb_creature_template SET image_url = '/catalog/beasts/escorpiao.png' WHERE slug = 'escorpiao';

