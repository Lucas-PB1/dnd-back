-- Economy actions — Sangromante (mecânicas sem keyword Action/Bonus no HTML)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'wizard-sangromancer-blood-for-blood',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  'Sangue por Sangue',
  'free'::rpg.action_economy_bucket,
  10,
  'sangromancy-dice',
  NULL,
  false,
  '1×/turno: dano extra = dado de Vida ou Sangromancia',
  'Uma vez por turno ao causar dano com magia de Mago, gaste um Dado de Vida ou um Dado de Sangromancia, role o dado e cause dano extra a um alvo igual ao resultado. Se o alvo estiver Ferido, role duas vezes e use o maior.',
  'blood-for-blood',
  NULL,
  415
),
(
  'wizard-sangromancer-red-renewal',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  'Renovação Rubra',
  'free'::rpg.action_economy_bucket,
  14,
  NULL,
  NULL,
  false,
  'Após DC: recupera metade dos Dados de Vida + Sangromancia',
  'Ao terminar um Descanso Curto, recupera Dados de Vida e Dados de Sangromancia gastos em quantidade igual à metade do seu nível de Mago. 1× até o próximo Descanso Longo.',
  'red-renewal',
  NULL,
  416
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  sort_order = EXCLUDED.sort_order;
