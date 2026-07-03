-- ALTER rpg.phb_background

ALTER TABLE rpg.phb_background
  ADD COLUMN tool_category_id BIGINT REFERENCES rpg.phb_tool_category(id);
