-- DMG §0 #9l: resources + permanentEffects (maravilhosos densos finais + Orcus/Maravilhas)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Cast/link magia = fase 6 · tabelas/artefatos = lembrete + pools chave
-- trombeta 7 dias / desejo 30 dias: sem recover automático

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
  v.recover_short,
  v.recover_long
FROM (VALUES
  ('amuleto-da-estilha-negra', 'amuletoEstilhaMagiaDesconhecidaUse', 1, FALSE, TRUE),
  ('bolsa-das-tropelias', 'bolsaTropeliasCharges', 3, FALSE, TRUE),
  ('chapeu-das-muitas-magias', 'chapeuMuitasMagiasUse', 1, TRUE, TRUE),
  ('demonomico-de-lggwilv', 'demonomicoCharges', 8, FALSE, TRUE),
  ('tunica-das-estrelas', 'tunicaEstrelasCharges', 6, FALSE, TRUE),
  ('trombeta-do-valhalla', 'trombetaValhallaUse', 1, FALSE, FALSE),
  ('orbes-draconicos', 'orbesDraconicosCharges', 7, FALSE, TRUE),
  ('varinha-das-maravilhas', 'varinhaMaravilhasCharges', 7, FALSE, TRUE),
  ('varinha-de-orcus', 'varinhaOrcusCharges', 7, FALSE, TRUE),
  ('varinha-de-orcus', 'varinhaOrcusConvocarUse', 1, FALSE, TRUE),
  ('olho-e-mao-de-vecna', 'olhoVecnaCharges', 8, FALSE, TRUE),
  ('olho-e-mao-de-vecna', 'maoVecnaCharges', 8, FALSE, TRUE),
  ('olho-e-mao-de-vecna', 'olhoMaoVecnaDesejoUse', 1, FALSE, FALSE)
) AS v(item_slug, resource_slug, fixed_max, recover_short, recover_long)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

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
