-- DMG §0 #9g: resources maravilhosos finais fáceis + anéis
-- Ver docs/source/extracts/dmg/wiring-status.md
-- anelTresDesejosCharges: sem recuperação (consome o anel)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'chapeuMagosTruqueUse',
    'Truque Desconhecido — Chapéu dos Magos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-magos'),
    1
  ),
  (
    'pocoMundosUse',
    'Portal — Poço dos Mundos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'poco-dos-mundos'),
    1
  ),
  (
    'gemaClaridadeCharges',
    'Cargas — Gema da Claridade',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'gema-da-claridade'),
    1
  ),
  (
    'anelTresDesejosCharges',
    'Cargas — Anel dos Três Desejos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-dos-tres-desejos'),
    1
  ),
  (
    'anelInfluenciarAnimaisCharges',
    'Cargas — Anel de Influenciar Animais',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-influenciar-animais'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


