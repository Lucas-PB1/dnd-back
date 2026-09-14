-- Wild Shape modular onda 1: faixas CR, estado na ficha, economy/effect fix.
-- (kind `wild_shape` em 20260914_wild_shape_kind.sql)

CREATE TABLE IF NOT EXISTS rpg.phb_wild_shape_cr_band (
  min_level INT PRIMARY KEY CHECK (min_level BETWEEN 1 AND 20),
  cr_max TEXT NOT NULL,
  allow_fly BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO rpg.phb_wild_shape_cr_band (min_level, cr_max, allow_fly) VALUES
  (2, '1/4', false),
  (4, '1/2', false),
  (8, '1', true)
ON CONFLICT (min_level) DO UPDATE SET
  cr_max = EXCLUDED.cr_max,
  allow_fly = EXCLUDED.allow_fly;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS wild_shape_active BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS wild_shape_template_slug TEXT NULL;

UPDATE rpg.phb_class_economy_action
SET table_action = 'wild-shape',
    always_spends_resource = true,
    summary = 'Forma Selvagem (besta do catálogo)',
    description = 'Assuma uma besta elegível (CR × nível). Informe templateSlug.'
WHERE action_id = 'druid-wild-shape';

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT
  'druid-wild-shape-end',
  c.id,
  NULL,
  'Encerrar Forma Selvagem',
  'free'::rpg.action_economy_bucket,
  2,
  NULL,
  NULL,
  false,
  'Sai da Forma Selvagem',
  'Encerra a Forma Selvagem na ficha (sem gastar uso).',
  'wild-shape-end',
  NULL,
  53
FROM rpg.phb_class c
WHERE c.slug = 'druid'
ON CONFLICT (action_id) DO UPDATE SET
  table_action = EXCLUDED.table_action,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description;

UPDATE rpg.phb_effect e
SET kind = 'wild_shape'::rpg.effect_kind,
    label = 'Forma Selvagem'
FROM rpg.phb_class c
WHERE e.owner_kind = 'class'
  AND e.owner_id = c.id
  AND c.slug = 'druid'
  AND e.action_slug = 'wild-shape'
  AND e.trigger = 'on_table_action';

UPDATE rpg.phb_effect_note n
SET note = 'Forma Selvagem: assume besta elegível do catálogo (templateSlug).'
FROM rpg.phb_effect e
JOIN rpg.phb_class c ON c.id = e.owner_id AND e.owner_kind = 'class'
WHERE n.effect_id = e.id
  AND c.slug = 'druid'
  AND e.action_slug = 'wild-shape';

INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
)
SELECT 'wild_shape'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
       'on_table_action'::rpg.effect_trigger, 'wild-shape-end', 2, 2,
       'Encerrar Forma Selvagem'
FROM rpg.phb_class c
WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'class' AND e.owner_id = c.id
      AND e.action_slug = 'wild-shape-end'
  );

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Forma Selvagem encerrada na ficha.'
FROM rpg.phb_effect e
JOIN rpg.phb_class c ON c.id = e.owner_id AND e.owner_kind = 'class'
WHERE c.slug = 'druid'
  AND e.action_slug = 'wild-shape-end'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect_note n WHERE n.effect_id = e.id
  );