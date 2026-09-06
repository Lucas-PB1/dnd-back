CREATE TABLE rpg.player_character_feat (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  feat_slug TEXT NOT NULL REFERENCES rpg.phb_feat(slug),
  instance_index INTEGER NOT NULL DEFAULT 0 CHECK (instance_index >= 0),
  PRIMARY KEY (character_id, feat_slug, instance_index)
);
