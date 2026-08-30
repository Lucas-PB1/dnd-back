-- DMG §0 #6: economy Anel das Estrelas Cadentes (multi-ação + pool)
-- Ver docs/source/extracts/dmg/wiring-status.md

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-anel-das-estrelas-cadentes-luzes', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'), NULL,
  'Anel · Luz / Luzes Dançantes', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Conjurar Luz ou Luzes Dançantes (sem gastar carga)',
  'Você pode conjurar Luzes Dançantes ou Luz a partir do anel (sem gastar cargas).',
  NULL, NULL, 630, NULL, NULL
),
(
  'item-anel-das-estrelas-cadentes-esferas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'), NULL,
  'Anel · Esferas de Relâmpago', 'action'::rpg.action_economy_bucket, 1,
  'starRingCharges', NULL, true,
  'Usar Magia: 2 cargas → até 4 esferas (Conc. 1 min)',
  'Gaste 2 cargas como ação Usar Magia para criar até quatro esferas de relâmpago (90 cm). Cada esfera aparece em espaço desocupado à vista a até 36 m, permanece com Concentração até 1 min e projeta Meia-luz 9 m. Ao chegar a 1,5 m de outra criatura sem Cobertura Total, descarrega: salvaguarda DES CD 15; falha = dano elétrico pela tabela (1 esfera 4d12 … 4 esferas 2d4); sucesso = metade. Cargas: 6; recupera 1d6 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 2, 631, NULL, NULL
),
(
  'item-anel-das-estrelas-cadentes-mover-esferas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'), NULL,
  'Anel · Mover esferas', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: mover cada esfera até 9 m (até 36 m de você)',
  'Com uma Ação Bônus, você pode mover cada esfera até 9 metros a até 36 metros de si. Na primeira vez que a esfera chegar a 1,5 metro de uma criatura diferente de você que não esteja atrás de Cobertura Total, a esfera descarrega e desaparece (ver Esferas de Relâmpago).',
  NULL, NULL, 632, NULL, NULL
),
(
  'item-anel-das-estrelas-cadentes-estrelas-1', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'), NULL,
  'Anel · Estrelas Cadentes (1)', 'action'::rpg.action_economy_bucket, 1,
  'starRingCharges', NULL, true,
  'Usar Magia: 1 carga → Cubo 4,5 m / 5d4 radiante (CD 15)',
  'Gaste 1 carga como ação Usar Magia: lance uma partícula a um ponto à vista a até 18 m. Cada criatura em um Cubo de 4,5 m originado desse ponto: salvaguarda DES CD 15; falha 5d4 radiante; sucesso metade.',
  'spend-resource', 1, 633, NULL, NULL
),
(
  'item-anel-das-estrelas-cadentes-estrelas-2', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'), NULL,
  'Anel · Estrelas Cadentes (2)', 'action'::rpg.action_economy_bucket, 1,
  'starRingCharges', NULL, true,
  'Usar Magia: 2 cargas → 2 partículas (cada Cubo 4,5 m / 5d4)',
  'Gaste 2 cargas como ação Usar Magia: para cada carga, lance uma partícula a um ponto à vista a até 18 m. Cada criatura em um Cubo de 4,5 m: salvaguarda DES CD 15; falha 5d4 radiante; sucesso metade.',
  'spend-resource', 2, 634, NULL, NULL
),
(
  'item-anel-das-estrelas-cadentes-estrelas-3', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'), NULL,
  'Anel · Estrelas Cadentes (3)', 'action'::rpg.action_economy_bucket, 1,
  'starRingCharges', NULL, true,
  'Usar Magia: 3 cargas → 3 partículas (cada Cubo 4,5 m / 5d4)',
  'Gaste 3 cargas como ação Usar Magia: para cada carga, lance uma partícula a um ponto à vista a até 18 m. Cada criatura em um Cubo de 4,5 m: salvaguarda DES CD 15; falha 5d4 radiante; sucesso metade.',
  'spend-resource', 3, 635, NULL, NULL
),
(
  'item-anel-das-estrelas-cadentes-fogo-fadas', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'anel-das-estrelas-cadentes'), NULL,
  'Anel · Fogo das Fadas', 'action'::rpg.action_economy_bucket, 1,
  'starRingCharges', NULL, true,
  'Gastar 1 carga: conjurar Fogo das Fadas',
  'Você pode gastar 1 carga para conjurar Fogo das Fadas a partir do anel. Cargas: 6; recupera 1d6 ao amanhecer (MVP: Descanso Longo).',
  'spend-resource', 1, 636, NULL, NULL
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
