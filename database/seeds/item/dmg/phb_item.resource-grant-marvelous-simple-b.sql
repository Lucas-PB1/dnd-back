-- DMG §0 #9b: resources maravilhosos simples (lote 2)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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



UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "abilityBonuses": {
      "constituicao": 2
    }
  }
}'::jsonb
WHERE slug = 'cinturao-do-povo-anao';
