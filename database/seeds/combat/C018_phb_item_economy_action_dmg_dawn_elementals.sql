-- DMG lote §0 #4b: economy 1×/amanhecer (elementais)
-- Ver docs/source/dmg-item-mesa-taxonomy-dawn-elementals.yaml

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-braseiro-de-comandar-elementais-do-fogo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'braseiro-de-comandar-elementais-do-fogo'), NULL,
  'Braseiro · Elemental do Fogo', 'action'::rpg.action_economy_bucket, 1,
  'braseiroFogoUse', NULL, true,
  'Usar Magia: invocar Elemental do Fogo (1×/amanhecer)',
  'Enquanto estiver a até 1,5 metro deste braseiro, você pode executar uma ação Usar Magia para invocar um Elemental do Fogo. O elemental aparece em um espaço desocupado próximo ao braseiro, entende seus idiomas, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. Ele desaparece após 1 hora, quando morre ou quando você o dispensa como uma Ação Bônus. O braseiro não pode ser utilizado novamente desse modo até o próximo amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 610, NULL, NULL
),
(
  'item-incensario-de-controlar-elementais-do-ar-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'incensario-de-controlar-elementais-do-ar'), NULL,
  'Incensário · Elemental do Ar', 'action'::rpg.action_economy_bucket, 1,
  'incensarioArUse', NULL, true,
  'Usar Magia: invocar Elemental do Ar (1×/amanhecer; precisa de incenso)',
  'Enquanto incenso estiver queimando neste incensário, você pode executar uma ação Usar Magia para invocar um Elemental do Ar. O elemental aparece em um espaço desocupado próximo, entende seus idiomas, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. Ele desaparece após 1 hora, quando morre ou quando você o dispensa como uma Ação Bônus. O incensário não pode ser utilizado novamente desse modo até o próximo amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 611, NULL, NULL
),
(
  'item-pedra-de-controlar-elementais-da-terra-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'pedra-de-controlar-elementais-da-terra'), NULL,
  'Pedra · Elemental da Terra', 'action'::rpg.action_economy_bucket, 1,
  'pedraTerraUse', NULL, true,
  'Usar Magia: invocar Elemental da Terra (1×/amanhecer)',
  'Ao tocar esta pedra de 2,5 kg no chão, você pode executar uma ação Usar Magia para invocar um Elemental da Terra. O elemental aparece em um espaço desocupado à sua escolha e a até 9 metros de você, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. O elemental desaparece após 1 hora, quando morre ou quando você o dispensar como uma Ação Bônus. A pedra não pode ser usada dessa maneira novamente até o próximo amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 612, NULL, NULL
),
(
  'item-tigela-de-comandar-elementais-da-agua-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tigela-de-comandar-elementais-da-agua'), NULL,
  'Tigela · Elemental da Água', 'action'::rpg.action_economy_bucket, 1,
  'tigelaAguaUse', NULL, true,
  'Usar Magia: invocar Elemental da Água (1×/amanhecer; tigela com água)',
  'Enquanto a tigela estiver cheia de água e você estiver a até 1,5 metro dela, você pode executar uma ação Usar Magia para invocar um Elemental da Água. O elemental aparece em um espaço desocupado próximo à tigela, entende seus idiomas, obedece aos seus comandos e age imediatamente após sua contagem de iniciativa. Ele desaparece após 1 hora, quando morre ou quando você o dispensa como uma Ação Bônus. A tigela não pode ser utilizada novamente desse modo até o próximo amanhecer (MVP: recupera no Descanso Longo).',
  'spend-resource', 1, 613, NULL, NULL
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
