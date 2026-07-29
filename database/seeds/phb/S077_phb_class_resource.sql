-- Seed rpg.phb_class_resource
-- Recursos jogáveis por classe (Fúria, Surto de Ação, Pontos de Foco, etc.)

-- Definições ausentes
INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, class_id, min_level)
VALUES
  (
    'actionSurge',
    'Surto de Ação',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
    2
  ),
  (
    'secondWind',
    'Recuperar Fôlego',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
    1
  ),
  (
    'bardicInspiration',
    'Inspiração de Bardo',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
    1
  )
ON CONFLICT (slug) DO NOTHING;

-- Bárbaro — Fúrias (PHB 2024)
INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
       TRUE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'rage' AND rd.class_id = c.id
CROSS JOIN (VALUES
  (1, 2),
  (3, 3),
  (6, 4),
  (12, 5),
  (17, 6)
) AS v(unlock_level, fixed_max)
WHERE c.slug = 'barbarian'
ON CONFLICT DO NOTHING;

-- Guerreiro — Recuperar Fôlego (= bônus de proficiência)
INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, 1, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       TRUE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'secondWind' AND rd.class_id = c.id
WHERE c.slug = 'fighter'
ON CONFLICT DO NOTHING;

-- Guerreiro — Surto de Ação
INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
       FALSE, TRUE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'actionSurge' AND rd.class_id = c.id
CROSS JOIN (VALUES
  (2, 1),
  (17, 2)
) AS v(unlock_level, fixed_max)
WHERE c.slug = 'fighter'
ON CONFLICT DO NOTHING;

-- Monge — Pontos de Foco (= nível)
INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, 2, 'level'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'focusPoints' AND rd.class_id = c.id
WHERE c.slug = 'monk'
ON CONFLICT DO NOTHING;

-- Bardo — Inspiração (mod. Carisma)
INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, 1, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'bardicInspiration' AND rd.class_id = c.id
WHERE c.slug = 'bard'
ON CONFLICT DO NOTHING;

-- Clérigo / Paladino — Canalizar Divindade
INSERT INTO rpg.phb_class_resource (
  class_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT c.id, rd.id, 2, 'fixed'::rpg.resource_max_formula, 0,
       TRUE, FALSE, TRUE
FROM rpg.phb_class c
CROSS JOIN rpg.phb_resource_definition rd
WHERE rd.slug = 'channelDivinity'
  AND c.slug IN ('cleric', 'paladin')
ON CONFLICT DO NOTHING;
