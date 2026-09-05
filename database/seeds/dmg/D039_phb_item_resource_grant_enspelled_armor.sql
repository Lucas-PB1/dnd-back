-- Fase 6: Armadura Magificada — pool de cargas
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats
INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'armaduraMagificadaCharges',
    'Cargas — Armadura Magificada',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'armadura-magificada'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


