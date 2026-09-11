CREATE TABLE rpg.phb_class_economy_action (
  id                      BIGSERIAL PRIMARY KEY,
  action_id               TEXT UNIQUE NOT NULL,
  class_id                BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
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
  sort_order              INT NOT NULL DEFAULT 0,
  species_id BIGINT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  requires_option_key TEXT NULL,
  requires_option_value TEXT NULL,
  feat_id BIGINT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  item_id BIGINT NULL REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  spell_slug TEXT NULL REFERENCES rpg.phb_spell(slug),
  min_trait_takes INTEGER NOT NULL DEFAULT 1 CHECK (min_trait_takes >= 1),
  heritage_trait_id BIGINT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  thread_slug TEXT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  CONSTRAINT phb_class_economy_action_owner_xor CHECK (
    (class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (class_id IS NULL AND species_id IS NOT NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NOT NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NOT NULL AND heritage_trait_id IS NULL AND thread_slug IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NOT NULL AND thread_slug IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL AND thread_slug IS NOT NULL)
  )
);

CREATE INDEX idx_class_economy_action_class ON rpg.phb_class_economy_action(class_id);
CREATE INDEX idx_class_economy_action_subclass ON rpg.phb_class_economy_action(subclass_id);
CREATE INDEX idx_class_economy_action_heritage_trait
  ON rpg.phb_class_economy_action(heritage_trait_id)
  WHERE heritage_trait_id IS NOT NULL;
CREATE INDEX idx_class_economy_action_thread
  ON rpg.phb_class_economy_action(thread_slug)
  WHERE thread_slug IS NOT NULL;

-- Battle Master (Fighter) maneuvers catalog
