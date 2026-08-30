-- DMG §0 #9c: resources + passivo Pedra da Boa Sorte
-- Ver docs/source/extracts/dmg/wiring-status.md

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

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'item'::rpg.resource_owner_kind,
  i.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  v.fixed_max,
  FALSE,
  FALSE,
  TRUE
FROM (VALUES
  ('cubo-energetico', 'cuboEnergeticoCharges', 10),
  ('cubo-portal', 'cuboPortalCharges', 3),
  ('bolsa-de-temperos-prestativa-de-howard', 'bolsaTemperosCharges', 10)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

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
