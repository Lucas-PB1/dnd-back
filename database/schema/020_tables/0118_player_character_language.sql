CREATE TABLE rpg.player_character_language (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  language_slug TEXT NOT NULL REFERENCES rpg.phb_language(slug),
  PRIMARY KEY (character_id, language_slug)
);

CREATE INDEX idx_player_character_species_choice_character
  ON rpg.player_character_species_choice(character_id);
CREATE INDEX idx_player_character_option_character
  ON rpg.player_character_option(character_id);
CREATE INDEX idx_player_character_option_scope_owner
  ON rpg.player_character_option(character_id, scope, owner_slug);
CREATE INDEX idx_player_character_feat_character
  ON rpg.player_character_feat(character_id);
CREATE INDEX idx_player_character_spell_character
  ON rpg.player_character_spell(character_id);
CREATE INDEX idx_player_character_equipment_character
  ON rpg.player_character_equipment(character_id);
CREATE INDEX idx_player_character_language_character
  ON rpg.player_character_language(character_id);

-- RLS para tabelas de jogador (Supabase â€” requer schema auth)
