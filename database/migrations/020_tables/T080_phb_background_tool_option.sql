-- Whitelist de ferramentas por antecedente (substitui “toda a categoria”)

CREATE TABLE rpg.phb_background_tool_option (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  item_id BIGINT NOT NULL REFERENCES rpg.phb_item(id),
  PRIMARY KEY (background_id, item_id)
);

CREATE INDEX idx_phb_background_tool_option_item
  ON rpg.phb_background_tool_option(item_id);
