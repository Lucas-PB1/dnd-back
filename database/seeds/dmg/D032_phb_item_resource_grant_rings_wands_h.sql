-- DMG §0 #9h: resources anéis finais + varinhas lote 2
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Cast real / link de magia = fase 6
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'anelArieteCharges',
    'Cargas — Anel de Ariete',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-ariete'),
    1
  ),
  (
    'anelDjinniUse',
    'Invocar Djinni — Anel',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-invocar-djinni'),
    1
  ),
  (
    'anelComandoElementalCharges',
    'Cargas — Anel de Comando Elemental',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'anel-de-comando-elemental'),
    1
  ),
  (
    'varinhaSegredosCharges',
    'Cargas — Varinha dos Segredos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-dos-segredos'),
    1
  ),
  (
    'varinhaTeiaCharges',
    'Cargas — Varinha de Teia',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-teia'),
    1
  ),
  (
    'varinhaPolimorfiaCharges',
    'Cargas — Varinha de Polimorfia',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-polimorfia'),
    1
  ),
  (
    'batutaRegenciaCharges',
    'Cargas — Batuta da Regência',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'batuta-da-regencia'),
    1
  ),
  (
    'varinhaRelampagosCharges',
    'Cargas — Varinha de Relâmpagos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-relampagos'),
    1
  ),
  (
    'varinhaCuspidoraFogoCharges',
    'Cargas — Varinha Cuspidora de Fogo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-cuspidora-de-fogo'),
    1
  ),
  (
    'varinhaPirotecnicaCharges',
    'Cargas — Varinha Pirotécnica',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-pirotecnica'),
    1
  ),
  (
    'varinhaDetectarInimigoCharges',
    'Cargas — Varinha de Detectar Inimigo',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-detectar-inimigo'),
    1
  ),
  (
    'varinhaParalisiaCharges',
    'Cargas — Varinha de Paralisia',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-paralisia'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;


