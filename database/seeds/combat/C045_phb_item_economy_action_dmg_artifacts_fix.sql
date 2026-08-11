-- Artefatos DMG: 1 economy row por magia + spell_slug (padrão C021/C042)
-- Remove lumps spend=1 sem slug. Ver docs/plans/audit-dmg-artifacts.md

DELETE FROM rpg.phb_class_economy_action
WHERE action_id IN (
  'item-varinha-orcus-cast',
  'item-vecna-olho-cast',
  'item-vecna-mao-cast',
  'item-orbes-cast',
  'item-demonomico-cast-0',
  'item-demonomico-cast-1',
  'item-demonomico-cast-2',
  'item-demonomico-cast-3'
);

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- Orcus
(
  'item-varinha-orcus-animar-mortos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Animar Mortos', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusCharges', NULL, true,
  'Gastar 1 carga: Animar Mortos CD 18',
  'Cargas 7; recupera 1d4+3 ao amanhecer (MVP: DL).',
  'spend-resource', 1, 1300, NULL, NULL
),
(
  'item-varinha-orcus-falar-mortos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Falar com Mortos', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusCharges', NULL, true,
  'Gastar 1 carga: Falar com Mortos CD 18',
  'Cargas 7; MVP: DL.',
  'spend-resource', 1, 1301, NULL, NULL
),
(
  'item-varinha-orcus-malogro', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Malogro', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusCharges', NULL, true,
  'Gastar 2 cargas: Malogro CD 18',
  'Cargas 7; MVP: DL.',
  'spend-resource', 2, 1302, NULL, NULL
),
(
  'item-varinha-orcus-circulo-morte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Círculo da Morte', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusCharges', NULL, true,
  'Gastar 3 cargas: Círculo da Morte CD 18',
  'Cargas 7; MVP: DL.',
  'spend-resource', 3, 1303, NULL, NULL
),
(
  'item-varinha-orcus-dedo-morte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Dedo da Morte', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusCharges', NULL, true,
  'Gastar 3 cargas: Dedo da Morte CD 18',
  'Cargas 7; MVP: DL.',
  'spend-resource', 3, 1304, NULL, NULL
),
(
  'item-varinha-orcus-palavra-matar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'varinha-de-orcus'), NULL,
  'Orcus · Palavra de Poder: Matar', 'action'::rpg.action_economy_bucket, 1,
  'varinhaOrcusCharges', NULL, true,
  'Gastar 4 cargas: Palavra de Poder: Matar CD 18',
  'Cargas 7; MVP: DL.',
  'spend-resource', 4, 1305, NULL, NULL
),
-- Vecna olho
(
  'item-vecna-olho-coroa', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Coroa da Loucura', 'action'::rpg.action_economy_bucket, 1,
  'olhoVecnaCharges', NULL, true,
  'Gastar 1 carga (olho): Coroa da Loucura CD 18',
  'Cargas 8; 5% risco de alma. MVP: DL.',
  'spend-resource', 1, 1310, NULL, NULL
),
(
  'item-vecna-olho-clarividencia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Clarividência', 'action'::rpg.action_economy_bucket, 1,
  'olhoVecnaCharges', NULL, true,
  'Gastar 2 cargas (olho): Clarividência CD 18',
  'Cargas 8; MVP: DL.',
  'spend-resource', 2, 1311, NULL, NULL
),
(
  'item-vecna-olho-desintegrar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Desintegrar', 'action'::rpg.action_economy_bucket, 1,
  'olhoVecnaCharges', NULL, true,
  'Gastar 4 cargas (olho): Desintegrar CD 18',
  'Cargas 8; MVP: DL.',
  'spend-resource', 4, 1312, NULL, NULL
),
(
  'item-vecna-olho-mau-olhado', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Mau Olhado', 'action'::rpg.action_economy_bucket, 1,
  'olhoVecnaCharges', NULL, true,
  'Gastar 4 cargas (olho): Mau Olhado CD 18',
  'Cargas 8; MVP: DL.',
  'spend-resource', 4, 1313, NULL, NULL
),
(
  'item-vecna-olho-dominar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Dominar Monstro', 'action'::rpg.action_economy_bucket, 1,
  'olhoVecnaCharges', NULL, true,
  'Gastar 5 cargas (olho): Dominar Monstro CD 18',
  'Cargas 8; MVP: DL.',
  'spend-resource', 5, 1314, NULL, NULL
),
-- Vecna mão
(
  'item-vecna-mao-sono', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Sono', 'action'::rpg.action_economy_bucket, 1,
  'maoVecnaCharges', NULL, true,
  'Gastar 1 carga (mão): Sono CD 18',
  'Cargas 8; Sugestão maligna ao conjurar. MVP: DL.',
  'spend-resource', 1, 1320, NULL, NULL
),
(
  'item-vecna-mao-lentidao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Lentidão', 'action'::rpg.action_economy_bucket, 1,
  'maoVecnaCharges', NULL, true,
  'Gastar 2 cargas (mão): Lentidão CD 18',
  'Cargas 8; MVP: DL.',
  'spend-resource', 2, 1321, NULL, NULL
),
(
  'item-vecna-mao-teleporte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Teleporte', 'action'::rpg.action_economy_bucket, 1,
  'maoVecnaCharges', NULL, true,
  'Gastar 3 cargas (mão): Teleporte CD 18',
  'Cargas 8; MVP: DL.',
  'spend-resource', 3, 1322, NULL, NULL
),
(
  'item-vecna-mao-dedo-morte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-e-mao-de-vecna'), NULL,
  'Vecna · Dedo da Morte', 'action'::rpg.action_economy_bucket, 1,
  'maoVecnaCharges', NULL, true,
  'Gastar 5 cargas (mão): Dedo da Morte CD 18',
  'Cargas 8; MVP: DL.',
  'spend-resource', 5, 1323, NULL, NULL
),
-- Órbes
(
  'item-orbes-detectar-magia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Detectar Magia (0)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Detectar Magia (0 cargas; se controla)',
  'Cargas 7; recupera 1d4+3 ao amanhecer (MVP: DL).',
  'cast-item-free', NULL, 1330, NULL, NULL
),
(
  'item-orbes-luz-do-dia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Luz do Dia', 'action'::rpg.action_economy_bucket, 1,
  'orbesDraconicosCharges', NULL, true,
  'Gastar 1 carga: Luz do Dia (se controla)',
  'Cargas 7; MVP: DL.',
  'spend-resource', 1, 1331, NULL, NULL
),
(
  'item-orbes-protecao-morte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Proteção Contra a Morte', 'action'::rpg.action_economy_bucket, 1,
  'orbesDraconicosCharges', NULL, true,
  'Gastar 2 cargas: Proteção Contra a Morte (se controla)',
  'Cargas 7; MVP: DL.',
  'spend-resource', 2, 1332, NULL, NULL
),
(
  'item-orbes-videncia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Vidência', 'action'::rpg.action_economy_bucket, 1,
  'orbesDraconicosCharges', NULL, true,
  'Gastar 3 cargas: Vidência CD 18 (se controla)',
  'Cargas 7; MVP: DL.',
  'spend-resource', 3, 1333, NULL, NULL
),
(
  'item-orbes-curar-ferimentos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orbes-draconicos'), NULL,
  'Orbe · Curar Ferimentos (9º)', 'action'::rpg.action_economy_bucket, 1,
  'orbesDraconicosCharges', NULL, true,
  'Gastar 4 cargas: Curar Ferimentos 9º (se controla)',
  'Slot 9 via resolveItemCastSlotLevel (orbes + spend 4). MVP: DL.',
  'spend-resource', 4, 1334, NULL, NULL
),
-- Demonômico
(
  'item-demonomico-gargalhada', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Gargalhada Nefasta (0)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Gargalhada Nefasta de Tasha CD 20 (0 cargas)',
  'Cargas 8; recupera 1d8 ao amanhecer (MVP: DL).',
  'cast-item-free', NULL, 1340, NULL, NULL
),
(
  'item-demonomico-circulo-magico', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Círculo Mágico', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 1 carga: Círculo Mágico CD 20',
  'Cargas 8; MVP: DL.',
  'spend-resource', 1, 1341, NULL, NULL
),
(
  'item-demonomico-ancora-planar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Âncora Planar', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 2 cargas: Âncora Planar CD 20',
  'Cargas 8; MVP: DL.',
  'spend-resource', 2, 1342, NULL, NULL
),
(
  'item-demonomico-aliado', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Aliado Extraplanar', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 3 cargas: Aliado Extraplanar CD 20',
  'Cargas 8; MVP: DL.',
  'spend-resource', 3, 1343, NULL, NULL
),
(
  'item-demonomico-invocar-infero', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Invocar Ínfero', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 3 cargas: Invocar Ínfero CD 20',
  'Cargas 8; MVP: DL.',
  'spend-resource', 3, 1344, NULL, NULL
),
(
  'item-demonomico-receptaculo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Receptáculo Arcano', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 3 cargas: Receptáculo Arcano CD 20',
  'Cargas 8; MVP: DL.',
  'spend-resource', 3, 1345, NULL, NULL
),
(
  'item-demonomico-transicao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'demonomico-de-lggwilv'), NULL,
  'Demonômico · Transição Planar (Abismo)', 'action'::rpg.action_economy_bucket, 1,
  'demonomicoCharges', NULL, true,
  'Gastar 3 cargas: Transição Planar (só Abismo) CD 20',
  'Cargas 8; MVP: DL. Destino = Abismo (mesa).',
  'spend-resource', 3, 1346, NULL, NULL
),
-- Kas
(
  'item-espada-kas-convocar-relampagos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'), NULL,
  'Kas · Convocar Relâmpagos', 'action'::rpg.action_economy_bucket, 1,
  'espadaKasConvocarRelampagosUse', NULL, true,
  'Conjurar Convocar Relâmpagos CD 18 (1×/amanhecer)',
  'MVP: DL.',
  'spend-resource', 1, 1350, NULL, NULL
),
(
  'item-espada-kas-dedo-morte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'), NULL,
  'Kas · Dedo da Morte', 'action'::rpg.action_economy_bucket, 1,
  'espadaKasDedoDaMorteUse', NULL, true,
  'Conjurar Dedo da Morte CD 18 (1×/amanhecer)',
  'MVP: DL.',
  'spend-resource', 1, 1351, NULL, NULL
),
(
  'item-espada-kas-palavra-sagrada', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-de-kas'), NULL,
  'Kas · Palavra Sagrada', 'action'::rpg.action_economy_bucket, 1,
  'espadaKasPalavraSagradaUse', NULL, true,
  'Conjurar Palavra Sagrada CD 18 (1×/amanhecer)',
  'MVP: DL.',
  'spend-resource', 1, 1352, NULL, NULL
),
-- Livro das Trevas
(
  'item-livro-trevas-animar-mortos', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'), NULL,
  'Trevas · Animar Mortos', 'action'::rpg.action_economy_bucket, 1,
  'livroTrevasAnimarMortosUse', NULL, true,
  'Conjurar Animar Mortos CD 18 (1×/amanhecer)',
  'Requer 80 h de estudo. MVP: DL.',
  'spend-resource', 1, 1360, NULL, NULL
),
(
  'item-livro-trevas-circulo-morte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'), NULL,
  'Trevas · Círculo da Morte', 'action'::rpg.action_economy_bucket, 1,
  'livroTrevasCirculoDaMorteUse', NULL, true,
  'Conjurar Círculo da Morte CD 18 (1×/amanhecer)',
  'MVP: DL.',
  'spend-resource', 1, 1361, NULL, NULL
),
(
  'item-livro-trevas-dedo-morte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'), NULL,
  'Trevas · Dedo da Morte', 'action'::rpg.action_economy_bucket, 1,
  'livroTrevasDedoDaMorteUse', NULL, true,
  'Conjurar Dedo da Morte CD 18 (1×/amanhecer)',
  'MVP: DL.',
  'spend-resource', 1, 1362, NULL, NULL
),
(
  'item-livro-trevas-dominar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'livro-das-trevas-profanas'), NULL,
  'Trevas · Dominar Monstro', 'action'::rpg.action_economy_bucket, 1,
  'livroTrevasDominarMonstroUse', NULL, true,
  'Conjurar Dominar Monstro CD 18 (1×/amanhecer)',
  'MVP: DL.',
  'spend-resource', 1, 1363, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  item_id = EXCLUDED.item_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order;

-- Contenção: resource 1×/DL
UPDATE rpg.phb_class_economy_action
SET
  resource_slug = 'demonomicoContencaoUse',
  always_spends_resource = true,
  table_action = 'spend-resource',
  spend_amount = 1,
  summary = 'Usar Magia: Contenção (Ínfero em Círculo) — CAR CD 20 Desvant. (1×/amanhecer)',
  description = '10 páginas em branco. Ver texto para libertar/usar. MVP: DL.'
WHERE action_id = 'item-demonomico-contencao';

-- Armas: preencher spell_slug nas rows existentes
UPDATE rpg.phb_class_economy_action
SET spell_slug = 'dominar-fera',
    summary = 'Gastar 1 carga: Dominar Fera CD 20 (Fera com natação)',
    description = 'Cargas 3; recupera 1d3 ao amanhecer (MVP: DL).'
WHERE action_id = 'item-onda-comando';

UPDATE rpg.phb_class_economy_action
SET spell_slug = 'globo-de-invulnerabilidade',
    summary = 'Conjurar Globo de Invulnerabilidade 9º (1×/amanhecer)',
    description = 'Slot 9 via resolveItemCastSlotLevel (ondaGloboUse). MVP: DL.'
WHERE action_id = 'item-onda-globo';

UPDATE rpg.phb_class_economy_action
SET spell_slug = 'detectar-o-bem-e-o-mal'
WHERE action_id = 'item-opressor-detectar';

UPDATE rpg.phb_class_economy_action
SET spell_slug = 'localizar-objeto'
WHERE action_id = 'item-opressor-localizar';

UPDATE rpg.phb_class_economy_action
SET spell_slug = 'teleporte'
WHERE action_id = 'item-machado-senhores-teleporte';

UPDATE rpg.phb_class_economy_action
SET spell_slug = 'desejo'
WHERE action_id = 'item-vecna-desejo';

-- spell_slug nas novas rows
UPDATE rpg.phb_class_economy_action AS a
SET spell_slug = v.spell_slug
FROM (VALUES
  ('item-varinha-orcus-animar-mortos', 'animar-mortos'),
  ('item-varinha-orcus-falar-mortos', 'falar-com-mortos'),
  ('item-varinha-orcus-malogro', 'malogro'),
  ('item-varinha-orcus-circulo-morte', 'circulo-da-morte'),
  ('item-varinha-orcus-dedo-morte', 'dedo-da-morte'),
  ('item-varinha-orcus-palavra-matar', 'palavra-de-poder-matar'),
  ('item-vecna-olho-coroa', 'coroa-da-loucura'),
  ('item-vecna-olho-clarividencia', 'clarividencia'),
  ('item-vecna-olho-desintegrar', 'desintegrar'),
  ('item-vecna-olho-mau-olhado', 'mau-olhado'),
  ('item-vecna-olho-dominar', 'dominar-monstro'),
  ('item-vecna-mao-sono', 'sono'),
  ('item-vecna-mao-lentidao', 'lentidao'),
  ('item-vecna-mao-teleporte', 'teleporte'),
  ('item-vecna-mao-dedo-morte', 'dedo-da-morte'),
  ('item-orbes-detectar-magia', 'detectar-magia'),
  ('item-orbes-luz-do-dia', 'luz-do-dia'),
  ('item-orbes-protecao-morte', 'protecao-contra-a-morte'),
  ('item-orbes-videncia', 'videncia'),
  ('item-orbes-curar-ferimentos', 'curar-ferimentos'),
  ('item-demonomico-gargalhada', 'gargalhada-nefasta-de-tasha'),
  ('item-demonomico-circulo-magico', 'circulo-magico'),
  ('item-demonomico-ancora-planar', 'ancora-planar'),
  ('item-demonomico-aliado', 'aliado-extraplanar'),
  ('item-demonomico-invocar-infero', 'invocar-infero'),
  ('item-demonomico-receptaculo', 'receptaculo-arcano'),
  ('item-demonomico-transicao', 'transicao-planar'),
  ('item-espada-kas-convocar-relampagos', 'convocar-relampagos'),
  ('item-espada-kas-dedo-morte', 'dedo-da-morte'),
  ('item-espada-kas-palavra-sagrada', 'palavra-sagrada'),
  ('item-livro-trevas-animar-mortos', 'animar-mortos'),
  ('item-livro-trevas-circulo-morte', 'circulo-da-morte'),
  ('item-livro-trevas-dedo-morte', 'dedo-da-morte'),
  ('item-livro-trevas-dominar', 'dominar-monstro')
) AS v(action_id, spell_slug)
WHERE a.action_id = v.action_id;
