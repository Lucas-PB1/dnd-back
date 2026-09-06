CREATE TABLE rpg.player_character_species_choice (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  choice_kind TEXT NOT NULL,
  choice_slug TEXT NOT NULL,
  PRIMARY KEY (character_id, choice_kind)
);
