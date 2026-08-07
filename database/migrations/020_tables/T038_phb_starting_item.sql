-- Tabela rpg.phb_starting_item (Lote D: itens de pacote inicial unificados)

CREATE TABLE rpg.phb_starting_item (
  id BIGSERIAL PRIMARY KEY,
  package_id BIGINT NOT NULL REFERENCES rpg.phb_starting_package(id) ON DELETE CASCADE,
  item_id BIGINT REFERENCES rpg.phb_item(id),
  choice_text TEXT,
  gold_amount INTEGER CHECK (gold_amount IS NULL OR gold_amount >= 0),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT psi_has_content CHECK (
    item_id IS NOT NULL OR choice_text IS NOT NULL OR gold_amount IS NOT NULL
  )
);
