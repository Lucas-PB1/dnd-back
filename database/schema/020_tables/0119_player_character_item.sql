CREATE TABLE rpg.player_character_item (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  item_slug TEXT NOT NULL REFERENCES rpg.phb_item(slug),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  location TEXT NOT NULL DEFAULT 'backpack' CHECK (location IN ('equipped', 'backpack')),
  equipment_slot TEXT,
  attuned BOOLEAN NOT NULL DEFAULT FALSE,
  attached_charm_slug TEXT NULL,
  is_pact_weapon BOOLEAN NOT NULL DEFAULT FALSE,
  attached_coverage_slug TEXT NULL,
  attached_coverage_bonus SMALLINT NULL,
  attached_coverage_attuned BOOLEAN NOT NULL DEFAULT FALSE,
  attached_coverage_spell_slug TEXT NULL REFERENCES rpg.phb_spell(slug),
  bound_spell_slug TEXT NULL REFERENCES rpg.phb_spell(slug),
  instance_properties JSONB NULL,
  contained_in_item_slug TEXT NULL,
  PRIMARY KEY (character_id, item_slug),
  CONSTRAINT player_character_item_slot_when_equipped CHECK (
    (location = 'backpack' AND equipment_slot IS NULL)
    OR (location = 'equipped' AND equipment_slot IS NOT NULL)
  ),
  CONSTRAINT player_character_item_equipment_slot_check CHECK (
    equipment_slot IS NULL
    OR equipment_slot IN (
      'armor',
      'main_hand',
      'off_hand',
      'shield',
      'worn',
      'carried'
    )
  ),
  CONSTRAINT player_character_item_attached_charm_slug_check CHECK (
    attached_charm_slug IS NULL
    OR attached_charm_slug LIKE 'weapon-charm-%'
  ),
  CONSTRAINT player_character_item_attached_coverage_bonus_check CHECK (
    attached_coverage_bonus IS NULL
    OR attached_coverage_bonus IN (1, 2, 3)
  ),
  CONSTRAINT player_character_item_attached_coverage_pair_check CHECK (
    (attached_coverage_slug IS NULL AND attached_coverage_bonus IS NULL AND attached_coverage_attuned = FALSE)
    OR (attached_coverage_slug IS NOT NULL)
  ),
  CONSTRAINT player_character_item_attached_coverage_spell_pair_check CHECK (
    attached_coverage_spell_slug IS NULL
    OR attached_coverage_slug IS NOT NULL
  )
);

CREATE INDEX idx_player_character_item_character
  ON rpg.player_character_item(character_id);

CREATE INDEX idx_player_character_item_equipped
  ON rpg.player_character_item(character_id, equipment_slot)
  WHERE location = 'equipped';

CREATE INDEX idx_player_character_item_attuned
  ON rpg.player_character_item(character_id)
  WHERE attuned = TRUE;

-- RLS (Supabase)
