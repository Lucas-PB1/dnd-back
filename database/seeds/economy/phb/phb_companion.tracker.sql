-- Espírito Primal: feature de escolha do companheiro + painel C010

UPDATE rpg.phb_subclass_feature
SET
  feature_kind = 'choice'::rpg.subclass_feature_kind,
  option_key = 'primalCompanionStatBlock'
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit')
  AND level = 3
  AND name = 'Primordial Companheiro';

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
)
VALUES
(
  'barbarian|pathofthe-primal-spirit|primal-companion-summon',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'primal-companion-summon',
  'Invocar Companheiro',
  'Sincroniza o companheiro com as escolhas da ficha',
  3,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  20
),
(
  'ranger|beast-master|primal-companion-summon',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
  'primal-companion-summon',
  'Invocar Companheiro',
  'Sincroniza o companheiro com as escolhas da ficha',
  3,
  NULL,
  'subclass'::rpg.panel_action_section,
  false,
  7
)
ON CONFLICT (panel_key) DO UPDATE SET
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'barbarian-primal-companion-summon',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'Invocar Companheiro Primal',
  'free'::rpg.action_economy_bucket,
  3,
  NULL, NULL, false,
  'Sincroniza o companheiro com as escolhas da ficha',
  'Invoca/sincroniza o Espírito Primal conforme as opções da ficha.',
  'primal-companion-summon',
  NULL,
  370
),
(
  'barbarian-primal-companion-restore',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
  'Restaurar Companheiro Primal',
  'free'::rpg.action_economy_bucket,
  3,
  NULL, NULL, false,
  'Restaura PV do companheiro e sincroniza ficha',
  'Restaura o companheiro ao PV máximo e sincroniza a ficha.',
  'primal-companion-restore',
  NULL,
  371
)
ON CONFLICT (action_id) DO UPDATE SET
  name = EXCLUDED.name,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  sort_order = EXCLUDED.sort_order;
