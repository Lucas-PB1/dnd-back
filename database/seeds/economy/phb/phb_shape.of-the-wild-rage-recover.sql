-- Forma do Selvagem (Path of the Primal Spirit): recuperar uso gastando 1 Fúria

INSERT INTO rpg.phb_subclass_table_action (
  subclass_id, slug, name, unlock_level, free_resource_slug,
  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost
) VALUES
(
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'shape-of-the-wild-rage-recover',
  'Restaurar Forma do Selvagem',
  14,
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
  summary, description, table_action, spend_amount,
  recover_resource_slug, recover_amount, sort_order
) VALUES
(
  'gh-barbarian-pathofthe-primal-spirit-shape-of-the-wild-rage-recover',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'Restaurar Forma do Selvagem',
  'free'::rpg.action_economy_bucket,
  14,
  'rage',
  NULL,
  true,
  'Gaste 1 Fúria: restaurar uso',
  'Restaurou Forma do Selvagem gastando 1 uso de Fúria.',
  'shape-of-the-wild-rage-recover',
  NULL,
  'shape-of-the-wild',
  1,
  374
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
  recover_resource_slug = EXCLUDED.recover_resource_slug,
  recover_amount = EXCLUDED.recover_amount,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
)
VALUES
(
  'barbarian|pathofthe-primal-spirit|shape-of-the-wild-rage-recover',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'shape-of-the-wild-rage-recover',
  'Restaurar Forma do Selvagem',
  'Gaste 1 Fúria para restaurar o uso',
  14,
  'rage',
  'subclass'::rpg.panel_action_section,
  false,
  21
)
ON CONFLICT (panel_key) DO UPDATE SET
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  sort_order = EXCLUDED.sort_order;
