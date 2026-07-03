-- Inventário do personagem (mochila + equipado)

CREATE TABLE rpg.player_character_item (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  item_slug TEXT NOT NULL REFERENCES rpg.phb_item(slug),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  location TEXT NOT NULL DEFAULT 'backpack' CHECK (location IN ('equipped', 'backpack')),
  equipment_slot TEXT CHECK (
    equipment_slot IS NULL
    OR equipment_slot IN ('armor', 'main_hand', 'off_hand', 'shield')
  ),
  PRIMARY KEY (character_id, item_slug),
  CONSTRAINT player_character_item_slot_when_equipped CHECK (
    (location = 'backpack' AND equipment_slot IS NULL)
    OR (location = 'equipped' AND equipment_slot IS NOT NULL)
  )
);

CREATE INDEX idx_player_character_item_character
  ON rpg.player_character_item(character_id);

CREATE INDEX idx_player_character_item_equipped
  ON rpg.player_character_item(character_id, equipment_slot)
  WHERE location = 'equipped';

-- RLS (Supabase)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character_item RLS — auth schema not present';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character_item ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_item_own ON rpg.player_character_item;
  CREATE POLICY player_character_item_own ON rpg.player_character_item
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;
