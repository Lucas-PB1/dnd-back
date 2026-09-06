-- Recursos de itens Valdas (após V010). Itens PP2 → P013.
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  ('ringBarrelCharges', 'Cargas do Anel dos Barris', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'ring-of-barrels'), 1),
  ('frogPrinceUse', 'Estatueta do Príncipe Sapo', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'frog-prince-statuette'), 1),
  ('throneFeast', 'Banquete do Trono', 'item'::rpg.resource_scope, (SELECT id FROM rpg.phb_item WHERE slug = 'leonora-s-throne-of-indolence'), 1)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


