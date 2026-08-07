-- Tabela rpg.phb_starting_package (Lote D: class + background unificados)

CREATE TABLE rpg.phb_starting_package (
  id BIGSERIAL PRIMARY KEY,
  source rpg.starting_package_source NOT NULL,
  owner_id BIGINT NOT NULL,
  slug TEXT NOT NULL,
  label TEXT NOT NULL,
  gold INTEGER CHECK (gold IS NULL OR gold >= 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  UNIQUE (source, owner_id, slug)
);

CREATE INDEX idx_phb_starting_package_source_owner ON rpg.phb_starting_package(source, owner_id);
