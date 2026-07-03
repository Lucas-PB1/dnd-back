-- Tabela rpg.phb_source_citation

CREATE TABLE rpg.phb_source_citation (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  edition_id BIGINT NOT NULL REFERENCES rpg.phb_edition(id),
  chapter INTEGER NOT NULL,
  chapter_title TEXT,
  pdf_path TEXT,
  pdf_pages INTEGER[],
  extracted_at TIMESTAMPTZ
);
