-- Recursos de combate — Caminho da Glaciar (piloto GSB Book One)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'glacier-rage-extension',
  'Extensão de Fúria',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;


