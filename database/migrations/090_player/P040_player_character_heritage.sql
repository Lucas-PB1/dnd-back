-- Personagem: origem PHB species XOR herança GH + picks modulares

ALTER TABLE rpg.player_character
  ALTER COLUMN species_slug DROP NOT NULL;

ALTER TABLE rpg.player_character
  ADD COLUMN IF NOT EXISTS heritage_slug TEXT NULL
    REFERENCES rpg.phb_heritage(slug);

ALTER TABLE rpg.player_character
  DROP CONSTRAINT IF EXISTS player_character_origin_xor;

ALTER TABLE rpg.player_character
  ADD CONSTRAINT player_character_origin_xor CHECK (
    (species_slug IS NOT NULL AND heritage_slug IS NULL)
    OR (species_slug IS NULL AND heritage_slug IS NOT NULL)
  );

CREATE INDEX IF NOT EXISTS idx_player_character_heritage_slug
  ON rpg.player_character(heritage_slug)
  WHERE heritage_slug IS NOT NULL;

CREATE TABLE rpg.player_character_heritage_trait (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  slot_index INTEGER NOT NULL CHECK (slot_index BETWEEN 1 AND 9),
  trait_id BIGINT NOT NULL REFERENCES rpg.phb_heritage_trait(id),
  PRIMARY KEY (character_id, slot_index)
);

CREATE INDEX idx_player_character_heritage_trait_trait
  ON rpg.player_character_heritage_trait(trait_id);

CREATE TABLE rpg.player_character_heritage_config (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  speed_trade TEXT CHECK (speed_trade IS NULL OR speed_trade IN ('yes', 'no')),
  size_choice TEXT CHECK (size_choice IS NULL OR size_choice IN ('small', 'medium'))
);

COMMENT ON TABLE rpg.player_character_heritage_trait IS
  'Slots 1–8 de traços modulares GH; slot 9 disponível se speed_trade = yes.';

COMMENT ON TABLE rpg.player_character_heritage_config IS
  'Opções de customização GH: trocar 1,5 m por 9º traço; tamanho Pequeno/Médio.';
