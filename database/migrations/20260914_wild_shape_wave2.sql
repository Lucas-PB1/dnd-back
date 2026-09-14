-- Wild Shape onda 2: known forms, actor id, faixas de formas conhecidas.

CREATE TABLE IF NOT EXISTS rpg.phb_wild_shape_known_band (
  min_level INT PRIMARY KEY CHECK (min_level BETWEEN 1 AND 20),
  forms_known INT NOT NULL CHECK (forms_known BETWEEN 1 AND 20)
);

INSERT INTO rpg.phb_wild_shape_known_band (min_level, forms_known) VALUES
  (2, 4),
  (4, 6),
  (8, 8)
ON CONFLICT (min_level) DO UPDATE SET
  forms_known = EXCLUDED.forms_known;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS wild_shape_known_slugs TEXT[] NOT NULL DEFAULT '{}';

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS wild_shape_form_swap_available BOOLEAN NOT NULL DEFAULT TRUE;

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS wild_shape_actor_id UUID
    REFERENCES rpg.game_actor(id) ON DELETE SET NULL;

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order
)
SELECT v.action_id, c.id, NULL, v.name, v.economy::rpg.action_economy_bucket,
       v.unlock_level, NULL, NULL, false, v.summary, v.description, v.table_action, NULL, v.sort_order
FROM (VALUES
  ('druid-set-wild-shape-known-forms', 'Definir Formas Conhecidas', 'free', 2,
   'Lista inicial / preencher slots', 'Defina templateSlugs (até o máximo do nível).', 'set-wild-shape-known-forms', 52),
  ('druid-replace-wild-shape-known-form', 'Trocar Forma Conhecida', 'free', 2,
   '1 troca após Descanso Longo', 'replaceSlug + templateSlug (nova besta elegível).', 'replace-wild-shape-known-form', 52)
) AS v(action_id, name, economy, unlock_level, summary, description, table_action, sort_order)
CROSS JOIN rpg.phb_class c
WHERE c.slug = 'druid'
ON CONFLICT (action_id) DO UPDATE SET
  table_action = EXCLUDED.table_action,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_effect (
  kind, owner_kind, owner_id, trigger, action_slug, unlock_level, sort_order, label
)
SELECT 'wild_shape'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
       'on_table_action'::rpg.effect_trigger, v.action_slug, 2, v.sort_order, v.label
FROM rpg.phb_class c
CROSS JOIN (VALUES
  ('set-wild-shape-known-forms', 3, 'Definir Formas Conhecidas'),
  ('replace-wild-shape-known-form', 4, 'Trocar Forma Conhecida')
) AS v(action_slug, sort_order, label)
WHERE c.slug = 'druid'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_effect e
    WHERE e.owner_kind = 'class' AND e.owner_id = c.id
      AND e.action_slug = v.action_slug
  );

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title,
  unlock_level, resource_slug, section, spends_focus, sort_order
)
SELECT v.panel_key, c.id, NULL, v.slug, v.name, v.title,
       2, v.resource_slug, 'base'::rpg.panel_action_section, false, v.sort_order
FROM (VALUES
  ('druid|wild-shape', 'wild-shape', 'Forma Selvagem', 'Assuma besta conhecida (templateSlug)', 'wildShape', 0),
  ('druid|wild-shape-end', 'wild-shape-end', 'Encerrar Forma Selvagem', 'Sai da Forma Selvagem', NULL, 0),
  ('druid|set-wild-shape-known-forms', 'set-wild-shape-known-forms', 'Definir Formas Conhecidas', 'Lista inicial / preencher slots', NULL, 0),
  ('druid|replace-wild-shape-known-form', 'replace-wild-shape-known-form', 'Trocar Forma Conhecida', '1 troca após DL', NULL, 0)
) AS v(panel_key, slug, name, title, resource_slug, sort_order)
CROSS JOIN rpg.phb_class c
WHERE c.slug = 'druid'
ON CONFLICT (panel_key) DO UPDATE SET
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  resource_slug = EXCLUDED.resource_slug;
