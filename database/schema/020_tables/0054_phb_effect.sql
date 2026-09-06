CREATE TABLE rpg.phb_effect (
  id BIGSERIAL PRIMARY KEY,
  kind rpg.effect_kind NOT NULL,
  owner_kind rpg.effect_owner_kind NOT NULL,
  owner_id BIGINT NOT NULL,
  trigger rpg.effect_trigger NOT NULL,
  unlock_level INTEGER NOT NULL DEFAULT 1
    CHECK (unlock_level BETWEEN 1 AND 20),
  sort_order INTEGER NOT NULL DEFAULT 0,
  min_trait_takes INTEGER NOT NULL DEFAULT 1
    CHECK (min_trait_takes >= 1),
  action_slug TEXT NULL,
  resource_slug TEXT NULL,
  label TEXT NULL,
  requires_option_key TEXT NULL,
  requires_option_value TEXT NULL,
  CONSTRAINT phb_effect_table_action_trigger CHECK (
    (trigger = 'on_table_action' AND action_slug IS NOT NULL)
    OR (trigger <> 'on_table_action')
  ),
  CONSTRAINT phb_effect_resource_spend_trigger CHECK (
    (trigger = 'on_resource_spend' AND resource_slug IS NOT NULL)
    OR (trigger <> 'on_resource_spend')
  ),
  CONSTRAINT phb_effect_requires_option CHECK (
    (requires_option_key IS NULL AND requires_option_value IS NULL)
    OR (requires_option_key IS NOT NULL AND requires_option_value IS NOT NULL)
  )
);

CREATE INDEX idx_phb_effect_owner
  ON rpg.phb_effect (owner_kind, owner_id);

CREATE INDEX idx_phb_effect_kind_trigger
  ON rpg.phb_effect (kind, trigger);

CREATE INDEX idx_phb_effect_action_slug
  ON rpg.phb_effect (action_slug)
  WHERE action_slug IS NOT NULL;

CREATE INDEX idx_phb_effect_resource_slug
  ON rpg.phb_effect (resource_slug)
  WHERE resource_slug IS NOT NULL;
