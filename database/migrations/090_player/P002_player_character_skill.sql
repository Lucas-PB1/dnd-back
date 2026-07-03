-- Perícias escolhidas da pool da classe (PHB skill choice)

CREATE TABLE rpg.player_character_skill (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  skill_slug TEXT NOT NULL REFERENCES rpg.phb_skill(slug),
  PRIMARY KEY (character_id, skill_slug)
);

CREATE INDEX idx_player_character_skill_character
  ON rpg.player_character_skill(character_id);
