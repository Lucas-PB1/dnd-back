-- Fase 6: Arma Magificada — conjurar magia vinculada (1 carga)
-- spell_slug NULL: resolvido na instância (attached_coverage_spell_slug)

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-arma-magificada-cast', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'arma-magificada'), NULL,
  'Arma Magificada · Conjurar', 'action'::rpg.action_economy_bucket, 1,
  'armaMagificadaCharges', NULL, true,
  'Gastar 1 carga: conjurar a magia vinculada',
  'Enquanto segurar a arma, gaste 1 carga para conjurar a magia vinculada na criação (≤ 8º; Adivinhação, Evocação, Invocação, Necromancia ou Transmutação). Cargas: 6; recupera 1d6 ao amanhecer (MVP: Descanso Longo). CD/raridade conforme o círculo da magia (ver texto do item).',
  'spend-resource', 1, 700, NULL, NULL
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

-- Mantém spell_slug NULL (bound na peça)
UPDATE rpg.phb_class_economy_action
SET spell_slug = NULL
WHERE action_id = 'item-arma-magificada-cast';
