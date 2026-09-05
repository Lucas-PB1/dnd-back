-- DMG lote §0 #4: resources 1×/amanhecer (MVP: recover no Descanso Longo)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'amuletoMecanicoUse',
    'Amuleto Mecânico',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-mecanico'),
    1
  ),
  (
    'diademaExplosaoUse',
    'Diadema da Explosão',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'diadema-da-explosao'),
    1
  ),
  (
    'periaptSaudeUse',
    'Periapto de Saúde',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'periapto-de-saude'),
    1
  ),
  (
    'perolaPoderUse',
    'Pérola de Poder',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'perola-de-poder'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


