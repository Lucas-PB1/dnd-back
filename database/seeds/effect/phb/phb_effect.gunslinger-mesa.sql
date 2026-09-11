-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Mesa pistoleiro: manobras + armas de fogo.

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'catalog_maneuver'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'use-maneuver', 2, 1,
         'Usar Manobra'
  FROM cls
  RETURNING id
)
SELECT 1 FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT 'recover_resource'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, 'recover-risk', 15, 1,
         'Gambito Terrível'
  FROM cls
  RETURNING id
)
INSERT INTO rpg.phb_effect_resource (effect_id, resource_slug, amount)
SELECT id, 'risk', 1 FROM ins;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN cls ON cls.id = e.owner_id
  WHERE e.action_slug = 'recover-risk'
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Gambito Terrível: recuperou 1 Dado de Risco (marque ao rolar Iniciativa ou crítico).'
FROM fx;

WITH cls AS (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
  )
  SELECT v.kind::rpg.effect_kind, 'class'::rpg.effect_owner_kind, cls.id,
         'on_table_action'::rpg.effect_trigger, v.action_slug, 2, 1, v.label
  FROM cls
  CROSS JOIN (VALUES
    ('firearm_reload', 'reload-firearm', 'Recarregar'),
    ('firearm_fire', 'fire-chamber', 'Disparar')
  ) AS v(kind, action_slug, label)
  RETURNING id, action_slug
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE action_slug
    WHEN 'reload-firearm' THEN 'Recarregou a arma de fogo (itemSlug na requisição).'
    ELSE 'Gastou tiro(s) do tambor (itemSlug e shots na requisição).'
  END
FROM ins;
