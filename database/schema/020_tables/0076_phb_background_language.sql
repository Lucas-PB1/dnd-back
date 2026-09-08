CREATE TABLE rpg.phb_background_language (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  language_id BIGINT NOT NULL REFERENCES rpg.phb_language(id),
  PRIMARY KEY (background_id, language_id)
);

-- Conjuração por subclasse (Spellslinger etc.)
