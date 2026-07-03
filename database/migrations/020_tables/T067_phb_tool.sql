-- Tabela rpg.phb_tool

CREATE TABLE rpg.phb_tool (
  item_id BIGINT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_tool_category(id),
  use_description TEXT
);
