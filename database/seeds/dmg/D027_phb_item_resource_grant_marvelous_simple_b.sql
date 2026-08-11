-- DMG §0 #9b: resources maravilhosos simples (lote 2)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'chapeuVermesCharges',
    'Cargas — Chapéu dos Vermes',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-dos-vermes'),
    1
  ),
  (
    'tunicaCoresCharges',
    'Cargas — Túnica das Cores Cintilantes',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-cores-cintilantes'),
    1
  ),
  (
    'instrumentoEscritaCharges',
    'Cargas — Instrumento Musical de Escrita',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'instrumento-musical-de-escrita'),
    1
  ),
  (
    'mantoMorcegoPolimorfiaUse',
    'Polimorfia — Manto do Morcego',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'manto-do-morcego'),
    1
  ),
  (
    'capaAracnideaTeiaUse',
    'Teia — Capa Aracnídea',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'capa-aracnidea'),
    1
  ),
  (
    'orbeFlutuanteLuzDiaUse',
    'Luz do Dia — Orbe Flutuante',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'orbe-flutuante'),
    1
  ),
  (
    'cuboInvocacaoUse',
    'Invocação — Cubo de Invocação',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cubo-de-invocacao'),
    1
  ),
  (
    'tabuleiroEspiritualCharges',
    'Cargas — Tabuleiro Espiritual',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tabuleiro-espiritual'),
    1
  ),
  (
    'bolaCristalTelepatiaSugestaoUse',
    'Sugestão — Bola de Cristal de Telepatia',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'bola-de-cristal-de-telepatia'),
    1
  ),
  (
    'jarroAlquimicoUse',
    'Produzir Líquido — Jarro Alquímico',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'jarro-alquimico'),
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
  ('chapeu-dos-vermes', 'chapeuVermesCharges', 3),
  ('tunica-das-cores-cintilantes', 'tunicaCoresCharges', 3),
  ('instrumento-musical-de-escrita', 'instrumentoEscritaCharges', 3),
  ('manto-do-morcego', 'mantoMorcegoPolimorfiaUse', 1),
  ('capa-aracnidea', 'capaAracnideaTeiaUse', 1),
  ('orbe-flutuante', 'orbeFlutuanteLuzDiaUse', 1),
  ('cubo-de-invocacao', 'cuboInvocacaoUse', 1),
  ('tabuleiro-espiritual', 'tabuleiroEspiritualCharges', 3),
  ('bola-de-cristal-de-telepatia', 'bolaCristalTelepatiaSugestaoUse', 1),
  ('jarro-alquimico', 'jarroAlquimicoUse', 1)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "abilityBonuses": {
      "constituicao": 2
    }
  }
}'::jsonb
WHERE slug = 'cinturao-do-povo-anao';
