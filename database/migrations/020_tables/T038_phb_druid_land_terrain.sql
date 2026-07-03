-- Tabela rpg.phb_druid_land_terrain

CREATE TABLE rpg.phb_druid_land_terrain (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL
);
