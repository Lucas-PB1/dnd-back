-- Economy — talentos Grim Hollow Cap. 4 (Fase C)
-- Gerado por scripts/generate-ghpg-cap4-economy-seeds.mjs

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'feat-gh-triage-blood-and-bone', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'), NULL,
  'Sangue e Osso', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, FALSE,
  'Utilizar + kit → cura com Dado de Vida', 'Realizar a ação Utilizar e gastar o uso de um Kit de Curandeiro permite curar uma criatura a até 1,5 m de você. A criatura pode gastar e rolar um Dado de Vida e recuperar Pontos de Vida iguais à rolagem.',
  NULL, NULL, 500, NULL, NULL
),
(
  'feat-gh-fortune-fortitude', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'), NULL,
  'Fortitude da Fortuna', 'free'::rpg.action_economy_bucket, 1,
  'fortunes-fortitude', NULL, TRUE,
  'Falhou no Teste D20 → gaste 1 uso, role DV e some', 'Quando falha em um Teste D20, pode gastar e rolar um Dado de Vida, somando esse número ao resultado. Só pode fazer isso uma vez por Teste D20. PB usos; recupera no Descanso Longo.',
  'spend-resource', NULL, 501, NULL, NULL
),
(
  'feat-gh-hold-the-ground', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'), NULL,
  'Manter Posição', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, FALSE,
  'Reação: reduz deslocamento forçado em até seu Deslocamento', 'Quando for movido sem usar seu deslocamento por uma criatura, pode usar uma Reação para reduzir a distância em que foi movido em até seu Deslocamento.',
  NULL, NULL, 502, NULL, NULL
),
(
  'feat-gh-trick-shot', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'), NULL,
  'Tiro Improvisado', 'reaction'::rpg.action_economy_bucket, 4,
  NULL, NULL, FALSE,
  'Reação: ataque à distância com pistola após inimigo mover perto', 'Imediatamente depois que uma criatura a até 1,5 m de você se mover, pode usar uma Reação para fazer um ataque à distância com uma Pistola de Pólvora Negra contra essa criatura.',
  NULL, NULL, 503, NULL, NULL
),
(
  'feat-gh-dodge-spells', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'), NULL,
  'Esquivar Magias', 'reaction'::rpg.action_economy_bucket, 4,
  NULL, NULL, FALSE,
  'Reação: salvaguarda de Sabedoria vs magia só em você', 'Pode usar uma Reação para evitar uma magia que tenha apenas você como alvo e não crie uma área de efeito. Faça uma salvaguarda de Sabedoria contra a CD de salvaguarda da magia do conjurador. Em um sucesso, a criatura deve escolher um novo alvo ou a magia é cancelada.',
  NULL, NULL, 504, NULL, NULL
),
(
  'feat-gh-lightning-dual-target', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), NULL,
  'Alvo Duplo', 'bonus'::rpg.action_economy_bucket, 4,
  NULL, NULL, FALSE,
  'AB: segundo alvo no truque de uma ação', 'Quando conjura um truque com tempo de conjuração de uma ação que tem como alvo uma única criatura, pode usar uma Ação Bônus para escolher uma segunda criatura dentro do alcance do truque.',
  NULL, NULL, 505, NULL, NULL
),
(
  'feat-gh-lightning-immediate-response', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'), NULL,
  'Resposta Imediata', 'reaction'::rpg.action_economy_bucket, 4,
  'lightning-immediate-response', NULL, TRUE,
  'Reação: magia sem gastar espaço (1×/DL)', 'Quando conjura uma magia como Reação, essa magia não gasta um espaço de magia. 1× até o próximo Descanso Longo.',
  'spend-resource', NULL, 506, NULL, NULL
),
(
  'feat-gh-iron-gut-quick-recover', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'), NULL,
  'Recuperação Rápida', 'bonus'::rpg.action_economy_bucket, 4,
  'iron-gut-quick-recover', NULL, TRUE,
  'AB: gaste 1 DV + mod. Con → cura (1×/DC ou DL)', 'Como Ação Bônus, pode gastar um de seus Dados de Vida, rolar o dado e somar seu modificador de Constituição, recuperando Pontos de Vida iguais ao total da rolagem. 1× até Descanso Curto ou Longo.',
  'spend-resource', NULL, 507, NULL, NULL
),
(
  'feat-gh-insightful-study', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'), NULL,
  'Intuição de Objeto', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, FALSE,
  'Estudar objeto mágico sem sintonizar', 'Pode realizar a ação Estudar para examinar um objeto mágico e aprender suas propriedades e como usá-lo sem sintonizar com ele ou passar um Descanso Curto em contato físico com ele, mas não aprende nenhuma maldição que o item possa carregar.',
  NULL, NULL, 508, NULL, NULL
),
(
  'feat-gh-dual-shot', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'dual-shot'), NULL,
  'Disparo Duplo', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, FALSE,
  'Atacar: segundo alvo perto do primeiro (ambos com Desvantagem)', 'Quando realiza a ação Atacar no seu turno e ataca com um arco ou besta, pode fazer um ataque extra como parte da mesma ação contra uma criatura que esteja a até 3 m do alvo original e dentro do alcance da arma. Se o fizer, ambos os ataques são feitos com Desvantagem.',
  NULL, NULL, 509, NULL, NULL
),
(
  'feat-gh-opportunist-exploit', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'opportunist'), NULL,
  'Explorar Fraqueza', 'reaction'::rpg.action_economy_bucket, 1,
  NULL, NULL, FALSE,
  'Reação: +2 em ataque e dano', 'Sempre que faz um ataque como parte de uma Reação, ganha +2 nas jogadas de ataque e de dano.',
  NULL, NULL, 510, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
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
