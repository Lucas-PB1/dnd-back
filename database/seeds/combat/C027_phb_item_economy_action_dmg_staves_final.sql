-- DMG §0 #8f: economy Acrobata + Poder + Magi
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Magias custo 0 = lembrete (sem spend). Absorção/Golpe Retributivo = lembrete.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
-- ===== Acrobata =====
(
  'item-cajado-do-acrobata-luz', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-acrobata'), NULL,
  'Cajado · Meia-luz', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus (ou após Iniciativa): Meia-luz verde 3 m / apagar',
  'Arma +2 ataque/dano. Enquanto segura: Meia-luz verde 3 m (Ação Bônus ou após Iniciativa) ou apagar. Forma Cajado: arremesso 9/36 m e retorna; Vantagem em Acrobacia (Cajado/Haste); Deflexão separada.',
  NULL, NULL, 720, NULL, NULL
),
(
  'item-cajado-do-acrobata-forma', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-acrobata'), NULL,
  'Cajado · Alterar Forma', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: cetro 15 cm / haste 3 m / Cajado',
  'Altere a forma para cetro (armazenar), haste de 3 m ou Cajado (só até onde o espaço permitir).',
  NULL, NULL, 721, NULL, NULL
),
(
  'item-cajado-do-acrobata-deflexao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-acrobata'), NULL,
  'Cajado · Deflexão de Ataque', 'reaction'::rpg.action_economy_bucket, 1,
  'cajadoAcrobataDeflexaoUse', NULL, true,
  'Reação (forma Cajado): +5 CA vs ataque (1×/Descanso)',
  'Ao ser atingido enquanto segura na forma Cajado, Reação: +5 CA contra o ataque. Recupera no Descanso Curto ou Longo.',
  'spend-resource', 1, 722, NULL, NULL
),
-- ===== Poder =====
(
  'item-cajado-do-poder-misseis', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Mísseis Mágicos', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 1 carga: Mísseis Mágicos',
  '+2 ataque/dano; +2 CA e salvaguardas; +2 ataque mágico (lembrete). Cargas: 20; recupera 2d8+4 ao amanhecer (MVP: Descanso Longo). Última carga: 1d20 — 1 perde propriedades extras; 20 recupera 1d8+2.',
  'spend-resource', 1, 723, NULL, NULL
),
(
  'item-cajado-do-poder-raio-enfraquecimento', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Raio do Enfraquecimento', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 1 carga: Raio do Enfraquecimento',
  'Gaste 1 carga para conjurar Raio do Enfraquecimento (sua CD). Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 1, 724, NULL, NULL
),
(
  'item-cajado-do-poder-levitacao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Levitação', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 2 cargas: Levitação',
  'Gaste 2 cargas para conjurar Levitação (sua CD). Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 725, NULL, NULL
),
(
  'item-cajado-do-poder-bola-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Bola de Fogo (5º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 5 cargas: Bola de Fogo 5º',
  'Gaste 5 cargas para conjurar Bola de Fogo no 5º círculo (sua CD). Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 726, NULL, NULL
),
(
  'item-cajado-do-poder-cone-frio', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Cone de Frio', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 5 cargas: Cone de Frio',
  'Gaste 5 cargas para conjurar Cone de Frio (sua CD). Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 727, NULL, NULL
),
(
  'item-cajado-do-poder-muralha-energia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Muralha de Energia', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 5 cargas: Muralha de Energia',
  'Gaste 5 cargas para conjurar Muralha de Energia (sua CD). Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 728, NULL, NULL
),
(
  'item-cajado-do-poder-paralisar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Paralisar Monstro', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 5 cargas: Paralisar Monstro',
  'Gaste 5 cargas para conjurar Paralisar Monstro (sua CD). Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 729, NULL, NULL
),
(
  'item-cajado-do-poder-relampago', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Relâmpago (5º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 5 cargas: Relâmpago 5º',
  'Gaste 5 cargas para conjurar Relâmpago no 5º círculo (sua CD). Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 730, NULL, NULL
),
(
  'item-cajado-do-poder-globo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Globo de Invulnerabilidade', 'action'::rpg.action_economy_bucket, 1,
  'cajadoPoderCharges', NULL, true,
  'Gastar 6 cargas: Globo de Invulnerabilidade',
  'Gaste 6 cargas para conjurar Globo de Invulnerabilidade. Cargas: 20; MVP recupera no Descanso Longo.',
  'spend-resource', 6, 731, NULL, NULL
),
(
  'item-cajado-do-poder-golpe-retributivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'), NULL,
  'Cajado · Golpe Retributivo', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Quebrar o cajado: explosão 9 m (destrói o item)',
  'Usar Magia: quebre o cajado — destruído; explosão Emanação 9 m. 50% teleporte para plano aleatório (evita). Senão: você sofre Energético = 16×cargas; demais DES CD 17; falha = 4×cargas / sucesso metade. Remova o item do inventário.',
  NULL, NULL, 732, NULL, NULL
),
-- ===== Magi — custo 0 =====
(
  'item-cajado-dos-magi-luz', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Luz', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Luz (0 cargas)',
  'Cajado +2 ataque/dano; +2 ataque mágico; Vantagem em salvaguardas vs magias (lembrete). Conjure Luz sem gastar cargas. Cargas: 50; recupera 4d6+2 ao amanhecer (MVP: Descanso Longo).',
  NULL, NULL, 733, NULL, NULL
),
(
  'item-cajado-dos-magi-maos-magicas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Mãos Mágicas', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Mãos Mágicas (0 cargas)',
  'Conjure Mãos Mágicas sem gastar cargas.',
  NULL, NULL, 734, NULL, NULL
),
(
  'item-cajado-dos-magi-detectar-magia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Detectar Magia', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Detectar Magia (0 cargas)',
  'Conjure Detectar Magia sem gastar cargas.',
  NULL, NULL, 735, NULL, NULL
),
(
  'item-cajado-dos-magi-aumentar-reduzir', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Aumentar/Reduzir', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Aumentar/Reduzir (0 cargas)',
  'Conjure Aumentar/Reduzir (sua CD) sem gastar cargas.',
  NULL, NULL, 736, NULL, NULL
),
(
  'item-cajado-dos-magi-protecao-bem-mal', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Proteção Contra o Bem e o Mal', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Proteção Contra o Bem e o Mal (0 cargas)',
  'Conjure Proteção Contra o Bem e o Mal sem gastar cargas.',
  NULL, NULL, 737, NULL, NULL
),
(
  'item-cajado-dos-magi-tranca-arcana', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Tranca Arcana', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Tranca Arcana (0 cargas)',
  'Conjure Tranca Arcana sem gastar cargas.',
  NULL, NULL, 738, NULL, NULL
),
-- ===== Magi — com custo =====
(
  'item-cajado-dos-magi-arrombar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Arrombar', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 2 cargas: Arrombar',
  'Gaste 2 cargas para conjurar Arrombar (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 739, NULL, NULL
),
(
  'item-cajado-dos-magi-esfera-flamejante', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Esfera Flamejante', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 2 cargas: Esfera Flamejante',
  'Gaste 2 cargas para conjurar Esfera Flamejante (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 740, NULL, NULL
),
(
  'item-cajado-dos-magi-invisibilidade', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Invisibilidade', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 2 cargas: Invisibilidade',
  'Gaste 2 cargas para conjurar Invisibilidade. Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 741, NULL, NULL
),
(
  'item-cajado-dos-magi-teia', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Teia', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 2 cargas: Teia',
  'Gaste 2 cargas para conjurar Teia (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 2, 742, NULL, NULL
),
(
  'item-cajado-dos-magi-dissipar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Dissipar Magia', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 3 cargas: Dissipar Magia',
  'Gaste 3 cargas para conjurar Dissipar Magia. Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 3, 743, NULL, NULL
),
(
  'item-cajado-dos-magi-muralha-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Muralha de Fogo', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 4 cargas: Muralha de Fogo',
  'Gaste 4 cargas para conjurar Muralha de Fogo (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 744, NULL, NULL
),
(
  'item-cajado-dos-magi-tempestade-glacial', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Tempestade Glacial', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 4 cargas: Tempestade Glacial',
  'Gaste 4 cargas para conjurar Tempestade Glacial (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 4, 745, NULL, NULL
),
(
  'item-cajado-dos-magi-criar-passagem', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Criar Passagem', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 5 cargas: Criar Passagem',
  'Gaste 5 cargas para conjurar Criar Passagem. Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 746, NULL, NULL
),
(
  'item-cajado-dos-magi-telecinese', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Telecinese', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 5 cargas: Telecinese',
  'Gaste 5 cargas para conjurar Telecinese (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 5, 747, NULL, NULL
),
(
  'item-cajado-dos-magi-bola-fogo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Bola de Fogo (7º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 7 cargas: Bola de Fogo 7º',
  'Gaste 7 cargas para conjurar Bola de Fogo no 7º círculo (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 7, 748, NULL, NULL
),
(
  'item-cajado-dos-magi-relampago', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Relâmpago (7º)', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 7 cargas: Relâmpago 7º',
  'Gaste 7 cargas para conjurar Relâmpago no 7º círculo (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 7, 749, NULL, NULL
),
(
  'item-cajado-dos-magi-invocar-elemental', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Invocar Elemental', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 7 cargas: Invocar Elemental',
  'Gaste 7 cargas para conjurar Invocar Elemental (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 7, 750, NULL, NULL
),
(
  'item-cajado-dos-magi-transicao-planar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Transição Planar', 'action'::rpg.action_economy_bucket, 1,
  'cajadoMagiCharges', NULL, true,
  'Gastar 7 cargas: Transição Planar',
  'Gaste 7 cargas para conjurar Transição Planar (sua CD). Cargas: 50; MVP recupera no Descanso Longo.',
  'spend-resource', 7, 751, NULL, NULL
),
(
  'item-cajado-dos-magi-absorcao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Absorção de Magia', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: cancelar magia em você e ganhar cargas = círculo',
  'Vantagem em salvaguardas vs magias (passivo). Reação quando outra criatura conjura magia só em você: cancele e ganhe cargas = círculo. Se ultrapassar 50, explode como Golpe Retributivo. Ajuste cargas manualmente na mesa.',
  NULL, NULL, 752, NULL, NULL
),
(
  'item-cajado-dos-magi-golpe-retributivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'), NULL,
  'Cajado · Golpe Retributivo', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Quebrar o cajado: explosão 9 m (destrói o item)',
  'Usar Magia: quebre o cajado — destruído; explosão 9 m. 50% teleporte (1d2, 1 = evita). Senão: você Energético = 16×cargas; demais DES CD 17; falha = 6×cargas / sucesso metade. Remova o item do inventário.',
  NULL, NULL, 753, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
  item_id = EXCLUDED.item_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
