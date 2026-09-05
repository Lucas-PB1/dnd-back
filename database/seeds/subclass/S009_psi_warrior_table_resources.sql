-- Uso gratuito por descanso do Movimento Telecinético.
-- Repetições podem gastar um Dado de Energia Psiônica pela ação da ficha.
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (
  slug, name, scope, subclass_id, min_level
)
VALUES (
  'telekinetic-movement',
  'Movimento Telecinético',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;


