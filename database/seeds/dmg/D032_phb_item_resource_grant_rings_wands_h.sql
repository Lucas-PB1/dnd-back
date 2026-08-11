-- DMG §0 #9h: resources anéis finais + varinhas lote 2
-- Ver docs/source/dmg-wiring-status.md
-- Cast real / link de magia = fase 6

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
  ('anel-de-ariete', 'anelArieteCharges', 3),
  ('anel-de-invocar-djinni', 'anelDjinniUse', 1),
  ('anel-de-comando-elemental', 'anelComandoElementalCharges', 5),
  ('varinha-dos-segredos', 'varinhaSegredosCharges', 3),
  ('varinha-de-teia', 'varinhaTeiaCharges', 7),
  ('varinha-de-polimorfia', 'varinhaPolimorfiaCharges', 7),
  ('batuta-da-regencia', 'batutaRegenciaCharges', 3),
  ('varinha-de-relampagos', 'varinhaRelampagosCharges', 7),
  ('varinha-cuspidora-de-fogo', 'varinhaCuspidoraFogoCharges', 7),
  ('varinha-pirotecnica', 'varinhaPirotecnicaCharges', 7),
  ('varinha-de-detectar-inimigo', 'varinhaDetectarInimigoCharges', 7),
  ('varinha-de-paralisia', 'varinhaParalisiaCharges', 7)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
