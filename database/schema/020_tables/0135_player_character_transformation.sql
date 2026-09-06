CREATE TABLE rpg.player_character_transformation (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  transformation_slug TEXT NOT NULL REFERENCES rpg.phb_feat(slug),
  stage SMALLINT NOT NULL CHECK (stage BETWEEN 1 AND 4)
);
