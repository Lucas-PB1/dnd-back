-- Wild Companion (Companheiro Selvagem) PHB 2024.

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT
  'druid-wild-companion', c.id, NULL, 'Companheiro Selvagem',
  'action'::rpg.action_economy_bucket, 2, NULL, NULL, false,
  'Forma ou espaço → Convocar Familiar (Fey)',
  'Ação Mágica: gaste 1 Forma Selvagem (ou informe slotLevel) + spiritVariantKey. Familiar Fey até Descanso Longo.',
  'wild-companion', NULL, 52
FROM rpg.phb_class c
WHERE c.slug = 'druid'
ON CONFLICT (action_id) DO UPDATE SET
  table_action = EXCLUDED.table_action,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
)
SELECT 'wild_companion'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
       'on_table_action'::rpg.effect_trigger, 'wild-companion', 2, 5,
       'Companheiro Selvagem'
FROM rpg.phb_class c
WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'class' AND e.owner_id = c.id
      AND e.action_slug = 'wild-companion'
  );

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id,
  'Companheiro Selvagem: Convocar Familiar (Fey) gastando Forma ou espaço; some no Descanso Longo.'
FROM rpg.phb_effect e
JOIN rpg.phb_class c ON c.id = e.owner_id AND e.owner_kind = 'class'
WHERE c.slug = 'druid'
  AND e.action_slug = 'wild-companion'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect_note n WHERE n.effect_id = e.id
  );

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title,
  unlock_level, resource_slug, section, spends_focus, sort_order
)
SELECT
  'druid|wild-companion', c.id, NULL, 'wild-companion',
  'Companheiro Selvagem',
  'Forma ou espaço → Familiar Fey (spiritVariantKey)',
  2, NULL, 'base'::rpg.panel_action_section, false, 0
FROM rpg.phb_class c
WHERE c.slug = 'druid'
ON CONFLICT (panel_key) DO UPDATE SET
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title;
