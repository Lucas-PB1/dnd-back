-- Forward: mesa patrulheiro/monge — start_concentration, schedule dice MA, economy fixes.

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'start_concentration';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_2d_schedule';
ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_3d_schedule';

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT
  'ranger-set-bestial-aspect',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
  'Aspecto Bestial',
  'bonus'::rpg.action_economy_bucket,
  3,
  NULL, NULL, false,
  'Defina o nível de Aspecto Bestial (0–5)',
  'Ajuste o tracker de Aspecto Bestial na ficha (mesa).',
  'set-bestial-aspect',
  NULL,
  47
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_class_economy_action WHERE action_id = 'ranger-set-bestial-aspect'
);

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
) VALUES
(
  'ranger-primal-companion-summon',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
  'Invocar Companheiro Primal',
  'free'::rpg.action_economy_bucket,
  3,
  NULL, NULL, false,
  'Sincroniza o companheiro com as escolhas da ficha',
  'Invoca/sincroniza o Companheiro Primal conforme as opções da ficha.',
  'primal-companion-summon',
  NULL,
  372
),
(
  'ranger-primal-companion-restore',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
  'Restaurar Companheiro Primal',
  'free'::rpg.action_economy_bucket,
  3,
  NULL, NULL, false,
  'Restaura PV do companheiro e sincroniza ficha',
  'Restaura o companheiro ao PV máximo e sincroniza a ficha.',
  'primal-companion-restore',
  NULL,
  373
)
ON CONFLICT (action_id) DO UPDATE SET
  name = EXCLUDED.name,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  sort_order = EXCLUDED.sort_order;

UPDATE rpg.phb_class_economy_action
SET always_spends_resource = true
WHERE action_id IN (
  'ranger-hunters-mark',
  'monk-flurry',
  'monk-patient-defense',
  'monk-step-of-the-wind',
  'monk-stunning-strike',
  'monk-wholeness-of-body',
  'monk-hand-of-healing',
  'monk-hand-of-harm',
  'monk-flurry-healing-harm',
  'monk-knockout'
);

UPDATE rpg.phb_class_economy_action
SET spend_amount = 2
WHERE action_id = 'monk-elemental-blast' AND spend_amount IS DISTINCT FROM 2;
