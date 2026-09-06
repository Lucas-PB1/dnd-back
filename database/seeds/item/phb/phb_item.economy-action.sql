-- Seed: Magic item economy actions (UI Actions tab)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-ring-of-barrels', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'ring-of-barrels'), NULL,
  'Invocar Barris', 'action'::rpg.action_economy_bucket, 1,
  'ringBarrelCharges', NULL, true,
  'Ação Mágica: gastar 1–3 cargas → barris (Meia Cobertura)',
  'Ação Mágica: gaste 1–3 cargas para invocar esse número de barris vazios a até 1,5 m. Barril: Meia Cobertura, CA 15, 20 PV. Pode prender criatura Média ou menor (salvaguarda DES CD 13). Cargas: 6; MVP recupera no Descanso Longo (texto: 1d6 ao amanhecer).',
  'spend-resource', 1, 400, NULL, NULL
),
(
  'item-gambler-s-coin', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'gambler-s-coin'), NULL,
  'Moeda do Apostador', 'free'::rpg.action_economy_bucket, 1,
  'gamblerCoinCharges', NULL, true,
  'Em Teste D20: gastar 1 carga → cara/coroa (20 ou 1)',
  'Quando fizer um Teste D20, gaste 1 carga para substituir o d20 por cara ou coroa: cara = 20 (sem crítico/efeitos de 20 naturais); coroa = 1. 3 cargas; recupera no amanhecer (MVP: Descanso Longo).',
  'spend-resource', NULL, 401, NULL, NULL
),
(
  'item-bag-of-cheer', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bag-of-cheer'), NULL,
  'Retirar Presente', 'action'::rpg.action_economy_bucket, 1,
  'bagOfCheerGifts', NULL, true,
  'Ação Mágica: dar presente sob medida (máx. 100 PO)',
  'Ação Mágica: retire um presente e dê a outra criatura (Mestre determina; ≤ 100 PO). Após 3 presentes, só caixas vazias até o amanhecer (MVP: Descanso Longo).',
  'spend-resource', NULL, 402, NULL, NULL
),
(
  'item-frog-prince-statuette', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'frog-prince-statuette'), NULL,
  'Príncipe Sapo', 'action'::rpg.action_economy_bucket, 1,
  'frogPrinceUse', NULL, true,
  'Palavra + beijo: Seguidor Feral (1×/amanhecer)',
  'Enquanto segura a estatueta, fale a palavra de comando e beije-a para conjurar Seguidor Feral de Mandy (plebeu). 1× até o próximo amanhecer (MVP: Descanso Longo).',
  'spend-resource', NULL, 403, NULL, NULL
),
(
  'item-throne-hover', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'leonora-s-throne-of-indolence'), NULL,
  'Trono · Pairar', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Mágica: pairar / voar (Desloc. Voo 15 m)',
  'Sentado no trono, Ação Mágica com palavra de comando: o trono paira e voa (Deslocamento de Voo 15 m / 50 pés), paira, carrega até ~180 kg. Repita a palavra para encerrar.',
  NULL, NULL, 404, NULL, NULL
),
(
  'item-throne-servant', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'leonora-s-throne-of-indolence'), NULL,
  'Trono · Servo Invisível', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '2ª palavra: Servo Invisível (+ trombeta)',
  'Segunda palavra de comando: conjure Servo Invisível. O servo pode conjurar trombeta espectral além das tarefas habituais.',
  NULL, NULL, 405, NULL, NULL
),
(
  'item-throne-feast', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'leonora-s-throne-of-indolence'), NULL,
  'Trono · Banquete', 'action'::rpg.action_economy_bucket, 1,
  'throneFeast', NULL, true,
  '3ª palavra: comida e vinho (1×/amanhecer)',
  'Ação Mágica: terceira palavra cria até ~4,5 kg de comida e até 4 garrafas de vinho (só você pode consumir). 1× por amanhecer (MVP: Descanso Longo).',
  'spend-resource', NULL, 406, NULL, NULL
),
(
  'item-portable-cannonballs', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'portable-cannonballs'), NULL,
  'Expandir Bolas', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: expandir bolas em balas de canhão / no ar',
  'Ação Bônus: palavra de comando expande bolas escolhidas em balas de canhão (10 lb). Ou, ao atacar com bola como munição, Ação Bônus para expandir no ar (acerto: 2d12 + mod Contundente).',
  NULL, NULL, 407, NULL, NULL
),
(
  'item-weapon-charm-hook', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'weapon-charm-hook'), NULL,
  'Encanto Anzol · Teleporte', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: teleportar arma anexada à sua mão',
  'Enquanto o Encanto Anzol estiver preso a uma arma no mesmo plano, Ação Bônus: teleporte a arma até sua mão.',
  NULL, NULL, 408, NULL, NULL
),
(
  'item-soul-figurine', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'soul-figurine'), NULL,
  'Figurinha da Alma', 'free'::rpg.action_economy_bucket, 1,
  'soulFigurineWard', NULL, true,
  'Ao cair a 0 PV: 2d10+10 PV (one-shot)',
  'Se cair a 0 PV enquanto sintonizado, role 2d10+10 e seus PV passam a esse valor. A figurinha se torna não mágica (1 uso).',
  'spend-resource', NULL, 409, NULL, NULL
),
(
  'item-nolzur-painted-world', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'nolzur-s-painted-world'), NULL,
  'Mundo Pintado · Portal', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Atravessar o portal para o semiplano pintado',
  'Criaturas do tamanho da pintura ou menores podem atravessar o portal para o semiplano. Tempo passa pela metade lá. Se a face estiver bloqueada, o arco no semiplano desaparece.',
  NULL, NULL, 410, NULL, NULL
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
