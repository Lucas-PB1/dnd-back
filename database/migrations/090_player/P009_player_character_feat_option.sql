-- Escolhas internas de talentos na ficha do jogador

CREATE TABLE rpg.player_character_feat_option (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  feat_slug TEXT NOT NULL REFERENCES rpg.phb_feat(slug),
  instance_index INTEGER NOT NULL DEFAULT 0 CHECK (instance_index >= 0),
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  PRIMARY KEY (character_id, feat_slug, instance_index, option_key)
);

CREATE INDEX idx_player_character_feat_option_character
  ON rpg.player_character_feat_option(character_id);
