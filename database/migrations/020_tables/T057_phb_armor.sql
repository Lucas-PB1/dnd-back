-- Tabela rpg.phb_armor

CREATE TABLE rpg.phb_armor (
  item_id BIGINT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_armor_category(id),
  ac_base INTEGER CHECK (ac_base >= 0),
  ac_formula TEXT,
  strength_req INTEGER CHECK (strength_req >= 0),
  stealth_disadvantage BOOLEAN NOT NULL DEFAULT FALSE
);
