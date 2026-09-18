-- Transe do Cavaleiro da Pele: enter/end + restaurar via Fúria

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES
(
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'skinrider-s-trance-end',
  'Encerrar Transe do Cavaleiro da Pele',
  10,
  NULL,
  false,
  false,
  false,
  NULL,
  NULL
),
(
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'skinrider-trance-rage-recover',
  'Restaurar Transe do Cavaleiro da Pele',
  10,
  NULL,
  false,
  false,
  false,
  NULL,
  NULL
)
ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'gh-barbarian-pathofthe-primal-spirit-skinrider-s-trance-end',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'Encerrar Transe',
  'free'::rpg.action_economy_bucket,
  10,
  NULL,
  NULL,
  false,
  'Sem ação: sair do transe',
  'Encerra o Transe do Cavaleiro da Pele (sem ação). O corpo deixa o estado catatônico.',
  'skinrider-s-trance-end',
  NULL,
  354
),
(
  'gh-barbarian-pathofthe-primal-spirit-skinrider-trance-rage-recover',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'Restaurar Transe do Cavaleiro da Pele',
  'free'::rpg.action_economy_bucket,
  10,
  'rage',
  NULL,
  true,
  'Gaste 1 Fúria: restaurar uso',
  'Sem ação: gaste 1 uso de Fúria para restaurar o Transe do Cavaleiro da Pele.',
  'skinrider-trance-rage-recover',
  NULL,
  355
)
ON CONFLICT (action_id) DO UPDATE SET
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
  sort_order = EXCLUDED.sort_order;

UPDATE rpg.phb_class_economy_action
SET
  name = 'Transe do Cavaleiro da Pele',
  summary = 'Ação Mágica: possuir companheiro primal',
  description = 'Ação Mágica: entre em transe e possua seu companheiro primal (ou Fera sob Amizade Animal a até 18 m — declare na mesa). PV, Dados de Vida, FOR/DES/CON, deslocamento e sentidos passam a ser os da criatura. Seu corpo fica catatônico. Duração: até ½ nível de Bárbaro + modificador de Constituição (horas). 1×/DL; restaure gastando 1 Fúria.'
WHERE action_id = 'gh-barbarian-pathofthe-primal-spirit-skinrider-s-trance';

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
)
VALUES
(
  'barbarian|pathofthe-primal-spirit|skinrider-s-trance',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'skinrider-s-trance',
  'Transe do Cavaleiro da Pele',
  'Ação Mágica: possuir o companheiro primal (1×/DL)',
  10,
  'skinrider-trance',
  'subclass'::rpg.panel_action_section,
  false,
  18
),
(
  'barbarian|pathofthe-primal-spirit|skinrider-s-trance-end',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'skinrider-s-trance-end',
  'Encerrar Transe',
  'Sair do transe (sem ação)',
  10,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  19
),
(
  'barbarian|pathofthe-primal-spirit|skinrider-trance-rage-recover',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'skinrider-trance-rage-recover',
  'Restaurar Transe',
  'Gaste 1 Fúria para restaurar o uso',
  10,
  'rage',
  'subclass'::rpg.panel_action_section,
  false,
  20
)
ON CONFLICT (panel_key) DO UPDATE SET
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  sort_order = EXCLUDED.sort_order;
