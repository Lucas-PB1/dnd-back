-- DMG §0 #8c: resources cajados simples (1 botão + Sortilégios)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cajadoFloresCharges',
    'Cargas — Cajado de Flores',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-de-flores'),
    1
  ),
  (
    'cajadoAvicularCharges',
    'Cargas — Cajado Avicular',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-avicular'),
    1
  ),
  (
    'cajadoDefinhamentoCharges',
    'Cargas — Cajado do Definhamento',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-definhamento'),
    1
  ),
  (
    'cajadoSortilegiosCharges',
    'Cargas — Cajado dos Sortilégios',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'),
    1
  ),
  (
    'cajadoSortilegiosResistUse',
    'Resistir Encantamento — Cajado dos Sortilégios',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-sortilegios'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


