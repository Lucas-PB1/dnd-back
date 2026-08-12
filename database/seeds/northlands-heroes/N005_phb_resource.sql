-- Recursos jogáveis — Northlands Heroes of the Sagas

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  (
    'norn-skeins',
    'Fios (Skeins)',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'),
    3
  ),
  (
    'battle-sagas',
    'Sagas de Batalha',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'),
    14
  ),
  (
    'marauders-reprisal',
    'Represália do Saqueador',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'),
    15
  ),
  (
    'unstoppable-assault',
    'Assalto Imparável',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'),
    18
  ),
  (
    'spirit-of-the-valkyrie',
    'Espírito da Valquíria',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'),
    20
  ),
  (
    'spirit-guidance',
    'Orientação Espiritual',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
    3
  ),
  (
    'spirit-aura',
    'Aura Espiritual',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
    6
  ),
  (
    'spirit-secrets',
    'Segredos Espirituais',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
    14
  ),
  (
    'context-switch',
    'Troca de Contexto',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'),
    3
  ),
  (
    'harbinger-of-chaos',
    'Arauto do Caos',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'),
    14
  ),
  (
    'children-of-great-wolf',
    'Filhos do Grande Lobo',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'),
    14
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

-- Nornbound: 2 fios / Descanso Longo
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3, 'fixed'::rpg.resource_max_formula, 2, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'norn-skeins'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Ajustar a Teia'
WHERE s.slug = 'nornbound'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Skald: Sagas 1× / Descanso Curto ou Longo
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'battle-sagas'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Sagas de Batalha'
WHERE s.slug = 'skald'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Viking: Represália = PB / DL
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 15, 'proficiency_bonus'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'marauders-reprisal'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Represália do Saqueador'
WHERE s.slug = 'viking'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Viking: Assalto Imparável 1× / DL
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'unstoppable-assault'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Assalto Imparável'
WHERE s.slug = 'viking'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Valhalla: Espírito da Valquíria 1× / DL
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'spirit-of-the-valkyrie'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Espírito da Valquíria'
WHERE s.slug = 'oath-of-valhalla'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Spirit Caller: Orientação = mod. Carisma
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3, 'charisma_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'spirit-guidance'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Orientação Espiritual'
WHERE s.slug = 'spirit-caller'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Spirit Caller: Aura 2× / DL
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 6, 'fixed'::rpg.resource_max_formula, 2, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'spirit-aura'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Aura Espiritual'
WHERE s.slug = 'spirit-caller'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Spirit Caller: Segredos = mod. Carisma
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 14, 'charisma_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'spirit-secrets'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Segredos Espirituais'
WHERE s.slug = 'spirit-caller'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Trickster: Troca de Contexto = mod. Carisma
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3, 'charisma_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'context-switch'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Troca de Contexto'
WHERE s.slug = 'trickster'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Trickster: Arauto do Caos 1× / Descanso Curto
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'harbinger-of-chaos'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Arauto do Caos'
WHERE s.slug = 'trickster'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

-- Fenris: Filhos do Grande Lobo 1× / dia (DL)
INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'children-of-great-wolf'
LEFT JOIN rpg.phb_subclass_feature sf
  ON sf.subclass_id = s.id AND sf.name = 'Filhos do Grande Lobo'
WHERE s.slug = 'circle-of-fenris'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula,
  fixed_max = EXCLUDED.fixed_max,
  feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short,
  recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
