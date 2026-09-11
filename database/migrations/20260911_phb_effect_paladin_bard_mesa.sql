-- Forward: mesa paladino/bardo — fórmulas BI, kinds set_tracker / survive_at_zero apply.

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_2d8_plus_level';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'schedule_die_double_plus_flat';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'set_tracker';

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT
  'paladin-cure-poison',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  NULL,
  'Mãos Consagradas — Curar Veneno',
  'bonus'::rpg.action_economy_bucket,
  1,
  'layOnHands',
  NULL,
  true,
  'Gaste 5 PV da reserva para remover Envenenado',
  'Como Ação Bônus, gaste 5 pontos de Mãos Consagradas para remover a condição Envenenado de uma criatura que você toque.',
  'cure-poison',
  5,
  37
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_class_economy_action WHERE action_id = 'paladin-cure-poison'
);

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT
  'bard-set-persona-masks',
  (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  'Vestir Máscaras de Persona',
  'free'::rpg.action_economy_bucket,
  3,
  NULL,
  NULL,
  false,
  'Escolha máscaras equipadas (1 ou 2 no nv.14+)',
  'Defina quais máscaras de persona estão vestidas (até o máximo do nível).',
  'set-persona-masks',
  NULL,
  35
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_class_economy_action WHERE action_id = 'bard-set-persona-masks'
);
