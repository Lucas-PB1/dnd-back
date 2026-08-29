-- Economy espécie — Northlands Heroes of the Sagas

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'species-bearfolk-apex-predator', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'), NULL,
  'Predador de Ápice', 'free'::rpg.action_economy_bucket, 1,
  'bearfolk-apex-predator', NULL, true,
  'Soma FOR ou CON a um teste de Carisma',
  'Ao fazer um teste de Carisma, some o modificador de Força ou Constituição (escolhido na criação). Usos = PB / Descanso Longo.',
  'spend-resource', NULL, 320,
  NULL, NULL
),
(
  'species-bearfolk-bear-hug', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'bearfolk'), NULL,
  'Abraço do Urso', 'bonus'::rpg.action_economy_bucket, 1,
  'bearfolk-bear-hug', NULL, true,
  'AB: Ataque Desarmado após acertar',
  'Ao acertar e causar dano com um ataque: Ação Bônus para Ataque Desarmado. Usos = mod. Constituição (mín. 1) / Descanso Longo.',
  'spend-resource', NULL, 321,
  'bearfolkLineageId', 'garhamr'
),
(
  'species-giantkin-burning-blood', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'giantkin'), NULL,
  'Sangue Ardente', 'reaction'::rpg.action_economy_bucket, 1,
  'giantkin-burning-blood', NULL, true,
  'Reação: 1d6 Ígneo a 1,5 m (DES)',
  'Ao sofrer dano Perfurante ou Cortante: Reação — criatura a 1,5 m faz salvaguarda de Destreza ou sofre 1d6 Ígneo (+1d6 nos nv. 5/11/17). Usos = PB / Descanso Longo.',
  'spend-resource', NULL, 330,
  'giantkinAncestryId', 'fire'
),
(
  'species-trollkin-fey-charm', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'trollkin'), NULL,
  'Dado Fey', 'free'::rpg.action_economy_bucket, 1,
  'trollkin-fey-charm', NULL, true,
  '+1d6 em teste de Carisma',
  'Ao fazer um teste que use Carisma, role 1d6 e some. Usos = mod. Carisma / Descanso Longo.',
  'spend-resource', NULL, 340,
  'trollkinAncestryId', 'fey'
),
(
  'species-werekin-shift-aspect', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'werekin'), NULL,
  'Mudar Aspecto', 'bonus'::rpg.action_economy_bucket, 1,
  'werekin-shift-aspect', NULL, true,
  'AB: transformação 1 min (1×/DL)',
  'Ação Bônus: transforme-se 1 minuto. Escolha Força Bestial, Selvageria Primal ou Caçador Veloz. 1× / Descanso Longo.',
  'spend-resource', NULL, 350,
  NULL, NULL
),
(
  'species-baugsmidr-sense-magic', NULL,
  (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'), NULL,
  'Sentir Magia', 'bonus'::rpg.action_economy_bucket, 1,
  'baugsmidr-sense-magic', NULL, true,
  'AB: detectar magia e criaturas (36 m)',
  'Ação Bônus: sinta magia a 36 m até o fim do próximo turno; auras e escolas; Aberrações/Celestiais/Fey/Ínferos/Mortos-Vivos. Usos = PB / Descanso Longo.',
  'spend-resource', NULL, 360,
  'dwarfCultureId', 'baugsmidr'
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
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
