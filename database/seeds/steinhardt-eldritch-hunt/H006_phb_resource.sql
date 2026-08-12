-- Recursos jogáveis — Steinhardt Eldritch Hunt subclasses

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  (
    'blood-strike',
    'Golpe de Sangue',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blood-hound'),
    3
  ),
  (
    'torturer-technique',
    'Técnica do Torturador',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
    3
  ),
  (
    'veil-of-pain',
    'Véu de Dor',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'torturer-conclave'),
    11
  ),
  (
    'divine-points',
    'Pontos Divinos',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
    3
  ),
  (
    'perfect-hunter',
    'Caçador Perfeito',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-eldritch-hunt'),
    20
  ),
  (
    'brittle-bone-armor',
    'Armadura de Osso Frágil',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
    3
  ),
  (
    'bone-puppetry',
    'Marionetismo Ósseo',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'osteomancer'),
    6
  ),
  (
    'final-judgement-spirits',
    'Espíritos Divinos',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'blade-of-radiance'),
    17
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

-- Blood Strike: regras = 1 + CON; enum mais próximo = constitution_mod (mín. 1 no runtime)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3, 'constitution_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'blood-strike'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Golpe de Sangue'
WHERE s.slug = 'blood-hound'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Torturer: 6 técnicas × 2 usos = pool compartilhado 12 (SSOT aproximado; 1 gasto = 1 uso de técnica)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3, 'fixed'::rpg.resource_max_formula, 12, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'torturer-technique'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Técnicas do Torturador'
WHERE s.slug = 'torturer-conclave'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 11, 'wisdom_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'veil-of-pain'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Véu de Dor'
WHERE s.slug = 'torturer-conclave'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3, 'wisdom_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'divine-points'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Bênçãos Divinas'
WHERE s.slug = 'blade-of-radiance'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'perfect-hunter'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Caçador Perfeito'
WHERE s.slug = 'oath-of-the-eldritch-hunt'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'brittle-bone-armor'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Armadura de Osso Frágil'
WHERE s.slug = 'osteomancer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 6, 'intelligence_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'bone-puppetry'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Marionetismo Ósseo'
WHERE s.slug = 'osteomancer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 17, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'final-judgement-spirits'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Julgamento Final'
WHERE s.slug = 'blade-of-radiance'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
