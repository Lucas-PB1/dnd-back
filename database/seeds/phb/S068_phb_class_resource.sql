-- Seed rpg.phb_resource_grant (owner_kind=class)
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
    'indomitable',
    'Indomável',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
    9
  ),
  (
    'bardicInspiration',
    'Inspiração de Bardo',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
    1
  ),
  (
    'strokeOfLuck',
    'Golpe de Sorte',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
    20
  ),
  (
    'layOnHands',
    'Mãos Consagradas',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
    1
  ),
  (
    'favoredEnemy',
    'Inimigo Favorito',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
    1
  ),
  (
    'tireless',
    'Incansável',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
    10
  ),
  (
    'naturesVeil',
    'Véu da Natureza',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
    14
  ),
  (
    'divineIntervention',
    'Intervenção Divina',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
    10
  ),
  (
    'magical-cunning',
    'Astúcia Mágica',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
    2
  ),
  (
    'sorceryPoints',
    'Pontos de Feitiçaria',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
    2
  ),
  (
    'innate-sorcery',
    'Feitiçaria Inata',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
    1
  ),
  (
    'sorcerous-restoration',
    'Restauração Feiticeira',
    'class'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
    5
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  class_id = EXCLUDED.class_id,
  min_level = EXCLUDED.min_level;

-- Bárbaro — Fúrias (PHB 2024)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
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

-- Guerreiro — Recuperar Fôlego (coluna PHB 2024: 2 → 3 → 4)
DELETE FROM rpg.phb_resource_grant rg
USING rpg.phb_class c, rpg.phb_resource_definition rd
WHERE rg.owner_kind = 'class'
  AND rg.owner_id = c.id
  AND rg.resource_id = rd.id
  AND c.slug = 'fighter'
  AND rd.slug = 'secondWind';

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
       TRUE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'secondWind' AND rd.class_id = c.id
CROSS JOIN (VALUES
  (1, 2),
  (4, 3),
  (10, 4)
) AS v(unlock_level, fixed_max)
WHERE c.slug = 'fighter'
ON CONFLICT DO NOTHING;

-- Guerreiro — Surto de Ação
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
       FALSE, TRUE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'actionSurge' AND rd.class_id = c.id
CROSS JOIN (VALUES
  (2, 1),
  (17, 2)
) AS v(unlock_level, fixed_max)
WHERE c.slug = 'fighter'
ON CONFLICT DO NOTHING;

-- Guerreiro — Indomável
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, v.unlock_level, 'fixed'::rpg.resource_max_formula, v.fixed_max,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'indomitable' AND rd.class_id = c.id
CROSS JOIN (VALUES
  (9, 1),
  (13, 2),
  (17, 3)
) AS v(unlock_level, fixed_max)
WHERE c.slug = 'fighter'
ON CONFLICT DO NOTHING;

-- Monge — Pontos de Foco (= nível)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 2, 'level'::rpg.resource_max_formula, NULL,
       FALSE, TRUE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'focusPoints' AND rd.class_id = c.id
WHERE c.slug = 'monk'
ON CONFLICT DO NOTHING;

-- Bardo — Inspiração (mod. Carisma)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 1, 'charisma_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'bardicInspiration' AND rd.class_id = c.id
WHERE c.slug = 'bard'
ON CONFLICT DO NOTHING;

-- Ladino — Golpe de Sorte (recupera em Descanso Curto ou Longo)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 20, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'strokeOfLuck' AND rd.class_id = c.id
WHERE c.slug = 'rogue'
ON CONFLICT DO NOTHING;

-- Clérigo / Paladino — Canalizar Divindade
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 2, 'fixed'::rpg.resource_max_formula, 0,
       TRUE, FALSE, TRUE
FROM rpg.phb_class c
CROSS JOIN rpg.phb_resource_definition rd
WHERE rd.slug = 'channelDivinity'
  AND c.slug IN ('cleric', 'paladin')
ON CONFLICT DO NOTHING;

-- Clérigo — Intervenção Divina (1× por Descanso Longo)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 10, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd
  ON rd.slug = 'divineIntervention' AND rd.class_id = c.id
WHERE c.slug = 'cleric'
ON CONFLICT DO NOTHING;

-- Paladino — Mãos Consagradas (pool = 5 × nível; máximo ajustado no runtime)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 1, 'fixed'::rpg.resource_max_formula, 0,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'layOnHands' AND rd.class_id = c.id
WHERE c.slug = 'paladin'
ON CONFLICT DO NOTHING;

-- Guardião — Inimigo Favorito (usos gratuitos de Marca do Predador = PB)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 1, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'favoredEnemy' AND rd.class_id = c.id
WHERE c.slug = 'ranger'
ON CONFLICT DO NOTHING;

-- Guardião — Incansável (usos = mod. Sabedoria)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 10, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'tireless' AND rd.class_id = c.id
WHERE c.slug = 'ranger'
ON CONFLICT DO NOTHING;

-- Guardião — Véu da Natureza (usos = mod. Sabedoria)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 14, 'wisdom_mod'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'naturesVeil' AND rd.class_id = c.id
WHERE c.slug = 'ranger'
ON CONFLICT DO NOTHING;

-- Bruxo — Astúcia Mágica (1×/DL)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 2, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'magical-cunning' AND rd.class_id = c.id
WHERE c.slug = 'warlock'
ON CONFLICT DO NOTHING;

-- Feiticeiro — Pontos de Feitiçaria (máx = nível, a partir do nv 2)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 2, 'level'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'sorceryPoints' AND rd.class_id = c.id
WHERE c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

-- Feiticeiro — Feitiçaria Inata (2×/DL)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 1, 'fixed'::rpg.resource_max_formula, 2,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'innate-sorcery' AND rd.class_id = c.id
WHERE c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;

-- Feiticeiro — Restauração Feiticeira (1×/DL)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT 'class'::rpg.resource_owner_kind, c.id, rd.id, 5, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM rpg.phb_class c
JOIN rpg.phb_resource_definition rd ON rd.slug = 'sorcerous-restoration' AND rd.class_id = c.id
WHERE c.slug = 'sorcerer'
ON CONFLICT DO NOTHING;
