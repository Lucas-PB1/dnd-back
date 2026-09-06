CREATE TABLE rpg.player_character_heritage_config (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  speed_trade TEXT CHECK (speed_trade IS NULL OR speed_trade IN ('yes', 'no')),
  size_choice TEXT CHECK (size_choice IS NULL OR size_choice IN ('small', 'medium'))
);

COMMENT ON TABLE rpg.player_character_heritage_trait IS
  'Slots 1â€“8 de traÃ§os modulares GH; slot 9 disponÃ­vel se speed_trade = yes.';

COMMENT ON TABLE rpg.player_character_heritage_config IS
  'OpÃ§Ãµes de customizaÃ§Ã£o GH: trocar 1,5 m por 9Âº traÃ§o; tamanho Pequeno/MÃ©dio.';
