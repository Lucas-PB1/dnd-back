-- Templates de Companheiro Primal (Beast Master + Espírito Primal GH)
-- Placeholder com stats mínimos — substituir quando blocos completos estiverem no catálogo.

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg
)
VALUES
  ('primal-companion-sky', 'phb-2024-pt', 'Companheiro Primal (Céu)', 'Beast', 'medium', NULL, 2, 13, 5),
  ('primal-companion-sea', 'phb-2024-pt', 'Companheiro Primal (Mar)', 'Beast', 'medium', NULL, 2, 13, 5),
  ('primal-companion-guardian-land', 'phb-2024-pt', 'Guardião Primal (Terra)', 'Beast', 'medium', NULL, 2, 14, 8),
  ('primal-companion-guardian-sea', 'phb-2024-pt', 'Guardião Primal (Mar)', 'Beast', 'medium', NULL, 2, 14, 8),
  ('primal-companion-guardian-sky', 'phb-2024-pt', 'Guardião Primal (Céu)', 'Beast', 'medium', NULL, 2, 14, 8),
  ('primal-companion-striker-land', 'phb-2024-pt', 'Atacante Primal (Terra)', 'Beast', 'medium', NULL, 2, 13, 6),
  ('primal-companion-striker-sea', 'phb-2024-pt', 'Atacante Primal (Mar)', 'Beast', 'medium', NULL, 2, 13, 6),
  ('primal-companion-striker-sky', 'phb-2024-pt', 'Atacante Primal (Céu)', 'Beast', 'medium', NULL, 2, 13, 6)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft)
SELECT slug, 'walk', speed
FROM (VALUES
  ('primal-companion-sky', 40),
  ('primal-companion-sea', 30),
  ('primal-companion-guardian-land', 30),
  ('primal-companion-guardian-sea', 30),
  ('primal-companion-guardian-sky', 40),
  ('primal-companion-striker-land', 40),
  ('primal-companion-striker-sea', 30),
  ('primal-companion-striker-sky', 50)
) AS v(slug, speed)
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_creature_template_speed s
  WHERE s.template_slug = v.slug AND s.movement_kind = 'walk'
);

INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, sort_order
)
SELECT slug, 'Golpe da Fera', 'action'::rpg.actor_action_bucket, bonus, damage, 1
FROM (VALUES
  ('primal-companion-sky', 4, '1d8+2'),
  ('primal-companion-sea', 4, '1d8+2'),
  ('primal-companion-guardian-land', 4, '1d8+3'),
  ('primal-companion-guardian-sea', 4, '1d8+3'),
  ('primal-companion-guardian-sky', 4, '1d8+3'),
  ('primal-companion-striker-land', 5, '1d8+3'),
  ('primal-companion-striker-sea', 5, '1d8+3'),
  ('primal-companion-striker-sky', 5, '1d8+3')
) AS v(slug, bonus, damage)
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_creature_template_action a
  WHERE a.template_slug = v.slug AND a.name = 'Golpe da Fera'
);
