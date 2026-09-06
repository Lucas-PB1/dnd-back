CREATE TABLE rpg.player_character_heritage_trait (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  slot_index INTEGER NOT NULL CHECK (slot_index BETWEEN 1 AND 9),
  trait_id BIGINT NOT NULL REFERENCES rpg.phb_heritage_trait(id),
  PRIMARY KEY (character_id, slot_index)
);

CREATE INDEX idx_player_character_heritage_trait_trait
  ON rpg.player_character_heritage_trait(trait_id);
