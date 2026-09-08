CREATE TABLE rpg.phb_item_catalog_stats (
  item_slug       TEXT PRIMARY KEY
    REFERENCES rpg.phb_item (slug) ON DELETE CASCADE,
  view_count      BIGINT NOT NULL DEFAULT 0
    CHECK (view_count >= 0),
  purchase_count  BIGINT NOT NULL DEFAULT 0
    CHECK (purchase_count >= 0),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_phb_item_catalog_stats_purchase
  ON rpg.phb_item_catalog_stats (purchase_count DESC);

CREATE INDEX idx_phb_item_catalog_stats_view
  ON rpg.phb_item_catalog_stats (view_count DESC);

COMMENT ON TABLE rpg.phb_item_catalog_stats IS
  'Telemetria de catálogo: visualizações e compras (Beyond shop).';

-- Marca opção de catálogo com edição de origem (ex.: lineages Northlands no Elfo PHB).
-- NULL = herda da espécie-pai / sempre disponível com ela.


-- Pré-requisito: talento(s) já adquiridos.
