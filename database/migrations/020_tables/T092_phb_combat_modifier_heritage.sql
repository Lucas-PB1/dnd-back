-- Combat modifiers: origem heritage_trait (passivos GH).

ALTER TABLE rpg.phb_combat_modifier
  ADD COLUMN IF NOT EXISTS heritage_trait_id BIGINT NULL
    REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE;

ALTER TABLE rpg.phb_combat_modifier
  ADD COLUMN IF NOT EXISTS min_trait_takes INTEGER NOT NULL DEFAULT 1
    CHECK (min_trait_takes >= 1);

ALTER TABLE rpg.phb_combat_modifier
  DROP CONSTRAINT IF EXISTS pcm_kind_fields;

ALTER TABLE rpg.phb_combat_modifier
  ADD CONSTRAINT pcm_kind_fields CHECK (
    (kind = 'hp_bonus' AND second_ability_slug IS NULL
      AND owner_kind IN ('species', 'subclass', 'feat', 'heritage'))
    OR (kind = 'unarmored_defense' AND second_ability_slug IS NOT NULL
      AND flat_bonus = 0 AND per_level_bonus = 0
      AND owner_kind IN ('class', 'subclass'))
  );

ALTER TABLE rpg.phb_combat_modifier
  DROP CONSTRAINT IF EXISTS pcm_heritage_trait_owner;

ALTER TABLE rpg.phb_combat_modifier
  ADD CONSTRAINT pcm_heritage_trait_owner CHECK (
    (owner_kind = 'heritage' AND heritage_trait_id IS NOT NULL AND owner_id = heritage_trait_id)
    OR (owner_kind <> 'heritage' AND heritage_trait_id IS NULL)
  );

CREATE INDEX IF NOT EXISTS idx_phb_combat_modifier_heritage_trait
  ON rpg.phb_combat_modifier(heritage_trait_id)
  WHERE heritage_trait_id IS NOT NULL;
