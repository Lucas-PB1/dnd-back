-- Tabela rpg.phb_background_starting_item

CREATE TABLE rpg.phb_background_starting_item (
  id BIGSERIAL PRIMARY KEY,
  package_id BIGINT NOT NULL REFERENCES rpg.phb_background_starting_package(id) ON DELETE CASCADE,
  item_id BIGINT REFERENCES rpg.phb_item(id),
  choice_text TEXT,
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT pbsi_item_or_choice CHECK (
    item_id IS NOT NULL OR choice_text IS NOT NULL
  )
);
