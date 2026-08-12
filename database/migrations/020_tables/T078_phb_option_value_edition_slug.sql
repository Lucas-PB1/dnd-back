-- Marca opção de catálogo com edição de origem (ex.: lineages Northlands no Elfo PHB).
-- NULL = herda da espécie-pai / sempre disponível com ela.

ALTER TABLE rpg.phb_option_value
  ADD COLUMN IF NOT EXISTS edition_slug TEXT;
