-- DMG lote §0 #4: economy 1×/amanhecer (spend-resource)
-- Ver docs/source/dmg-item-mesa-taxonomy-dawn.yaml

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-amuleto-mecanico-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'amuleto-mecanico'), NULL,
  'Amuleto Mecânico · d20 = 10', 'free'::rpg.action_economy_bucket, 1,
  'amuletoMecanicoUse', NULL, true,
  'Em jogada de ataque: usar 10 no d20 (1×/amanhecer)',
  'Ao realizar uma jogada de ataque enquanto utiliza o amuleto, você pode usar um 10 em vez de jogar um d20. Uma vez usada, esta propriedade não pode ser usada novamente até o próximo amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 600, NULL, NULL
),
(
  'item-diadema-da-explosao-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'diadema-da-explosao'), NULL,
  'Diadema · Raio Ardente', 'action'::rpg.action_economy_bucket, 1,
  'diademaExplosaoUse', NULL, true,
  'Conjurar Raio Ardente (+5 acerto) 1×/amanhecer',
  'Enquanto estiver vestindo esta diadema, você pode conjurar Raio Ardente com ela (bônus de +5 para acertar). O diadema não pode conjurar esta magia novamente até o próximo amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 601, NULL, NULL
),
(
  'item-periapto-de-saude-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'periapto-de-saude'), NULL,
  'Periapto · Recuperar PV', 'action'::rpg.action_economy_bucket, 1,
  'periaptSaudeUse', NULL, true,
  'Usar Magia: recuperar 2d4+2 PV (1×/amanhecer)',
  'Ao usar este pingente, você pode executar uma ação Usar Magia para recuperar 2d4 + 2 Pontos de Vida. Uma vez usada, esta propriedade não pode ser utilizada novamente até o próximo amanhecer (MVP: recupera no Descanso Longo). Além disso, você tem Vantagem nas salvaguardas para evitar ou encerrar a condição Envenenado enquanto usa este pingente (passivo — lembrete).',
  'spend-resource', 1, 602, NULL, NULL
),
(
  'item-perola-de-poder-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'perola-de-poder'), NULL,
  'Pérola · Recuperar espaço', 'action'::rpg.action_economy_bucket, 1,
  'perolaPoderUse', NULL, true,
  'Usar Magia: recuperar 1 espaço ≤ 3º (1×/amanhecer)',
  'Enquanto esta pérola estiver em sua posse, você pode executar uma ação Usar Magia para recuperar um espaço de magia gasto de 3º círculo ou inferior. Após usar a pérola, ela não pode ser usada novamente até o próximo amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 603, NULL, NULL
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
