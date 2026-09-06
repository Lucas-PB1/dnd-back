-- DMG lote §0 #5: resources pool de cargas (1 botão)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'anelEvasaoCharges',
    'Cargas — Anel de Evasão',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-evasao'),
    1
  ),
  (
    'colarPensamentosCharges',
    'Cargas — Colar dos Pensamentos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'colar-dos-pensamentos'),
    1
  ),
  (
    'elmoTeleporteCharges',
    'Cargas — Elmo de Teleporte',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-teleporte'),
    1
  ),
  (
    'gemaVisaoCharges',
    'Cargas — Gema da Visão',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-visao'),
    1
  ),
  (
    'varinhaFarejadoraCharges',
    'Cargas — Varinha Farejadora de Magias',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-farejadora-de-magias'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


