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
