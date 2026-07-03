-- Tabela rpg.player_character (dados de jogador — fora do catálogo PHB)

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE rpg.player_character (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 100),
  level INTEGER NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 20),
  class_slug TEXT NOT NULL REFERENCES rpg.phb_class(slug),
  species_slug TEXT NOT NULL REFERENCES rpg.phb_species(slug),
  background_slug TEXT NOT NULL REFERENCES rpg.phb_background(slug),
  subclass_slug TEXT REFERENCES rpg.phb_subclass(slug),
  alignment_slug TEXT REFERENCES rpg.phb_alignment(slug),
  ability_scores JSONB NOT NULL DEFAULT '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb,
  hit_points_max INTEGER CHECK (hit_points_max IS NULL OR hit_points_max >= 0),
  hit_points_current INTEGER CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_player_character_user_id ON rpg.player_character(user_id);

CREATE TRIGGER tr_player_character_updated_at
  BEFORE UPDATE ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
