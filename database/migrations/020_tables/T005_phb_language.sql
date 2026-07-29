-- Tabela rpg.phb_language

CREATE TABLE rpg.phb_language (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  script TEXT,
  typical_speakers TEXT,
  is_rare BOOLEAN NOT NULL DEFAULT FALSE
);
