-- Treasure Cap. 7: CD fixa + regra de círculo no cast de item (SSOT em properties).
-- Overlay em D010 (gerado) — não editar D010 à mão.

-- Varinhas: 1 carga = círculo base; extras sobem o círculo; CD 15.
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || jsonb_build_object(
  'spellSaveDc', 15,
  'itemCastSlotRule', jsonb_build_object('mode', 'charge-upcast')
)
WHERE slug IN ('varinha-de-relampagos', 'varinha-cuspidora-de-fogo');

-- Artefatos / itens com CD fixa no texto.
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"spellSaveDc":18}'::jsonb
WHERE slug IN ('varinha-de-orcus', 'orbes-draconicos');

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"spellSaveDc":20}'::jsonb
WHERE slug = 'onda';

-- Círculo forçado por resource (Onda Globo 9º; Órbes Curar 9º com 4 cargas).
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || jsonb_build_object(
  'itemCastSlotRules',
  jsonb_build_object(
    'ondaGloboUse',
    jsonb_build_object('mode', 'fixed', 'slotLevel', 9)
  )
)
WHERE slug = 'onda';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || jsonb_build_object(
  'itemCastSlotRules',
  jsonb_build_object(
    'orbesDraconicosCharges',
    jsonb_build_object(
      'mode', 'fixed-by-spend',
      'spendAmount', 4,
      'spellLevel', 1,
      'slotLevel', 9
    )
  )
)
WHERE slug = 'orbes-draconicos';
