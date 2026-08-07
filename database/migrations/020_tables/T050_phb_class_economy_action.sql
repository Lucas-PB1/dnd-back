-- Class economy actions (Actions tab catalog)

CREATE TABLE rpg.phb_class_economy_action (
  id                      BIGSERIAL PRIMARY KEY,
  action_id               TEXT UNIQUE NOT NULL,
  class_id                BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id             BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  name                    TEXT NOT NULL,
  economy                 rpg.action_economy_bucket NOT NULL,
  unlock_level            INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  resource_slug           TEXT NULL,
  free_resource_slug      TEXT NULL,
  always_spends_resource  BOOLEAN NOT NULL DEFAULT false,
  summary                 TEXT NULL,
  description             TEXT NULL,
  table_action            TEXT NULL,
  spend_amount            INT NULL CHECK (spend_amount IS NULL OR spend_amount >= 1),
  sort_order              INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_class_economy_action_class ON rpg.phb_class_economy_action(class_id);
CREATE INDEX idx_class_economy_action_subclass ON rpg.phb_class_economy_action(subclass_id);
