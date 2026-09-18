-- Economy — Northlands feats (BA declare na mesa)
-- Provocação (combat-flyting): Ação Bônus; salvaguarda CAR; −1 ataque acumulável.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'feat-combat-flyting-provoke', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'combat-flyting'), NULL,
  'Provocação', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'AB: provocação (−1 ataque; CD CAR)',
  'Ação Bônus: alvo a até 9 m que o ouça e compreenda — salvaguarda de Carisma (CD 8 + mod. Carisma + PB). Falha: −1 nas jogadas de ataque contra você (acumula até o mod. de Carisma; manter com AB a cada turno; máx. PB rodadas). Sucesso: imune às suas Provocações por 24 h. Mesa — declare o alvo e a CD.',
  'feat-combat-flyting-provoke', NULL, 410,
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
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
