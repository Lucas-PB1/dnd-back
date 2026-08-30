-- Recursos de combate — Griffon's Saddlebag Book One (11 subclasses restantes)

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  ('planar-reach', 'Alcance Planar', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 3),
  ('mercy-dice', 'Dados de Misericórdia', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 3),
  ('magic-snare', 'Armadilha Mágica', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'), 11),
  ('rune-points', 'Pontos de Runa', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 3),
  ('astral-clarity', 'Clareza Astral', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 10),
  ('burning-spirit', 'Espírito Flamejante', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'), 20),
  ('cube-detonation', 'Detonação de Cubo', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 3),
  ('rematerialize', 'Rematerializar', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 14)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3,
  'wisdom_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'planar-reach'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Alcance Planar'
WHERE s.slug = 'astral-domain'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3,
  'fixed'::rpg.resource_max_formula, 5, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'mercy-dice'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Agente de Misericórdia'
WHERE s.slug = 'couatl-herald'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 11,
  'wisdom_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'magic-snare'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Armadilha Mágica'
WHERE s.slug = 'winter-trapper'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3,
  'fixed'::rpg.resource_max_formula, 4, sf.id,
  FALSE, TRUE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'rune-points'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Runas'
WHERE s.slug = 'runetagger'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 10,
  'charisma_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'astral-clarity'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Maestria Extradimensional'
WHERE s.slug = 'astral-griffon-patron'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 20,
  'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'burning-spirit'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Espírito Flamejante'
WHERE s.slug = 'oath-of-the-hearth'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 3,
  'intelligence_mod'::rpg.resource_max_formula, NULL, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'cube-detonation'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Criação Menor'
WHERE s.slug = 'materializer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max, feature_id,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'subclass'::rpg.resource_owner_kind, s.id, rd.id, 14,
  'fixed'::rpg.resource_max_formula, 1, sf.id,
  FALSE, FALSE, TRUE
FROM rpg.phb_subclass s
JOIN rpg.phb_resource_definition rd ON rd.slug = 'rematerialize'
LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id AND sf.name = 'Rematerializar'
WHERE s.slug = 'materializer'
ON CONFLICT (owner_kind, owner_id, resource_id, unlock_level) DO UPDATE SET
  max_formula = EXCLUDED.max_formula, fixed_max = EXCLUDED.fixed_max, feature_id = EXCLUDED.feature_id,
  recover_one_on_short = EXCLUDED.recover_one_on_short, recover_all_on_short = EXCLUDED.recover_all_on_short,
  recover_all_on_long = EXCLUDED.recover_all_on_long;
