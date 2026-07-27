-- Recursos de classe jogáveis (cota por nível)

CREATE TABLE IF NOT EXISTS rpg.phb_class_resource (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  resource_id BIGINT NOT NULL REFERENCES rpg.phb_resource_definition(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  max_formula rpg.resource_max_formula NOT NULL,
  fixed_max INTEGER CHECK (fixed_max IS NULL OR fixed_max >= 0),
  recover_one_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_long BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (class_id, resource_id, unlock_level),
  CONSTRAINT pcr_formula_fixed CHECK (
    (max_formula = 'fixed' AND fixed_max IS NOT NULL)
    OR (max_formula <> 'fixed' AND fixed_max IS NULL)
  )
);

CREATE INDEX IF NOT EXISTS idx_phb_class_resource_class
  ON rpg.phb_class_resource(class_id);

-- Definições ausentes (além de rage / channelDivinity / focusPoints)
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

-- Bardo — Inspiração (mod. Carisma, mín. 1)
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

-- Clérigo / Paladino — Canalizar (max vem de progression.channel_divinity)
-- slug é UNIQUE: reutiliza a definição do Clérigo
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
