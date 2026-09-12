-- Espírito Primal (Grim Hollow) — Guardião / Atacante × Terra / Mar / Céu
-- Blocos completos GH ainda não extractados: escala provisória alinhada ao padrão Beast Master
-- (HP base+nível; AC base + Sabedoria do conjurador). Ajustar quando o extract chegar.

INSERT INTO rpg.phb_creature_template (
  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,
  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,
  initiative_modifier, ability_scores,
  companion_hp_base, companion_hp_per_level, companion_ac_ability_slug
)
VALUES
  (
    'primal-companion-guardian-land', 'phb-2024-pt', 'Guardião Primal (Terra)',
    'Média Fera, Neutro', 'Neutro', 'Beast', 'medium', NULL, 2, 14, 13,
    '8 + 5 × nível (provisório GH)', 2,
    '{"forca":15,"destreza":12,"constituicao":16,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb,
    8, 5, 'sabedoria'
  ),
  (
    'primal-companion-guardian-sea', 'phb-2024-pt', 'Guardião Primal (Mar)',
    'Média Fera, Neutro', 'Neutro', 'Beast', 'medium', NULL, 2, 14, 13,
    '8 + 5 × nível (provisório GH)', 2,
    '{"forca":15,"destreza":12,"constituicao":16,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb,
    8, 5, 'sabedoria'
  ),
  (
    'primal-companion-guardian-sky', 'phb-2024-pt', 'Guardião Primal (Céu)',
    'Média Fera, Neutro', 'Neutro', 'Beast', 'medium', NULL, 2, 14, 13,
    '8 + 5 × nível (provisório GH)', 3,
    '{"forca":12,"destreza":15,"constituicao":14,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb,
    8, 5, 'sabedoria'
  ),
  (
    'primal-companion-striker-land', 'phb-2024-pt', 'Atacante Primal (Terra)',
    'Média Fera, Neutro', 'Neutro', 'Beast', 'medium', NULL, 2, 13, 11,
    '6 + 5 × nível (provisório GH)', 2,
    '{"forca":14,"destreza":16,"constituicao":14,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb,
    6, 5, 'sabedoria'
  ),
  (
    'primal-companion-striker-sea', 'phb-2024-pt', 'Atacante Primal (Mar)',
    'Média Fera, Neutro', 'Neutro', 'Beast', 'medium', NULL, 2, 13, 11,
    '6 + 5 × nível (provisório GH)', 2,
    '{"forca":14,"destreza":16,"constituicao":14,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb,
    6, 5, 'sabedoria'
  ),
  (
    'primal-companion-striker-sky', 'phb-2024-pt', 'Atacante Primal (Céu)',
    'Média Fera, Neutro', 'Neutro', 'Beast', 'medium', NULL, 2, 13, 11,
    '6 + 5 × nível (provisório GH)', 3,
    '{"forca":10,"destreza":18,"constituicao":12,"inteligencia":6,"sabedoria":12,"carisma":8}'::jsonb,
    6, 5, 'sabedoria'
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  subtitle = EXCLUDED.subtitle,
  alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type,
  size_slug = EXCLUDED.size_slug,
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class,
  hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier,
  ability_scores = EXCLUDED.ability_scores,
  companion_hp_base = EXCLUDED.companion_hp_base,
  companion_hp_per_level = EXCLUDED.companion_hp_per_level,
  companion_ac_ability_slug = EXCLUDED.companion_ac_ability_slug;

DELETE FROM rpg.phb_creature_template_speed
WHERE template_slug LIKE 'primal-companion-guardian-%'
   OR template_slug LIKE 'primal-companion-striker-%';

INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft)
VALUES
  ('primal-companion-guardian-land', 'walk', 30),
  ('primal-companion-guardian-sea', 'walk', 5),
  ('primal-companion-guardian-sea', 'swim', 40),
  ('primal-companion-guardian-sky', 'walk', 10),
  ('primal-companion-guardian-sky', 'fly', 50),
  ('primal-companion-striker-land', 'walk', 40),
  ('primal-companion-striker-sea', 'walk', 5),
  ('primal-companion-striker-sea', 'swim', 50),
  ('primal-companion-striker-sky', 'walk', 10),
  ('primal-companion-striker-sky', 'fly', 60);

DELETE FROM rpg.phb_creature_template_action
WHERE (template_slug LIKE 'primal-companion-guardian-%'
    OR template_slug LIKE 'primal-companion-striker-%')
  AND name IN ('Golpe da Fera', 'Golpe da Besta');

INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, sort_order
)
SELECT slug, 'Golpe da Besta', 'action'::rpg.actor_action_bucket, NULL::int, damage, 1
FROM (VALUES
  ('primal-companion-guardian-land', '1d8+3'),
  ('primal-companion-guardian-sea', '1d8+3'),
  ('primal-companion-guardian-sky', '1d8+3'),
  ('primal-companion-striker-land', '1d8+3'),
  ('primal-companion-striker-sea', '1d8+3'),
  ('primal-companion-striker-sky', '1d8+3')
) AS v(slug, damage);
