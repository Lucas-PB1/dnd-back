-- Tabela rpg.phb_hit_die

CREATE TABLE rpg.phb_hit_die (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  sides INTEGER NOT NULL UNIQUE CHECK (sides IN (6, 8, 10, 12)),
  label TEXT NOT NULL
);

INSERT INTO rpg.phb_hit_die (slug, sides, label) VALUES
  ('d6', 6, 'D6'),
  ('d8', 8, 'D8'),
  ('d10', 10, 'D10'),
  ('d12', 12, 'D12');
