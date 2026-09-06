-- DMG §0 #9c: resources + passivo Pedra da Boa Sorte
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cuboEnergeticoCharges',
    'Cargas — Cubo Energético',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-energetico'),
    1
  ),
  (
    'cuboPortalCharges',
    'Cargas — Cubo Portal',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-portal'),
    1
  ),
  (
    'bolsaTemperosCharges',
    'Cargas — Bolsa de Temperos Prestativa de Howard',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-de-temperos-prestativa-de-howard'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;



UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "savingThrowBonuses": {
      "forca": 1,
      "destreza": 1,
      "constituicao": 1,
      "inteligencia": 1,
      "sabedoria": 1,
      "carisma": 1
    }
  }
}'::jsonb
WHERE slug = 'pedra-da-boa-sorte-pedra-da-sorte';
