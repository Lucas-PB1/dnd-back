CREATE TABLE rpg.player_character_choice (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  domain rpg.character_choice_domain NOT NULL,
  choice_kind TEXT NOT NULL,
  choice_slug TEXT NOT NULL,
  PRIMARY KEY (character_id, domain, choice_kind)
);

CREATE INDEX idx_player_character_choice_character_domain
  ON rpg.player_character_choice(character_id, domain);

COMMENT ON TABLE rpg.player_character_choice IS
  'Escolhas opacas da ficha por domínio (species / transformation). GEN-2.';
