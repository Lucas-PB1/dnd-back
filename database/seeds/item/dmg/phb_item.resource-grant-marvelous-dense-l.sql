-- DMG §0 #9l: resources + permanentEffects (maravilhosos densos finais + Orcus/Maravilhas)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Cast/link magia = fase 6 · tabelas/artefatos = lembrete + pools chave
-- trombeta 7 dias / desejo 30 dias: sem recover automático
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'amuletoEstilhaMagiaDesconhecidaUse',
    'Magia Desconhecida — Amuleto da Estilha Negra',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-da-estilha-negra'),
    1
  ),
  (
    'bolsaTropeliasCharges',
    'Objetos — Bolsa das Tropelias',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'bolsa-das-tropelias'),
    1
  ),
  (
    'chapeuMuitasMagiasUse',
    'Magia Desconhecida — Chapéu das Muitas Magias',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'chapeu-das-muitas-magias'),
    1
  ),
  (
    'demonomicoCharges',
    'Cargas — Demonômico de Iggwilv',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'),
    1
  ),
  (
    'tunicaEstrelasCharges',
    'Estrelas — Túnica das Estrelas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-das-estrelas'),
    1
  ),
  (
    'trombetaValhallaUse',
    'Soprar — Trombeta do Valhalla',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'trombeta-do-valhalla'),
    1
  ),
  (
    'orbesDraconicosCharges',
    'Cargas — Orbes Dracônicos',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'),
    1
  ),
  (
    'varinhaMaravilhasCharges',
    'Cargas — Varinha das Maravilhas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-das-maravilhas'),
    1
  ),
  (
    'varinhaOrcusCharges',
    'Cargas — Varinha de Orcus',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'),
    1
  ),
  (
    'varinhaOrcusConvocarUse',
    'Convocar Mortos-Vivos — Varinha de Orcus',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'),
    1
  ),
  (
    'olhoVecnaCharges',
    'Cargas — Olho de Vecna',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'),
    1
  ),
  (
    'maoVecnaCharges',
    'Cargas — Mão de Vecna',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'),
    1
  ),
  (
    'olhoMaoVecnaDesejoUse',
    'Desejo — Olho e Mão de Vecna',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'),
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
    "savingThrowBonuses": {
      "forca": 1,
      "destreza": 1,
      "constituicao": 1,
      "inteligencia": 1,
      "sabedoria": 1,
      "carisma": 1
    }
  }
}'::jsonb
WHERE slug = 'tunica-das-estrelas';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 3,
    "damageBonus": 3,
    "acBonus": 3
  }
}'::jsonb
WHERE slug = 'varinha-de-orcus';
