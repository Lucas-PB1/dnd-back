-- Veículos PHB 2024 — stats de equipamento (S031_phb_item.json large-vehicle)
-- Deslocamento: speed_ft = mph × 10; movement_kind vela|remo|ar (ver formatTemplateSpeeds no front)

INSERT INTO rpg.phb_vehicle_template (
  slug, edition_slug, name, armor_class, hit_points, damage_threshold,
  crew_capacity, cargo_capacity_lb
)
VALUES
  (
    'bote',
    'phb-2024-pt',
    'Bote',
    11,
    50,
    NULL,
    1,
    NULL
  ),
  (
    'barco-de-quilha',
    'phb-2024-pt',
    'Barco de Quilha',
    15,
    100,
    10,
    1,
    1000
  ),
  (
    'navio-longo',
    'phb-2024-pt',
    'Navio Longo',
    15,
    300,
    15,
    40,
    20000
  ),
  (
    'navio-a-vela',
    'phb-2024-pt',
    'Navio a Vela',
    15,
    300,
    15,
    20,
    200000
  ),
  (
    'navio-de-guerra',
    'phb-2024-pt',
    'Navio de Guerra',
    15,
    500,
    20,
    60,
    400000
  ),
  (
    'galera',
    'phb-2024-pt',
    'Galera',
    15,
    500,
    20,
    80,
    300000
  ),
  (
    'aeronave',
    'phb-2024-pt',
    'Aeronave',
    13,
    300,
    NULL,
    10,
    2000
  )
ON CONFLICT (slug) DO NOTHING;

-- Deslocamentos (mph × 10 em speed_ft)
INSERT INTO rpg.phb_vehicle_template_speed (template_slug, movement_kind, speed_ft)
VALUES
  ('bote', 'remo', 15),
  ('barco-de-quilha', 'remo', 10),
  ('navio-longo', 'vela', 30),
  ('navio-longo', 'remo', 30),
  ('navio-a-vela', 'vela', 20),
  ('navio-de-guerra', 'vela', 25),
  ('galera', 'vela', 40),
  ('galera', 'remo', 40),
  ('aeronave', 'ar', 80)
ON CONFLICT DO NOTHING;

-- Ações genéricas de combate naval (DMG / mesa — placeholders até armas detalhadas)
INSERT INTO rpg.phb_vehicle_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, sort_order
)
SELECT v.slug, v.name, v.bucket::rpg.actor_action_bucket, v.bonus::int, v.damage, v.ord
FROM (VALUES
  ('navio-longo', 'Aríete', 'action', NULL::int, '4d10+6', 1),
  ('navio-de-guerra', 'Aríete', 'action', NULL::int, '4d10+10', 1),
  ('galera', 'Aríete', 'action', NULL::int, '4d10+10', 1)
) AS v(slug, name, bucket, bonus, damage, ord)
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_vehicle_template_action a
  WHERE a.template_slug = v.slug AND a.name = v.name
);
