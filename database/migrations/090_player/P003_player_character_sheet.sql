-- Extensões da ficha: espécie, subclasse, feats, magias, equipamento, idiomas

ALTER TABLE rpg.player_character
  ADD COLUMN IF NOT EXISTS ability_generation_method_slug TEXT
    REFERENCES rpg.phb_ability_generation_method(slug);

CREATE TABLE rpg.player_character_species_choice (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  choice_kind TEXT NOT NULL,
  choice_slug TEXT NOT NULL,
  PRIMARY KEY (character_id, choice_kind)
);

CREATE TABLE rpg.player_character_subclass_option (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  PRIMARY KEY (character_id, option_key)
);

CREATE TABLE rpg.player_character_feat (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  feat_slug TEXT NOT NULL REFERENCES rpg.phb_feat(slug),
  PRIMARY KEY (character_id, feat_slug)
);

CREATE TABLE rpg.player_character_spell (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  list_type TEXT NOT NULL CHECK (list_type IN ('known', 'prepared', 'always_prepared')),
  PRIMARY KEY (character_id, spell_slug, list_type)
);

CREATE TABLE rpg.player_character_equipment (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  source TEXT NOT NULL CHECK (source IN ('class', 'background')),
  package_slug TEXT NOT NULL,
  item_slug TEXT REFERENCES rpg.phb_item(slug),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (character_id, source, sort_order)
);

CREATE TABLE rpg.player_character_language (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  language_slug TEXT NOT NULL REFERENCES rpg.phb_language(slug),
  PRIMARY KEY (character_id, language_slug)
);

CREATE INDEX idx_player_character_species_choice_character
  ON rpg.player_character_species_choice(character_id);
CREATE INDEX idx_player_character_subclass_option_character
  ON rpg.player_character_subclass_option(character_id);
CREATE INDEX idx_player_character_feat_character
  ON rpg.player_character_feat(character_id);
CREATE INDEX idx_player_character_spell_character
  ON rpg.player_character_spell(character_id);
CREATE INDEX idx_player_character_equipment_character
  ON rpg.player_character_equipment(character_id);
CREATE INDEX idx_player_character_language_character
  ON rpg.player_character_language(character_id);
