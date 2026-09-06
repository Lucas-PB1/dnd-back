-- Item economy — Steinhardt Eldritch Hunt (transformações + cargas)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-meat-hookshot-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'meat-hookshot'), NULL,
  'Gancho de Carne · Transformar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: alternar Transformado / Não Transformado',
  'Arma Truque: alterne entre foice+bacamarte (TWF) e bacamarte+machado (Gancho). Declare o estado na mesa.',
  NULL, NULL, 420, NULL, NULL
),
(
  'item-dream-executioner-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'dream-executioner'), NULL,
  'Executor de Sonhos · Transformar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: alternar Foice+lanterna / Malho',
  'Arma Truque: Não Transformado (Colheita) ↔ Transformado (Explosão da Alma).',
  NULL, NULL, 421, NULL, NULL
),
(
  'item-dream-executioner-soul', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'dream-executioner'), NULL,
  'Executor · Liberar Alma', 'action'::rpg.action_economy_bucket, 1,
  'dreamExecutionerSoul', NULL, true,
  'Ação Mágica: libertar alma presa na lanterna',
  'Gasta a Alma Colhida (máx. 1). Colheita: ao morrer ND/nível ≥1 a 4,5 m, recupere este uso (mesa).',
  'spend-resource', NULL, 422, NULL, NULL
),
(
  'item-ravenous-gazer-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'ravenous-gazer'), NULL,
  'Olhar Voraz · Transformar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: transformar (custa 1d4 Necrótico)',
  'Ao entrar/iniciar turno Transformado: 1d4 Necrótico (não reduzível; não quebra Concentração). Foco + Visão Verdadeira 9 m.',
  NULL, NULL, 423, NULL, NULL
),
(
  'item-unstable-crumbler-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'unstable-crumbler'), NULL,
  'Destruidor Instável · Transformar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: Canhão ↔ Malho (+ impulso)',
  'Como parte da AB: Canhão→Malho salta até 9 m; Malho→Canhão recarrega e empurra 9 m no próximo acerto à distância.',
  NULL, NULL, 424, NULL, NULL
),
(
  'item-galvanized-claw-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'galvanized-claw'), NULL,
  'Garra Galvanizada · Transformar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: luva ↔ garra monstruosa',
  'Arma Truque: Não Transformado (iniciativa + extra elétrico com PV temp.) ↔ Transformado (1d8 Cortante + AB ataque).',
  NULL, NULL, 425, NULL, NULL
),
(
  'item-galvanized-claw-absorb', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'galvanized-claw'), NULL,
  'Garra · Absorver Elétrico/Trovão', 'reaction'::rpg.action_economy_bucket, 1,
  'galvanizedClawCharges', NULL, true,
  'Reação + 1 carga: 0 dano → PV temp. iguais ao dano',
  'Ao sofrer Elétrico ou Trovejante: Reação e 1 carga — não sofre o dano e ganha PV temp. iguais a ele. 3 cargas; amanhecer ≈ DL.',
  'spend-resource', NULL, 426, NULL, NULL
),
(
  'item-orphans-cradle-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orphans-cradle'), NULL,
  'Berço do Órfão · Transformar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: alternar estados (chamas no Transformado)',
  'Arma Truque: Miasma (Não Transformado) ↔ Chamas (+2d6 Ígneo). Chamas Avivadas força retorno e bloqueia transformação 1d4 rodadas.',
  NULL, NULL, 427, NULL, NULL
),
(
  'item-orphans-cradle-purify', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'orphans-cradle'), NULL,
  'Berço · Miasma Purificador', 'action'::rpg.action_economy_bucket, 1,
  'orphansCradlePurify', NULL, true,
  'Ação Mágica: 1d12 PV temp. + encerrar condição (1×)',
  'Humanoide a 3 m: 1d12 PV temp. e pode encerrar Enfeitiçado, Amedrontado ou Envenenado. Texto: 1 h; MVP recupera no DC/DL.',
  'spend-resource', NULL, 428, NULL, NULL
),
(
  'item-revelations-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'revelations'), NULL,
  'Revelações · Transformar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: Cutelo ↔ Chicote',
  'Arma Truque: maldição no acerto (Cutelo) ↔ esmagar Caído (Chicote). Transformar encerra a maldição ativa.',
  NULL, NULL, 429, NULL, NULL
),
(
  'item-shard-moonlight-transform', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'shard-of-moonlight'), NULL,
  'Estilhaço · Transformar (luar)', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB sob luar: Espada Longa ↔ Montante (1 min)',
  'Transformado exige luar direto e cargas; sem cargas a forma acaba. Extra Radiante 1d6 → 2d6.',
  NULL, NULL, 430, NULL, NULL
),
(
  'item-shard-moonlight-absorb', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'shard-of-moonlight'), NULL,
  'Estilhaço · Absorção do Vazio', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Reação: absorver magia → cargas (até 10)',
  'Cancela magia que o tem como alvo/área e armazena cargas = círculo (1 para truque). Sem espaço, falha. Mesa: ajuste o pool na Economia.',
  NULL, NULL, 431, NULL, NULL
),
(
  'item-shard-moonlight-spend-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'shard-of-moonlight'), NULL,
  'Estilhaço · Brilho Revelador', 'free'::rpg.action_economy_bucket, 1,
  'shardOfMoonlightCharges', NULL, true,
  'Transformado: 1 carga no acerto (+1d12 Radiante)',
  'No acerto: +1d12 Radiante; alvo emite Luz Fraca 3 m, não fica Invisível; ataques contra ele com Vantagem até o início do seu próximo turno.',
  'spend-resource', 1, 432, NULL, NULL
),
(
  'item-shard-moonlight-spend-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'shard-of-moonlight'), NULL,
  'Estilhaço · Luar Transitório', 'free'::rpg.action_economy_bucket, 1,
  'shardOfMoonlightCharges', NULL, true,
  'Transformado: 2 cargas — linha 18 m (2d12 Radiante)',
  'Linha 1,5×18 m: salvaguarda de Constituição CD 18, 2d12 Radiante (metade no sucesso).',
  'spend-resource', 2, 433, NULL, NULL
),
(
  'item-shard-moonlight-spend-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'shard-of-moonlight'), NULL,
  'Estilhaço · Explosão Lunar', 'action'::rpg.action_economy_bucket, 1,
  'shardOfMoonlightCharges', NULL, true,
  'Transformado: 3 cargas — Emanação 9 m (em vez de atacar)',
  'Emanação 9 m: salvaguarda de Destreza CD 18; falha 3d12 Radiante + Caído (metade só dano). Reação: ataque corpo a corpo se cair a 1,5 m.',
  'spend-resource', 3, 434, NULL, NULL
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
