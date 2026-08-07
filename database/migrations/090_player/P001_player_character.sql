-- Tabela rpg.player_character (dados de jogador — fora do catálogo PHB)
-- Criticals: ownership FK (auth.users quando existir); subclass ∈ class; HP current ≤ max

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
  ability_generation_method_slug TEXT CHECK (ability_generation_method_slug IS NULL OR ability_generation_method_slug::rpg.ability_generation_method IS NOT NULL),
  ability_scores JSONB NOT NULL DEFAULT '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb,
  hit_points_max INTEGER CHECK (hit_points_max IS NULL OR hit_points_max >= 0),
  hit_points_current INTEGER CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  background_boost_mode TEXT NOT NULL DEFAULT 'plus2plus1' CHECK (background_boost_mode IN ('plus2plus1', 'plus1x3')),
  background_boost_plus2_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  background_boost_plus1_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  background_boost_plus1_slugs TEXT[],
  background_tool_item_slug TEXT REFERENCES rpg.phb_item(slug),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT player_character_hp_current_lte_max CHECK (
    hit_points_current IS NULL
    OR hit_points_max IS NULL
    OR hit_points_current <= hit_points_max
  )
);

CREATE INDEX idx_player_character_user_id ON rpg.player_character(user_id);

CREATE TRIGGER tr_player_character_updated_at
  BEFORE UPDATE ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

-- Invariante: subclass_slug pertence à class_slug (CHECK com subquery não é permitido)
CREATE OR REPLACE FUNCTION rpg.enforce_pc_subclass_belongs_to_class()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.subclass_slug IS NULL THEN
    RETURN NEW;
  END IF;
  IF NOT EXISTS (
    SELECT 1
    FROM rpg.phb_subclass sc
    JOIN rpg.phb_class c ON c.id = sc.class_id
    WHERE sc.slug = NEW.subclass_slug
      AND c.slug = NEW.class_slug
  ) THEN
    RAISE EXCEPTION 'subclass "%" does not belong to class "%"',
      NEW.subclass_slug, NEW.class_slug;
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER tr_player_character_subclass_class
  BEFORE INSERT OR UPDATE OF class_slug, subclass_slug
  ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.enforce_pc_subclass_belongs_to_class();

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character.user_id FK — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.player_character
    ADD CONSTRAINT player_character_user_id_fkey
    FOREIGN KEY (user_id) REFERENCES auth.users(id);
END $$;
