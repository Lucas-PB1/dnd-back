CREATE TABLE rpg.player_character_transformation_choice (
  character_id UUID NOT NULL
    REFERENCES rpg.player_character_transformation(character_id) ON DELETE CASCADE,
  choice_kind TEXT NOT NULL,
  choice_slug TEXT NOT NULL,
  PRIMARY KEY (character_id, choice_kind)
);

COMMENT ON TABLE rpg.player_character_transformation IS
  'Transformação GH Cap. 6 ativa na ficha (1:1). Não usar player_character_feat.';

COMMENT ON TABLE rpg.player_character_transformation_choice IS
  'Escolhas opacas da transformação (boons etc.); validadas por J060 quando existir.';
