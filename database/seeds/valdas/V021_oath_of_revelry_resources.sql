-- Recursos jogáveis do Juramento da Folia (Valdas)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'reveler',
  'Folião',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  15
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'party-animal',
  'Animal de Festa',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry'),
  20
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;





UPDATE rpg.phb_subclass_feature
SET feature_kind = 'resource'::rpg.subclass_feature_kind
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry')
  AND level = 15
  AND name = 'Folião';

UPDATE rpg.phb_subclass_feature
SET feature_kind = 'resource'::rpg.subclass_feature_kind
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-revelry')
  AND level = 20
  AND name = 'Animal de festa';
