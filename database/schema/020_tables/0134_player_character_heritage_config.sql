CREATE TABLE rpg.player_character_heritage_config (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  speed_trade TEXT CHECK (speed_trade IS NULL OR speed_trade IN ('yes', 'no')),
  size_choice TEXT CHECK (size_choice IS NULL OR size_choice IN ('small', 'medium'))
);

COMMENT ON TABLE rpg.player_character_heritage_trait IS
  'Slots 1–8 de traços modulares GH; slot 9 disponível se speed_trade = yes.';

COMMENT ON TABLE rpg.player_character_heritage_config IS
  'Opções de customização GH: trocar 1,5 m por 9º traço; tamanho Pequeno/Médio.';
