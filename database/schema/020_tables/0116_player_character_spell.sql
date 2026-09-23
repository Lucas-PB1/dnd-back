CREATE TABLE rpg.player_character_spell (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  list_type rpg.spell_list_type NOT NULL,
  PRIMARY KEY (character_id, spell_slug, list_type)
);
