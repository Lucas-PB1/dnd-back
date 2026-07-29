-- Tabela rpg.phb_weapon

CREATE TABLE rpg.phb_weapon (
  item_id BIGINT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category rpg.weapon_category,
  damage TEXT,
  damage_type TEXT,
  mastery_id BIGINT REFERENCES rpg.phb_weapon_mastery(id)
);
