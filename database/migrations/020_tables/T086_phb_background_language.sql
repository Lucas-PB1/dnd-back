-- Idiomas fixos concedidos por antecedente + contagem de escolhas (PHB 2024)

ALTER TABLE rpg.phb_background
  ADD COLUMN IF NOT EXISTS language_choice_count INT NOT NULL DEFAULT 0
    CHECK (language_choice_count >= 0);

CREATE TABLE IF NOT EXISTS rpg.phb_background_language (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  language_id BIGINT NOT NULL REFERENCES rpg.phb_language(id),
  PRIMARY KEY (background_id, language_id)
);
