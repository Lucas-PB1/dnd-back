-- Tabela rpg.phb_edition

CREATE TABLE rpg.phb_edition (
  id           BIGSERIAL PRIMARY KEY,
  slug         TEXT NOT NULL UNIQUE,
  label        TEXT NOT NULL,
  book         TEXT NOT NULL DEFAULT 'Livro do Jogador 2024',
  language     TEXT NOT NULL DEFAULT 'pt-BR',
  extracted_at TIMESTAMPTZ,
  notes        TEXT
);
