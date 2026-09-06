-- Coberturas de arma: botões de economy (ação / bônus / free)
INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-espada-dancarina-lancar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-dancarina'), NULL,
  'Espada Dançarina · Lançar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: lançar a espada — paira e ataca',
  'Como Ação Bônus, lance a espada. Ela paira, pode voar até 9 m e realizar um ataque corpo a corpo com seu bônus. Se fizer 4 ataques enquanto paira, volta à sua mão (ou cai).',
  'item-reminder', NULL, 1200, NULL, NULL
),
(
  'item-espada-dancarina-mover', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'espada-dancarina'), NULL,
  'Espada Dançarina · Mover', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: mover até 9 m e atacar',
  'Enquanto a espada paira, use uma Ação Bônus para movê-la até 9 m e realizar um ataque com ela.',
  'item-reminder', NULL, 1201, NULL, NULL
),
(
  'item-lingua-flamejante-chamas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lingua-flamejante'), NULL,
  'Língua Flamejante · Chamas', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: acender ou apagar as chamas',
  'Palavra de comando (Ação Bônus): acende ou apaga. Em chamas: +2d6 Ígneo no acerto e luz intensa 12 m / penumbra +12 m. Apaga ao largar, guardar ou embainhar.',
  'item-reminder', NULL, 1210, NULL, NULL
),
(
  'item-arco-de-energia-transporte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'arco-de-energia'), NULL,
  'Arco de Energia · Transporte', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: flecha teleporta o alvo',
  'Ação Usar Magia: flecha de energia teleporta o alvo atingido a até 18 m para um espaço desocupado a até 3 m de você.',
  'item-reminder', NULL, 1220, NULL, NULL
),
(
  'item-arco-de-energia-escada', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'arco-de-energia'), NULL,
  'Arco de Energia · Escada', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: criar escada de energia',
  'Ação Usar Magia: cria uma escada de energia de até 18 m que permanece 1 minuto.',
  'item-reminder', NULL, 1221, NULL, NULL
),
(
  'item-arco-de-energia-contencao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'arco-de-energia'), NULL,
  'Arco de Energia · Contenção', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'No ataque à distância: conter em vez de dano',
  'Ao acertar com o arco, pode conter o alvo em vez de causar dano (FOR CD 15 Contido 1 min; escapar com Atletismo CD 20).',
  'item-reminder', NULL, 1222, NULL, NULL
),
(
  'item-martelo-do-trovao-arremesso', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'martelo-do-trovao'), NULL,
  'Martelo do Trovão · Arremesso', 'action'::rpg.action_economy_bucket, 1,
  'marteloDoTrovaoCharges', NULL, true,
  'Gastar 1 carga: arremesso trovejante',
  'Ataque à distância (arremesso 6/18 m). No acerto: estrondo; CON CD 17 ou Atordoado (≤9 m). Volta à mão. 5 cargas; recupera 1d4+1 ao amanhecer.',
  'spend-resource', 1, 1230, NULL, NULL
),
(
  'item-martelo-do-trovao-pericao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'martelo-do-trovao'), NULL,
  'Martelo do Trovão · Perdição', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Nat 20 vs Gigante (com cinturão/manoplas): CON CD 17 ou morre',
  'Se você usar Cinturão da Força dos Gigantes ou Manoplas de Poder Ógrio e obtiver um 20 natural no ataque contra um Gigante, ele deve ser bem-sucedido em CON CD 17 ou morre.',
  'item-reminder', NULL, 1231, NULL, NULL
),
(
  'item-defensora-transferir-ca', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'defensora'), NULL,
  'Defensora · Transferir CA', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'No 1º ataque do turno: mover bônus +3 para CA',
  'Ao realizar o primeiro ataque no seu turno, você pode transferir parte ou todo o bônus de +3 da arma para sua CA até o início do seu próximo turno.',
  'item-reminder', NULL, 1240, NULL, NULL
),
(
  'item-escara-gelida-extinguir', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escara-gelida'), NULL,
  'Escara Gélida · Extinguir', 'free'::rpg.action_economy_bucket, 1,
  'escaraGelidaExtinguirUse', NULL, true,
  'Ao sacar: extinguir chamas ≤9 m (1×; texto 1 h → MVP DL)',
  'Ao sacar a espada, você pode extinguir chamas não mágicas a até 9 m. 1 uso; no texto recupera após 1 h (MVP: Descanso Longo).',
  'spend-resource', 1, 1250, NULL, NULL
),
(
  'item-garra-silvestre-mensagem', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'garra-silvestre'), NULL,
  'Garra Silvestre · Mensagem', 'action'::rpg.action_economy_bucket, 1,
  'garraSilvestreMensagemUse', NULL, true,
  'Usar Magia: conjurar Mensagem (1×/amanhecer)',
  'Ação Usar Magia: conjurar Mensagem a partir da arma. 1× ao amanhecer.',
  'spend-resource', 1, 1260, NULL, NULL
),
(
  'item-lamina-da-sorte-desejo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-da-sorte'), NULL,
  'Lâmina da Sorte · Desejo', 'action'::rpg.action_economy_bucket, 1,
  'laminaDaSorteDesejoCharges', NULL, true,
  'Gastar 1 carga: conjurar Desejo',
  'Ação: gastar 1 carga de Desejo (máx. 3; não recuperam). 1×/amanhecer além do limite de cargas. Ao gastar a última, a arma perde essa propriedade.',
  'spend-resource', 1, 1270, NULL, NULL
),
(
  'item-lamina-da-sorte-sorte', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'lamina-da-sorte'), NULL,
  'Lâmina da Sorte · Sorte', 'free'::rpg.action_economy_bucket, 1,
  'laminaDaSorteSorteUse', NULL, true,
  'Refazer um d20 falho (1×/amanhecer)',
  'Quando falhar em um teste, jogada de ataque ou salvaguarda, você pode rolar de novo o d20 e usar o novo resultado. 1× ao amanhecer.',
  'spend-resource', 1, 1271, NULL, NULL
),
(
  'item-arco-do-juramento-designar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'arco-do-juramento'), NULL,
  'Arco do Juramento · Designar', 'free'::rpg.action_economy_bucket, 1,
  'arcoDoJuramentoJurarUse', NULL, true,
  'No ataque: designar inimigo jurado',
  'Ao atacar, fale palavras de comando para jurar um inimigo. Enquanto vivo: vantagem e +3d6 no acerto. Novo juramento só após a morte do atual + amanhecer.',
  'spend-resource', 1, 1280, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  item_id = EXCLUDED.item_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  resource_slug = EXCLUDED.resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order;

UPDATE rpg.phb_class_economy_action
SET spell_slug = 'mensagem'
WHERE action_id = 'item-garra-silvestre-mensagem';

UPDATE rpg.phb_class_economy_action
SET spell_slug = 'desejo'
WHERE action_id = 'item-lamina-da-sorte-desejo';
