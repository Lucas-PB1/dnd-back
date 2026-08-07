-- Dungeoneer slayer types (Fighter subclass)

CREATE TABLE rpg.phb_dungeoneer_slayer_type (
  id          BIGSERIAL PRIMARY KEY,
  slug        TEXT UNIQUE NOT NULL,
  label       TEXT NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_dungeoneer_slayer_type_slug ON rpg.phb_dungeoneer_slayer_type(slug);
