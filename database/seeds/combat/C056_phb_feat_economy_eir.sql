-- Economy — Bênção de Eir (Vitalidade). Mesa: gasta pool + nota (cura 1d4).

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'feat-eir-vitality-surge', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'), NULL,
  'Surto de Vitalidade', 'bonus'::rpg.action_economy_bucket, 1,
  'eir-vitality-points', NULL, true,
  'AB: gaste 1 Vitalidade → 1d4 PV',
  'Ação Bônus: gaste 1 Ponto de Vitalidade e recupere 1d4 PV. Se estiver Morrendo, gaste 1 para estabilizar (sem ação) — declare na mesa.',
  'spend-resource', NULL, 400,
  NULL, NULL
),
(
  'feat-eir-channel-vitality', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-eir'), NULL,
  'Canalizar Vitalidade', 'bonus'::rpg.action_economy_bucket, 1,
  'eir-vitality-points', NULL, true,
  'AB: gaste 1 Vitalidade → 1d4 PV no toque',
  'Ação Bônus: gaste 1 Ponto de Vitalidade; criatura que tocar recupera 1d4 PV. Role 1d4 na mesa.',
  'spend-resource', NULL, 401,
  NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  feat_id = EXCLUDED.feat_id,
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
