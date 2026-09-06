-- Recursos jogáveis do Perseguidor Aracnídeo (Valdas)
-- Correia conjura Teia sem espaço de magia: 2 usos, 1 no Curto e todos no Longo.
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'arachnoid-web',
  'Teia',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



UPDATE rpg.phb_subclass_feature
SET feature_kind = 'resource'::rpg.subclass_feature_kind
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arachnoid-stalker')
  AND level = 3
  AND name = 'Correia';
