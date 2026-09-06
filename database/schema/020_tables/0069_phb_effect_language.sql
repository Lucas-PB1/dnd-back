CREATE TABLE rpg.phb_effect_language (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  language_slug TEXT NULL
    REFERENCES rpg.phb_language(slug),
  option_key TEXT NULL,
  choice_count INTEGER NOT NULL DEFAULT 1 CHECK (choice_count >= 1),
  CONSTRAINT phb_effect_language_target CHECK (
    language_slug IS NOT NULL OR option_key IS NOT NULL
  )
);
