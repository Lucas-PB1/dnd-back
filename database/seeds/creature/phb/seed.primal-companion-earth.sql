-- Placeholder: template Primal Companion Terra (Beast Master) — stats mínimos para spawn/teste
-- Substituir quando dados completos do projetinho chegarem.

INSERT INTO rpg.phb_creature_template (
  slug,
  edition_slug,
  name,
  creature_type,
  size_slug,
  challenge_rating,
  proficiency_bonus,
  armor_class,
  hit_points_avg
)
VALUES (
  'primal-companion-earth',
  'phb-2024-pt',
  'Companheiro Primal (Terra)',
  'Beast',
  'medium',
  NULL,
  2,
  13,
  5
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft)
VALUES ('primal-companion-earth', 'walk', 40)
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, sort_order
)
SELECT
  'primal-companion-earth',
  'Golpe da Fera',
  'action'::rpg.actor_action_bucket,
  4,
  '1d8+2',
  1
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_creature_template_action
  WHERE template_slug = 'primal-companion-earth' AND name = 'Golpe da Fera'
);
