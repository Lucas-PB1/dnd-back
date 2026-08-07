-- Subclass table actions (Psi Warrior, Soulknife, etc.)

CREATE TABLE rpg.phb_subclass_table_action (
  id                      BIGSERIAL PRIMARY KEY,
  subclass_id             BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  slug                    TEXT NOT NULL,
  name                    TEXT NOT NULL,
  unlock_level            INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  free_resource_slug      TEXT NULL,
  always_spends_pool      BOOLEAN NOT NULL DEFAULT false,
  rolls_pool_die          BOOLEAN NOT NULL DEFAULT false,
  spends_only_on_success  BOOLEAN NOT NULL DEFAULT false,
  always_pool_cost        INT NULL CHECK (always_pool_cost IS NULL OR always_pool_cost >= 1),
  repeat_pool_cost        INT NULL CHECK (repeat_pool_cost IS NULL OR repeat_pool_cost >= 1),
  UNIQUE(subclass_id, slug)
);

CREATE INDEX idx_subclass_table_action_subclass ON rpg.phb_subclass_table_action(subclass_id);
