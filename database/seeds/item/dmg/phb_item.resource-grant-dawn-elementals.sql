-- DMG lote §0 #4b: resources 1×/amanhecer (elementais)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'braseiroFogoUse',
    'Braseiro · Elemental do Fogo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'braseiro-de-comandar-elementais-do-fogo'),
    1
  ),
  (
    'incensarioArUse',
    'Incensário · Elemental do Ar',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'incensario-de-controlar-elementais-do-ar'),
    1
  ),
  (
    'pedraTerraUse',
    'Pedra · Elemental da Terra',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'pedra-de-controlar-elementais-da-terra'),
    1
  ),
  (
    'tigelaAguaUse',
    'Tigela · Elemental da Água',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tigela-de-comandar-elementais-da-agua'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


