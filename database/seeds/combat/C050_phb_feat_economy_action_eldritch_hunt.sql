-- Feat economy — Steinhardt Eldritch Hunt

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'feat-faithful-divine-clarity', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'), NULL,
  'Clareza Divina', 'free'::rpg.action_economy_bucket, 1,
  'divineClarity', NULL, true,
  'Falhou vs Enfeitiçado/Amedrontado → sucesso (1×/DL)',
  'Se falhar numa salvaguarda contra Enfeitiçado ou Amedrontado, escolha sucesso em vez disso. 1× por Descanso Longo.',
  'spend-resource', NULL, 360, NULL, NULL
),
(
  'feat-grizzled-resist', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'), NULL,
  'Resistir', 'free'::rpg.action_economy_bucket, 1,
  'resistInspiration', NULL, true,
  'Ao ficar Ensanguentado → Inspiração Heróica (1×/DC+DL)',
  'Imediatamente após sofrer dano que o deixa Ensanguentado, ganha Inspiração Heróica. 1× até Descanso Curto ou Longo.',
  'spend-resource', NULL, 361, NULL, NULL
),
(
  'feat-brutalizer-deadly-sequence', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'brutalizer'), NULL,
  'Sequência Mortífera', 'bonus'::rpg.action_economy_bucket, 4,
  NULL, NULL, false,
  'AB: ataque extra com arma Leve (após Atacar com Duas Mãos)',
  'Após ação Atacar com arma Duas Mãos: Ação Bônus com arma Leve. Não some o modificador de atributo ao dano (salvo negativo ou Combate com Duas Armas).',
  NULL, NULL, 362, NULL, NULL
),
(
  'feat-cannoneer-reload', NULL, NULL,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'cannoneer'), NULL,
  'Recarregar Canhão', 'bonus'::rpg.action_economy_bucket, 8,
  NULL, NULL, false,
  'AB: recarregar Canhão (sem mover no turno; Desloc. 0)',
  'Recarregue um Canhão como Ação Bônus se não se moveu neste turno; depois Deslocamento 0 até o fim do turno. Nv. 11+: não zera Desloc.; pode trocar um ataque por recarregar. Nv. 20+: ignora Artilharia.',
  NULL, NULL, 363, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
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
