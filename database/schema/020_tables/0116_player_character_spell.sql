CREATE TABLE rpg.player_character_spell (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  list_type TEXT NOT NULL CHECK (list_type IN ('known', 'prepared', 'always_prepared')),
  PRIMARY KEY (character_id, spell_slug, list_type)
);
