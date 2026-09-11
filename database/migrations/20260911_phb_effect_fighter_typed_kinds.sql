-- Forward: kinds tipados mesa guerreiro + fórmula dado de schedule.

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'check_boost';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'catalog_maneuver';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'strike_self_cost';

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'schedule_die_plus_flat';

UPDATE rpg.phb_class_economy_action
SET table_action = 'dungeon-precaution',
    always_spends_resource = true
WHERE action_id = 'fighter-dungeon-precautions'
  AND (
    table_action IS DISTINCT FROM 'dungeon-precaution'
    OR always_spends_resource IS DISTINCT FROM true
  );

UPDATE rpg.phb_class_economy_action
SET always_spends_resource = false
WHERE action_id = 'fighter-blood-strike'
  AND always_spends_resource IS DISTINCT FROM false;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT
  'fighter-use-maneuver',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
  'Usar Manobra',
  'free'::rpg.action_economy_bucket,
  3,
  'superiority-dice',
  NULL,
  false,
  'Gasta 1 dado de superioridade (ou Implacável)',
  'Escolha uma manobra conhecida; gaste um Dado de Superioridade (ou use Implacável no nv.15+).',
  'use-maneuver',
  NULL,
  17
WHERE NOT EXISTS (
  SELECT 1 FROM rpg.phb_class_economy_action WHERE action_id = 'fighter-use-maneuver'
);

-- Lembretes BM sem table_action: redundantes com `use-maneuver` + GET maneuvers.
DELETE FROM rpg.phb_class_economy_action
WHERE action_id IN (
  'fighter-bm-lunging-attack',
  'fighter-bm-rally',
  'fighter-bm-feinting-attack',
  'fighter-bm-parry',
  'fighter-bm-riposte'
);
