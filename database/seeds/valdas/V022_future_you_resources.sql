-- Recursos jogáveis do patrono Eu do Futuro (Valdas)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'happened-this-way',
  'Aconteceu assim',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'fewer-scars',
  'Menos cicatrizes',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  6
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'grandfather-paradox',
  'Paradoxo do Avô',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron'),
  14
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;







UPDATE rpg.phb_subclass_feature
SET feature_kind = 'resource'::rpg.subclass_feature_kind
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'future-you-patron')
  AND name IN (
    'Aconteceu assim',
    'Eu poderia fazer com menos cicatrizes',
    'Paradoxo do Avô'
  );
